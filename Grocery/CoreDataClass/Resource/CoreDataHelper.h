//
//  CoreDataHelper.h
//  coreData
//
//  Created by 王志盼 on 2016/10/9.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZYMigrationVc;
@interface CoreDataHelper : NSObject
@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStore *store;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;

@property (nonatomic, strong) ZYMigrationVc *migrationVc;

- (void)setupCoreData;
- (void)saveContext;

// 判断是否需要迁移
- (BOOL)isMigrationNecessaryForStore:(NSURL *)storeUrl;
@end
