//
//  YKMovieCell.h
//  L05_EndingTask
//
//  Created by Amos Wu on 15/5/31.
//  Copyright (c) 2015年 Amos Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKMovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *original_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *castsLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainland_pubdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratings_countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *images;

@end
