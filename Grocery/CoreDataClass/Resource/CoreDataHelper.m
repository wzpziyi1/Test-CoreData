//
//  CoreDataHelper.m
//  coreData
//
//  Created by 王志盼 on 2016/10/9.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "CoreDataHelper.h"
#import "CoreDataHelper.h"
#import "ZYMigrationVc.h"

@implementation CoreDataHelper
#define debug 1

#pragma mark - FILES
NSString *storeFilename = @"coreData.sqlite";

#pragma mark - PATHS

- (NSString *)applicationDocumentsDirectory
{
    if (debug == 1)
    {
        NSLog(@"Runing %@ %@", self.class, NSStringFromSelector(_cmd));
    }
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSURL *)applicationStoresDirectory
{
    if (debug == 1)
    {
        NSLog(@"Runing %@ %@", self.class, NSStringFromSelector(_cmd));
    }
    
    NSURL *storesDirectory = [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]] URLByAppendingPathComponent:@"Stores"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:[storesDirectory path]])
    {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory
                         withIntermediateDirectories:YES
                         attributes:nil
                         error:&error])
        {
            if (debug == 1)
            {
                NSLog(@"Create Successfuly");
            }
            else
            {
                NSLog(@"Failed to create Store :  %@", error);
            }
        }
        
    }
    return storesDirectory;
}

- (NSURL *)storeUrl
{
    if (debug == 1)
    {
        NSLog(@"Runing %@ %@", self.class, NSStringFromSelector(_cmd));
    }
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

#pragma mark - SETUP
- (instancetype)init
{
    if (debug == 1)
    {
        NSLog(@"Runing %@ %@", self.class, NSStringFromSelector(_cmd));
    }
    
    if (self = [super init])
    {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:_coordinator];
    }
    return self;
}

- (void)loadStore
{
    if (debug == 1)
    {
        NSLog(@"Runing %@ %@", self.class, NSStringFromSelector(_cmd));
    }
    
    if (_store) return;
    
    //是否开启手动迁移，显示迁移进度
    BOOL useMigrationManager = NO;
    
    if (useMigrationManager)
    {
        [self isMigrationNecessaryForStore:[self storeUrl]];
        [self performBackgroundManagedMigrationForStore:[self storeUrl]];
    }
    else
    {
        NSError *error = nil;
        NSDictionary *options = @{
                                  //轻量级迁移
                                  NSMigratePersistentStoresAutomaticallyOption : @YES,
                                  NSInferMappingModelAutomaticallyOption: @YES,
                                  NSSQLitePragmasOption: @{@"journal_mode" : @"DELETE"}
                                  };
        _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                            configuration:nil
                                                      URL:[self storeUrl]
                                                  options:options
                                                    error:&error];
        
        if (!_store)
        {
            NSLog(@"Failed to add store. Error: %@", error);
        }
        else
        {
            if (debug == 1)
            {
                NSLog(@"Successfully added store: %@", _store);
            }
        }
    }
    
    
}

- (void)setupCoreData
{
    if (debug == 1)
    {
        NSLog(@"Runing %@ %@", self.class, NSStringFromSelector(_cmd));
    }
    [self loadStore];
}

#pragma mark - SAVING

- (void)saveContext
{
    if (debug == 1)
    {
        NSLog(@"Runing %@ %@", self.class, NSStringFromSelector(_cmd));
    }
    
    if ([_context hasChanges])
    {
        NSError *error = nil;
        if ([_context save:&error])
        {
            NSLog(@"_context saved change to persistent store");
        }
        else
        {
            NSLog(@"Failed to save _context: %@,", error);
            [self showValidationError:error];
        }
    }
    else
    {
        NSLog(@"skipped _context save, there are no changes!");
    }
    
}

