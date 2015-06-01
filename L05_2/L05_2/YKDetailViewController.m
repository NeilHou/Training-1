//
//  YKDetailViewController.m
//  L05_Amos
//
//  Created by Amos Wu on 15/6/1.
//  Copyright (c) 2015年 Amos Wu. All rights reserved.
//

#import "YKDetailViewController.h"

@interface YKDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularityLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *castsLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *release_dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *votingLabel;
@property (weak, nonatomic) IBOutlet UILabel *voting_countLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;

@end

@implementation YKDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
