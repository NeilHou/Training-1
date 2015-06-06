//
//  YKAlternativeTableViewController.h
//  L04
//
//  Created by Amos Wu on 15/6/4.
//
//

#import <UIKit/UIKit.h>
#import "UIGlobal.h"

@interface YKAlternativeTableViewController : UITableViewController

@property (strong, nonatomic) id movies;

- (void) reloadAlternativeData: (id) movies;

@end
