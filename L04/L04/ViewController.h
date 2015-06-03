//
//  ViewController.h
//  L04
//
//  Created by Hanguang on 5/20/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawerController.h"

@interface ViewController : UIViewController<DrawerControllerChild, DrawerControllerPresenting>
{
    NSMutableArray *_detaildataArray;
    NSMutableArray *_searchDataArray;
}

@property(nonatomic, weak) DrawerController *drawer;

@end

