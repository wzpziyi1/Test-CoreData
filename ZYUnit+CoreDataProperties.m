//
//  ZYUnit+CoreDataProperties.m
//  Grocery
//
//  Created by 王志盼 on 2016/10/24.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYUnit+CoreDataProperties.h"

@implementation ZYUnit (CoreDataProperties)

+ (NSFetchRequest<ZYUnit *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ZYUnit"];
}

@dynamic name;

@end
