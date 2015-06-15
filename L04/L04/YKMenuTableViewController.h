//
//  YKMenuTableViewController.h
//  L04
//
//  Created by Amos Wu on 15/6/3.
//
//

#import <UIKit/UIKit.h>
#import "DrawerController.h"
#import "UIGlobal.h"

@class ViewController;

@interface YKMenuTableViewController : UITableViewController<DrawerControllerChild, DrawerControllerPresenting>

@property (nonatomic, weak) DrawerController *drawer;
@property (nonatomic, weak) ViewController *VC;
@property (nonatomic, strong) NSArray *menus1;
@property (nonatomic, strong) NSArray *menus2;
@property (nonatomic, strong) NSString *movieURL;

@end