#pragma mark ---- Migration Wanager
- (BOOL)isMigrationNecessaryForStore:(NSURL *)storeUrl
{
    if (debug == 1)
    {
        NSLog(@"Running  %@  '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self storeUrl].path])
    {
        if (debug == 1)
        {
            NSLog(@"Skipped Migration: Source database missing");
        }
        return NO;
    }
    
    NSError *error = nil;
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator
                                    metadataForPersistentStoreOfType:NSSQLiteStoreType
                                                                 URL:storeUrl
                                                               error:&error];
    
    NSManagedObjectModel *destinationModel = self.coordinator.managedObjectModel;
    
    if ([destinationModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata])
    {
        if (debug == 1)
        {
            NSLog(@"Skipped Migration: Source is already Compatible");
            return 0;
        }
    }
    return YES;
    
}

- (BOOL)migrateStore:(NSURL *)sourceStore
{
    if (debug == 1)
    {
        NSLog(@"Running %@  '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    BOOL success = NO;
    NSError *error = nil;
    
    //第一步，收集执行数据迁移所需要的信息
        //源模型
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator
                                    metadataForPersistentStoreOfType:NSSQLiteStoreType
                                                                 URL:sourceStore
                                                               error:&error];
    NSManagedObjectModel *sourceModel = [NSManagedObjectModel mergedModelFromBundles:nil forStoreMetadata:sourceMetadata];
        //目标模型
    NSManagedObjectModel *destinModel = self.model;
        //映射模型
    NSMappingModel *mappingModel = [NSMappingModel mappingModelFromBundles:nil
                                                            forSourceModel:sourceModel
                                                          destinationModel:destinModel];
    
    
    //第二步，实际迁移，先用源模型与目标模型创建NSMigrationManager实例，然后在调用migrateStoreFromURL前，把目标存储区备份好（该目标存储区只是为了迁移而设置的临时存储区）
    
    if (mappingModel)
    {
        NSError *error = nil;
        NSMigrationManager *migrationManager = [[NSMigrationManager alloc] initWithSourceModel:sourceModel destinationModel:destinModel];
        
        [migrationManager addObserver:self
                           forKeyPath:@"migrationProgress"
                              options:NSKeyValueObservingOptionNew
                              context:nil];
        
        
        NSURL *destinStore = [[self applicationStoresDirectory] URLByAppendingPathComponent:@"Temp.sqlite"];
        success = [migrationManager migrateStoreFromURL:sourceStore
                                                   type:NSSQLiteStoreType
                                                options:nil
                                       withMappingModel:mappingModel
                                       toDestinationURL:destinStore
                                        destinationType:NSSQLiteStoreType
                                     destinationOptions:nil
                                                  error:&error];
        
        if (success)
        {
            //第三步，迁移后，清除旧的存储区。把新的存储区放到原来目录下，名字与旧的存储区相同
            if ([self replaceStore:sourceStore withStore:destinStore])
            {
                if (debug == 1)
                {
                    NSLog(@"Successfuly migrated %@ to the current model", sourceStore.path);
                }
                //迁移完，移除kvo
                [migrationManager removeObserver:self forKeyPath:@"migrationProgress"];
            }
            else
            {
                if (debug == 1)
                {
                    NSLog(@"Failed migration: %@", error);
                }
            }
        }
        else
        {
            if (debug == 1)
            {
                NSLog(@"Failed Migration: Mapping Model is null");
            }
        }
    }
    
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"migrationProgress"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            double progress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
            self.migrationVc.progressView.progress = progress;
            int percentage = progress * 100;
            self.migrationVc.progressLabel.text = [NSString stringWithFormat:@"迁移进度：%d%%", percentage];
        });
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (BOOL)replaceStore:(NSURL *)old withStore:(NSURL *)new
{
    BOOL success = NO;
    NSError *error = nil;
    
    if ([[NSFileManager defaultManager] removeItemAtURL:old error:&error])
    {
        error = nil;
        
        if ([[NSFileManager defaultManager] moveItemAtURL:new
                                                    toURL:old
                                                    error:&error])
        {
            success = YES;
        }
        else
        {
            if (debug == 1)
            {
                NSLog(@"Failed to re-home new store %@", error);
            }
        }
        
    }
    else
    {
        if (debug == 1)
        {
            NSLog(@"Failed to remove old store %@:   error: %@", old, error);
        }
    }
    
    return success;
}


- (void)performBackgroundManagedMigrationForStore:(NSURL *)storeURL
{
    if (debug == 1)
    {
        NSLog(@"Running %@  '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL done = [self migrateStore:storeURL];
        if (done)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *error = nil;
                _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                    configuration:nil
                                                              URL:[self storeUrl]
                                                          options:nil
                                                            error:&error];
                
                if (!_store)
                {
                    NSLog(@"Failed to add a migrated store. Error : %@", error);
                    abort();
                }
                else
                {
                    NSLog(@"Successfully add a migrated store");
                    _migrationVc = nil;
                }
            });
            
            
            
        }
    });
}

