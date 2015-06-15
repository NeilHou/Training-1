//
//  YKSearchViewController.h
//  L04
//
//  Created by Amos Wu on 15/6/12.
//
//

#import <UIKit/UIKit.h>
#import "YKProtocolDelegate.h"

@class YKMovie;

@interface YKSearchViewController : UIViewController

@property(nonatomic, strong) YKMovie *movie;
@property (nonatomic, retain) UISearchBar *searchBar;

@property (nonatomic, weak) id<YKProtocolDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic) BOOL isPush;

@end
