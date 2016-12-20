//
//  ZYLocationAtShop+CoreDataProperties.h
//  Grocery
//
//  Created by 王志盼 on 2016/12/20.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYLocationAtShop+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZYLocationAtShop (CoreDataProperties)

+ (NSFetchRequest<ZYLocationAtShop *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *aisle;
@property (nullable, nonatomic, retain) ZYItem *items;

@end

NS_ASSUME_NONNULL_END
