//
//  YKMoiveCell.h
//  L05_2
//
//  Created by Amos Wu on 15/6/1.
//  Copyright (c) 2015年 Amos Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKMoiveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *original_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *castsLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubdatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *rating_countLabel;

@end