#pragma mark - 错误捕获

- (void)showValidationError:(NSError *)anError
{
    if (anError && [anError.domain isEqualToString:@"NSCocoaErrorDomain"])
    {
        NSArray *errors = nil;
        NSString *txt = @"";
        
        if (anError.code == NSValidationMultipleErrorsError)
        {
            errors = [anError.userInfo objectForKey:NSDetailedErrorsKey];
        }
        else
        {
            errors = [NSArray arrayWithObject:anError];
        }
        
        if (errors && errors.count > 0)
        {
            for (NSError *error in errors)
            {
                NSString *entity = [[error.userInfo[@"NSValidationErrorObject"] entity] name];
                
                NSString *property = error.userInfo[@"NSValidationErrorKey"];
                
                switch (error.code)
                {
                    case NSValidationRelationshipDeniedDeleteError:
                        txt = [txt stringByAppendingFormat:@"%@ delete was denied because there are associated %@\n(Error Code %li)\n\n", entity, property, (long)error.code];
                        break;
                        
                    case NSValidationRelationshipLacksMinimumCountError:
                        txt = [txt stringByAppendingFormat:@"the '%@' relationship count is too small (code %li)", property, (long)error.code];
                        break;
                        
                    case NSValidationRelationshipExceedsMaximumCountError:
                        txt = [txt stringByAppendingFormat:@"the '%@' relationship count is too large (code %li)", property, (long)error.code];
                        break;
                        
                    case NSValidationMissingMandatoryPropertyError:
                        txt = [txt stringByAppendingFormat:@"the '%@' property is missing (code %li)", property, (long)error.code];
                        break;
                        
                    case NSValidationNumberTooSmallError:
                        txt = [txt stringByAppendingFormat:@"the '%@' number is too small (code %li)", property, (long)error.code];
                        break;
                        
                    case NSValidationNumberTooLargeError:
                        txt = [txt stringByAppendingFormat:@"the '%@' number is too large (code %li)", property, (long)error.code];
                        break;
                    
                    case NSValidationDateTooSoonError:
                        txt = [txt stringByAppendingFormat:@"the '%@' date is too soon (code %li)", property, (long)error.code];
                        break;
                        
                    case NSValidationDateTooLateError:
                        txt = [txt stringByAppendingFormat:@"the '%@' date is too late (code %li)", property, (long)error.code];
                        break;
                        
                    case NSValidationInvalidDateError:
                        txt = [txt stringByAppendingFormat:@"the '%@' date is invalid (code %li)", property, (long)error.code];
                        break;
                        
                    case NSValidationStringTooLongError:
                        txt = [txt stringByAppendingFormat:@"the '%@' text is too long (code %li)", property, (long)error.code];
                        break;
                        
                    case NSValidationStringTooShortError:
                        txt = [txt stringByAppendingFormat:@"the '%@' text is too short (code %li)", property, (long)error.code];
                        break;
                        
                    case NSValidationStringPatternMatchingError:
                        txt = [txt stringByAppendingFormat:@"the '%@' text doesn't match the specified patten (code %li)", property, (long)error.code];
                        break;
                        
                    case NSManagedObjectValidationError:
                        txt = [txt stringByAppendingFormat:@"generated validation error (code %li)", (long)error.code];
                        break;
                        
                    default:
                        txt = [txt stringByAppendingFormat:@"Unhandled error code %li in showValidationError method", (long)error.code];
                        break;
                }
            }
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:txt delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
}


- (ZYMigrationVc *)migrationVc
{
    if (!_migrationVc)
    {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        _migrationVc = (ZYMigrationVc *)keyWindow.rootViewController;
    }
    return _migrationVc;
}
@end
