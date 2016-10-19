//
//  ZYAmount+CoreDataProperties.m
//  Grocery
//
//  Created by 王志盼 on 2016/10/19.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYAmount+CoreDataProperties.h"

@implementation ZYAmount (CoreDataProperties)

+ (NSFetchRequest<ZYAmount *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ZYAmount"];
}

@dynamic xyz;

@end
