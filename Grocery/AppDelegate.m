//
//  AppDelegate.m
//  Grocery
//
//  Created by 王志盼 on 2016/10/11.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataHelper.h"
#import "ZYItem+CoreDataClass.h"
#import "ZYItem+CoreDataProperties.h"

@interface AppDelegate ()
@property (nonatomic, strong) CoreDataHelper *helper;
@end



@implementation AppDelegate
#define debug 1

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self.helper saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self helper];
    [self demo];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.helper saveContext];
}

#pragma mark ---- private

- (void)demo
{
    
    if (debug == 1)
    {
        NSLog(@"Runing %@ %@", self.class, NSStringFromSelector(_cmd));
    }
    
//    NSArray *newItemNames = @[@"Apples", @"Milk", @"Bread", @"Cheese", @"Sausages", @"Butter", @"Orange Juice", @"Cereal", @"Coffee", @"Eggs", @"Tomatoes", @"Fish"];
    //插入数据
//
//    for (NSString *itemName in newItemNames)
//    {
//        ZYItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"ZYItem" inManagedObjectContext:self.helper.context];
//        item.name = itemName;
//        NSLog(@"Inserted New Managed Object for '%@'", item.name);
//    }
    
    
    //排序数据
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ZYItem"];
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//    [request setSortDescriptors:@[sort]];
//    NSArray *objects = [self.helper.context executeFetchRequest:request error:nil];
//    
//    for (ZYItem *item in objects)
//    {
//        NSLog(@"Fetched Object = %@", item.name);
//    }
    
    //包含某个字符串
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ZYItem"];
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//    [request setSortDescriptors:@[sort]];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@", @"e"];
//    [request setPredicate:predicate];
//    
//    NSArray *fetchedObjects = [self.helper.context executeFetchRequest:request error:nil];
//    
//    for (ZYItem *item in fetchedObjects)
//    {
//        NSLog(@"Fetched Pbject = %@", item.name);
//    }
    
    //删除，注意，此时并未永久删除，还需调用context 的 save:  方法
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ZYItem"];
//    NSArray *fetchObjects = [self.helper.context executeFetchRequest:request error:nil];
//    
//    for (ZYItem *item in fetchObjects)
//    {
//        [self.helper.context deleteObject:item];
//    }
    
}

#pragma mark ---- getter && setter
- (CoreDataHelper *)helper
{
    if (!_helper)
    {
        _helper = [[CoreDataHelper alloc] init];
        [_helper setupCoreData];
    }
    return _helper;
}
@end
