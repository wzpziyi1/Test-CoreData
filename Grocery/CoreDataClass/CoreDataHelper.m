//
//  CoreDataHelper.m
//  coreData
//
//  Created by 王志盼 on 2016/10/9.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "CoreDataHelper.h"
#import "CoreDataHelper.h"

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
        if ([fileManager createDirectoryAtURL:storesDirectory withIntermediateDirectories:YES attributes:nil error:&error])
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
    
    NSError *error = nil;
    NSDictionary *options = @{
                              //轻量级迁移
                              NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption: @YES,
                              NSSQLitePragmasOption: @{@"journal_mode" : @"DELETE"}
                              };
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeUrl] options:options error:&error];
    
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
        }
    }
    else
    {
        NSLog(@"skipped _context save, there are no changes!");
    }
    
}

@end
