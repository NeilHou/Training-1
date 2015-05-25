//
//  DetailViewController.m
//  L04
//
//  Created by MrMessy on 15/5/23.
//  Copyright (c) 2015年 Hanguang. All rights reserved.
//

#import "DetailViewController.h"
#import "Student.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;


@end

@implementation DetailViewController

- (IBAction)Back:(UIButton *)sender {
    NSLog(@"教练，我想回到上一层");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    //将title赋值为学生名字
    Student *student = self.student;
    self.student.age = @"520";
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = student.name;
    
    //创建left button
    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithTitle:@"换个颜色" style:UIBarButtonItemStylePlain target:self action: @selector  (changeTextColor)];
    
    self.navigationItem.leftBarButtonItem = leftbutton;
    //开启左划返回
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //同时添加返回键
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)changeTextColor
{
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    self.nameLabel.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.8];
    self.ageLabel.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.8];
    self.classLabel.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.8];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    Student *student = self.student;
    
    self.nameLabel.text = student.name;
    [self.nameLabel sizeToFit];
    
    self.ageLabel.text = student.age;
    [self.ageLabel sizeToFit];
    
    self.classLabel.text = student.studentClass;
    [self.classLabel sizeToFit];
    
    self.idLabel.text = student.studentId;
    [self.idLabel sizeToFit];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@",[NSDate date]];
    [self.dateLabel sizeToFit];
    
    self.image.image = student.image;
    

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"Student age: %@", self.student.age);
    self.navigationController.navigationBarHidden = YES;
}

@end
