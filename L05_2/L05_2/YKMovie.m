//
//  YKMovie.m
//  L05_2
//
//  Created by Amos Wu on 15/6/1.
//  Copyright (c) 2015年 Amos Wu. All rights reserved.
//

#import "YKMovie.h"

@implementation YKMovie

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.postPath = [attributes valueForKeyPath:@"poster_path"];
    self.title = [attributes valueForKeyPath:@"title"];
    self.popularity = [attributes valueForKeyPath:@"release_date"];
//    self.directors = [attributes valueForKey:@""];
//    self.casts = [attributes valueForKey:@""];
//    self.durations = [attributes valueForKey:@""];
    self.release_date = [attributes valueForKeyPath:@"release_date"];
//    _voting = [[attributes valueForKeyPath:@"vote_average"]floatValue];
    self.voting_count = [attributes valueForKeyPath:@"vote_count"];
    self.overview = [attributes valueForKeyPath:@"overview"];
    return self;
}

@end
