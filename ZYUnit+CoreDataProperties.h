//
//  ZYUnit+CoreDataProperties.h
//  Grocery
//
//  Created by 王志盼 on 2016/10/25.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYUnit+CoreDataClass.h"



NS_ASSUME_NONNULL_BEGIN

@class ZYItem;

@interface ZYUnit (CoreDataProperties)

+ (NSFetchRequest<ZYUnit *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<ZYItem *> *items;

@end

@interface ZYUnit (CoreDataGeneratedAccessors)

- (void)addItemsObject:(ZYItem *)value;
- (void)removeItemsObject:(ZYItem *)value;
- (void)addItems:(NSSet<ZYItem *> *)values;
- (void)removeItems:(NSSet<ZYItem *> *)values;

@end

NS_ASSUME_NONNULL_END
