//
//  YKMovie.m
//  L05_2
//
//  Created by Amos Wu on 15/6/1.
//  Copyright (c) 2015年 Amos Wu. All rights reserved.
//

#import "YKMovie.h"
#import "AFNetworking.h"

@interface YKMovie()

@property (nonatomic)NSMutableArray *movieItems;
@property (nonatomic, strong) NSArray *jsonArray;

@end

@implementation YKMovie

- (instancetype)initPrivate
{
    self = [super init];
    if (self){
        _movieItems = [NSMutableArray new];
    }
    return self;
}

+ (instancetype)sharedStore
{
    static YKMovie *sharedStore = nil;
    if (!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (NSArray *)moviesArray
{
    return [self.moviesArray copy];
}

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
