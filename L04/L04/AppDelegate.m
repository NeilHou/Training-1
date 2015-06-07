//
//  AppDelegate.m
//  L04
//
//  Created by Hanguang on 5/20/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "YKDetailViewController.h"
#import "DrawerController.h"
#import "YKMenuTableViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) UIViewController *vc;

@end

NSArray* MenuArray = nil;
void BuildMenuArray()
{
    MenuArray = [NSArray arrayWithObjects:@"正在上映", @"即将上映", @"最为流行", @"近期高分", @"搜索结果", @"我的收藏", nil];
}

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BuildMenuArray();
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    
    ViewController *tableViewController = [[ViewController alloc] init];
    YKMenuTableViewController *menusVC = [YKMenuTableViewController new];
    
    DrawerController *drawer = [[DrawerController alloc] initWithLeftViewController:menusVC centerViewController:tableViewController];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:drawer];
    
#pragma mark - 设置navigationItem相关属性
    drawer.navigationItem.title = MenuArray[0];
    UIImage *muneIcon = [UIImage imageNamed:@"menu-24.png"];
    UIImage *homeIcon = [UIImage imageNamed:@"home-25.png"];
    
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithImage:homeIcon style:UIBarButtonItemStylePlain target:tableViewController  action:@selector(returnToHome)];
    drawer.navigationItem.rightBarButtonItem = rightbutton;
    
    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithImage:muneIcon style:UIBarButtonItemStylePlain target:tableViewController action:@selector(openDrawer:)];
    drawer.navigationItem.leftBarButtonItem = leftbutton;
    
    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
