//
//  ZYUnit+CoreDataProperties.h
//  Grocery
//
//  Created by 王志盼 on 2016/10/24.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYUnit+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZYUnit (CoreDataProperties)

+ (NSFetchRequest<ZYUnit *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
