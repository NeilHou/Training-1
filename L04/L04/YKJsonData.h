//
//  YKJsonData.h
//  L04
//
//  Created by Amos Wu on 15/6/3.
//
//

#import <Foundation/Foundation.h>
@class YKMovie;

@interface YKJsonData : NSObject
{
    NSMutableArray *_alternativeArray;
}

@property (nonatomic, strong) NSArray *jsonArray;
@property (nonatomic, strong) YKMovie *movie;

+ (void)alternativeDataWithUrl:(NSString *)url success:(void (^)(id movie))success fail:(void (^)())fail;
+ (void)MovieDataWithUrl:(NSString *)url success:(void (^)(id movie))success fail:(void (^)())fail;
+ (void)MovieIdWithUrl:(NSString *)url success:(void (^)(id movie))success fail:(void (^)())fail;
+ (void)castsDataWithUrl:(NSString *)url success:(void (^)(id movie))success fail:(void (^)())fail;

@end
