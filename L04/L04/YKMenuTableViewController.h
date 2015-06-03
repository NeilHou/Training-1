//
//  YKMenuTableViewController.h
//  L04
//
//  Created by Amos Wu on 15/6/3.
//
//

#import <UIKit/UIKit.h>
#import "DrawerController.h"
#import "ViewController.h"

@interface YKMenuTableViewController : UITableViewController<DrawerControllerChild, DrawerControllerPresenting>

@property (nonatomic, weak) DrawerController *drawer;
//@property (nonatomic, strong) ViewController *vc;
@property (nonatomic, strong) NSArray *menus;

- (id)initWithMenus:(NSArray *)menus;

@end
