//
//  ZYCoreDataTVc.m
//  Grocery
//
//  Created by 王志盼 on 2016/12/20.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "ZYCoreDataTVc.h"

#define debug 1

@interface ZYCoreDataTVc ()

@end

@implementation ZYCoreDataTVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

#pragma mark - Fetching

- (void)performFetch
{
    if (debug == 1)
    {
        NSLog(@"Running %@   '%@'", [self class], NSStringFromSelector(_cmd));
    }
    
    if (self.frc)
    {
        [self.frc.managedObjectContext performBlockAndWait:^{
            
        }];
    }
}


@end
