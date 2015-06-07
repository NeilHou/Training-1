//
//  YKDetailViewController.h
//  L05_Amos
//
//  Created by Amos Wu on 15/6/1.
//  Copyright (c) 2015年 Amos Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGlobal.h"

@class YKMovie;

@interface YKDetailViewController : UIViewController

@property(nonatomic, strong) NSMutableArray *alternativeArray;
@property(nonatomic, strong) NSMutableArray *castsArray;
@property(nonatomic, strong) YKMovie *movie;

@end
