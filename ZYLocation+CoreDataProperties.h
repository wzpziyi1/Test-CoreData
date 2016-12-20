//
//  ZYLocation+CoreDataProperties.h
//  Grocery
//
//  Created by 王志盼 on 2016/12/20.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYLocation+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZYLocation (CoreDataProperties)

+ (NSFetchRequest<ZYLocation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *summary;

@end

NS_ASSUME_NONNULL_END
