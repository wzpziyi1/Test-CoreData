//
//  ZYItem+CoreDataProperties.m
//  Grocery
//
//  Created by 王志盼 on 2016/10/25.
//  Copyright © 2016年 王志盼. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "ZYItem+CoreDataProperties.h"

@implementation ZYItem (CoreDataProperties)

+ (NSFetchRequest<ZYItem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Item"];
}

@dynamic collected;
@dynamic listed;
@dynamic name;
@dynamic photoData;
@dynamic quantity;
@dynamic unit;

@end
