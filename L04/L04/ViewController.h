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
#import "YKProtocolDelegate.h"

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
@property (nonatomic, strong) YKMovie *movie;

@property (nonatomic, strong) UITableView *tableView;

- (void)loadReviews: (NSString *)movieURL;
//- (void)returnToHome;
- (void)popToSearchvc;
- (void)openDrawer:(id)sender;
- (void)loadTheCellData:(YKMovie *)movie;

@end

