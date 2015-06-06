//
//  ViewController.h
//  L04
//
//  Created by Hanguang on 5/20/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKJsonData.h"
#import "DrawerController.h"
#import "UIGlobal.h"

@class YKMenuTableViewController;
@class DrawerController;

@interface ViewController : UIViewController<DrawerControllerChild, DrawerControllerPresenting>
{
    NSMutableArray *_detaildataArray;
    NSMutableArray *_searchDataArray;
}

@property (nonatomic, weak) DrawerController *drawer;
@property (nonatomic, strong) YKJsonData *jsonInit;
@property (nonatomic, strong) YKMenuTableViewController *menu;

@property (nonatomic, strong) NSArray *menus;
@property (nonatomic, strong) UITableView *tableView;

- (void)loadReviews;
- (void)returnToHome;
- (void)openDrawer:(id)sender;
@end

