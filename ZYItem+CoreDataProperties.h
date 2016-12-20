//
//  ZYItem+CoreDataProperties.h
//  Grocery
//
//  Created by 王志盼 on 2016/12/20.
//  Copyright © 2016年 王志盼. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "ZYItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@class ZYUnit, ZYLocationAtHome, ZYLocationAtShop;

@interface ZYItem (CoreDataProperties)

+ (NSFetchRequest<ZYItem *> *)fetchRequest;

@property (nonatomic) BOOL collected;
@property (nonatomic) BOOL listed;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSData *photoData;
@property (nullable, nonatomic, copy) NSNumber *quantity;
@property (nullable, nonatomic, retain) ZYUnit *unit;
@property (nullable, nonatomic, retain) ZYLocationAtHome *loactionAtHome;
@property (nullable, nonatomic, retain) ZYLocationAtShop *locationAtStop;

@end

NS_ASSUME_NONNULL_END
