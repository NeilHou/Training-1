//
//  YKJsonData.m
//  L04
//
//  Created by Amos Wu on 15/6/3.
//
//

#import "YKJsonData.h"
#import "AFNetworking.h"
#import "YKMovie.h"

@implementation YKJsonData

+ (void)alternativeDataWithUrl:(NSString *)url success:(void (^)(id movie))success fail:(void (^)())fail{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *json = responseObject[@"titles"];
             NSMutableArray *movies = [[NSMutableArray alloc]init];
             
             for (NSDictionary *dict in json) {
                 YKMovie *movie = [[YKMovie alloc] initWithDictionary:dict];
                 [movies addObject:movie];
             }
             if (success) {
                 success(movies);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",error);
             if (fail) {
                 fail();
             }
         }];
}

+ (void)MovieDataWithUrl:(NSString *)url success:(void (^)(id movie))success fail:(void (^)())fail{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *json = responseObject[@"results"];
             NSMutableArray *movies = [[NSMutableArray alloc]init];
             for (NSDictionary *dict in json) {
                 YKMovie *movie = [[YKMovie alloc] initWithDictionary:dict];
                 [movies addObject:movie];
             }
             if (success) {
                 success(movies);
                 NSLog(@"Data数据到手");
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",error);
             if (fail) {
                 fail();
             }
         }];
}

+ (void)MovieIdWithUrl:(NSString *)url success:(void (^)(id movie))success fail:(void (^)())fail{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             YKMovie *movie = [[YKMovie alloc] initWithDictionary:responseObject];
             if (success) {
                 success(movie);
                 NSLog(@"id数据到手");
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",error);
             if (fail) {
                 fail();
             }
         }];
}

@end
