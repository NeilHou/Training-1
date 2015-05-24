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

- (void)viewDidLoad {
    self.student.age = @"100";
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
