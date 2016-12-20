//
//  ZYLocationAtHome+CoreDataProperties.m
//  Grocery
//
//  Created by 王志盼 on 2016/12/20.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYLocationAtHome+CoreDataProperties.h"

@implementation ZYLocationAtHome (CoreDataProperties)

+ (NSFetchRequest<ZYLocationAtHome *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ZYLocationAtHome"];
}

@dynamic storedIn;
@dynamic items;

@end
