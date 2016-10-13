//
//  ZYMeasuerment+CoreDataProperties.m
//  Grocery
//
//  Created by 王志盼 on 2016/10/12.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYMeasuerment+CoreDataProperties.h"

@implementation ZYMeasuerment (CoreDataProperties)

+ (NSFetchRequest<ZYMeasuerment *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ZYMeasurement"];
}

@dynamic abc;

@end
