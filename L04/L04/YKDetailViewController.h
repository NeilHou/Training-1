//
//  YKDetailViewController.h
//  L05_Amos
//
//  Created by Amos Wu on 15/6/1.
//  Copyright (c) 2015年 Amos Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKJsonData.h"
@class YKMovie;

@interface YKDetailViewController : UIViewController
{
    NSArray *alternativeArray;
}
@property(nonatomic, strong) YKMovie *movie;
@property(nonatomic, strong) YKJsonData *jsonData;
@property(nonatomic, strong) UIScrollView *scrollView;

- (NSArray *)alternativeArray;
@end
