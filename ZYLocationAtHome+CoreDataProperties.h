//
//  ZYLocationAtHome+CoreDataProperties.h
//  Grocery
//
//  Created by 王志盼 on 2016/12/20.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYLocationAtHome+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZYLocationAtHome (CoreDataProperties)

+ (NSFetchRequest<ZYLocationAtHome *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *storedIn;
@property (nullable, nonatomic, retain) NSSet<ZYItem *> *items;

@end

@interface ZYLocationAtHome (CoreDataGeneratedAccessors)

- (void)addItemsObject:(ZYItem *)value;
- (void)removeItemsObject:(ZYItem *)value;
- (void)addItems:(NSSet<ZYItem *> *)values;
- (void)removeItems:(NSSet<ZYItem *> *)values;

@end

NS_ASSUME_NONNULL_END
