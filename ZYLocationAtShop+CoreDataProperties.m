//
//  ZYLocationAtShop+CoreDataProperties.m
//  Grocery
//
//  Created by 王志盼 on 2016/12/20.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYLocationAtShop+CoreDataProperties.h"

@implementation ZYLocationAtShop (CoreDataProperties)

+ (NSFetchRequest<ZYLocationAtShop *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ZYLocationAtShop"];
}

@dynamic aisle;
@dynamic items;

@end
