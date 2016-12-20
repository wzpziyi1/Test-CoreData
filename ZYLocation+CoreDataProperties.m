//
//  ZYLocation+CoreDataProperties.m
//  Grocery
//
//  Created by 王志盼 on 2016/12/20.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYLocation+CoreDataProperties.h"

@implementation ZYLocation (CoreDataProperties)

+ (NSFetchRequest<ZYLocation *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ZYLocation"];
}

@dynamic summary;

@end
