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

@property (strong, nonatomic) NSNumber *movieId;

@property (strong, nonatomic) UIImage *cellImage;
@property (strong, nonatomic) UIImage *detailImage;
@property (strong, nonatomic) NSString *postPath;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *popularity;
@property (strong, nonatomic) NSString *release_date;
@property (assign, nonatomic) NSNumber *voting;
@property (strong, nonatomic) NSNumber *voting_count;
@property (strong, nonatomic) NSString *overview;

//detail独有属性
//@property (strong, nonatomic) NSString *directors; //douban only
//@property (strong, nonatomic) NSString *casts; //douban only
@property (strong, nonatomic) NSNumber *runTime; //douban only
@property (strong, nonatomic) NSNumber *revenue;
@property (strong, nonatomic) NSString *tagline;
@property (strong, nonatomic) NSNumber *budget;

@end
