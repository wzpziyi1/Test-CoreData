//
//  ZYMeasuerment+CoreDataProperties.h
//  Grocery
//
//  Created by 王志盼 on 2016/10/12.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYMeasuerment+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZYMeasuerment (CoreDataProperties)

+ (NSFetchRequest<ZYMeasuerment *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *abc;

@end

NS_ASSUME_NONNULL_END
