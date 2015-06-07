//
//  YKMovie.m
//  L04
//
//  Created by Amos Wu on 15/6/2.
//  Copyright (c) 2015年 Hanguang. All rights reserved.
//

#import "YKMovie.h"

@implementation YKMovie

- (instancetype) initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        
        self.movieId = dict[@"id"];
        
        self.postPath = dict[@"poster_path"];
        
        self.title = dict[@"title"];
        self.popularity = dict[@"popularity"];
        self.release_date = dict[@"release_date"];
        self.voting = dict[@"vote_average"];
        self.voting_count = dict[@"vote_count"];
        self.overview = dict[@"overview"];
        
        self.revenue = dict[@"revenue"];
        self.runTime = dict[@"runtime"];
        self.budget = dict[@"budget"];
        self.country = dict[@"iso_3166_1"];
        
        NSString *string = dict[@"tagline"];
        if ([string isEqual:[NSNull null]] || !string.length) {
                string = @"去看就是了，木有宣传语！";
        }
        self.tagline = string;
    }
    return self;
}

@end
