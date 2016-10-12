//
//  ZYItem+CoreDataProperties.h
//  Grocery
//
//  Created by 王志盼 on 2016/10/11.
//  Copyright © 2016年 王志盼. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "ZYItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZYItem (CoreDataProperties)

+ (NSFetchRequest<ZYItem *> *)fetchRequest;

@property (nonatomic) BOOL collected;
@property (nonatomic) BOOL listed;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSData *photoData;
@property (nullable, nonatomic, copy) NSNumber *quantity;

@end

NS_ASSUME_NONNULL_END
