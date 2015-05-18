//
//  ViewController.m
//  L03
//
//  Created by Hanguang on 5/18/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import "ViewController.h"
#import "LHUiview.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    LHUiview *labelView = [[LHUiview alloc] initWithFrame:CGRectMake(10, 10, 160, 160)];
//    [self.scrollView addSubview:labelView];
//    labelView.backgroundColor = [UIColor greenColor];
//    
//    //
//    CGRect scrollViewBounds = self.scrollView.bounds;
//    CGRect labelViewFrame = labelView.frame;
//    
//    // Calc width and height
//    CGFloat labelX = (scrollViewBounds.size.width - labelViewFrame.size.width) / 2;
//    CGFloat labelY = (scrollViewBounds.size.height - labelViewFrame.size.height) / 2;
//    
//    // Set the XY to labelView
//    CGRect newFrame = CGRectMake(labelX, labelY,
//                                 labelViewFrame.size.width, labelViewFrame.size.height);
//    
//    labelView.frame = newFrame;
//    
//    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    numberLabel.text = @"1";
//    [labelView addSubview:numberLabel];
//    
//    CGRect numberViewBounds = labelView.bounds;
//    CGRect numberViewFrame = numberLabel.frame;
//
//    CGFloat labelX1 = (numberViewBounds.size.width - numberViewFrame.size.width) / 2;
//    CGFloat labelY1 = (numberViewBounds.size.height - numberViewFrame.size.height) / 2;
//    
//    
//    CGRect viewFrame = CGRectMake(labelX1, labelY1,
//                                 numberViewFrame.size.width, numberViewFrame.size.height);
//    
//    numberLabel.frame = viewFrame;
    
    // Scrollview
    
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
