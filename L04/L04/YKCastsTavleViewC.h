//
//  YKCastsTavleViewC.h
//  L04
//
//  Created by Amos Wu on 15/6/7.
//
//

#import <UIKit/UIKit.h>

@interface YKCastsTavleViewC : UITableViewController
@property (strong, nonatomic) id movies;
- (void) reloadCastsData:(id)movies;
@end
