//
//  YKMovie.h
//  L04
//
//  Created by Amos Wu on 15/6/2.
//  Copyright (c) 2015年 Hanguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YKMovie : NSObject

@property (strong, nonatomic) NSArray *moviesArray;

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *postPath;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *popularity;
@property (strong, nonatomic) NSString *directors;
@property (strong, nonatomic) NSString *casts;
@property (strong, nonatomic) NSDate *durations;
@property (strong, nonatomic) NSString *release_date;
@property (assign, nonatomic) float *voting;
@property (strong, nonatomic) NSString *voting_count;
@property (strong, nonatomic) NSString *overview;

@end
