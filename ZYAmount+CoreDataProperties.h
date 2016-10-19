//
//  ZYAmount+CoreDataProperties.h
//  Grocery
//
//  Created by 王志盼 on 2016/10/19.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYAmount+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZYAmount (CoreDataProperties)

+ (NSFetchRequest<ZYAmount *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *xyz;

@end

NS_ASSUME_NONNULL_END
