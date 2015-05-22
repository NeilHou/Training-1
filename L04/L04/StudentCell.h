//
//  StudentCell.h
//  L04
//
//  Created by Hanguang on 5/22/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mugshotImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
