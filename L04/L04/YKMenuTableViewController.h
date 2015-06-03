//
//  YKMenuTableViewController.h
//  L04
//
//  Created by Amos Wu on 15/6/3.
//
//

#import <UIKit/UIKit.h>
#import "DrawerController.h"

@interface YKMenuTableViewController : UITableViewController<DrawerControllerChild, DrawerControllerPresenting>

@property (nonatomic, weak) DrawerController *drawer;

- (id)initWithMenus:(NSArray *)menus;

@end
