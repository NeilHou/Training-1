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

+ (void)castsDataWithUrl:(NSString *)url success:(void (^)(id movie))success fail:(void (^)())fail{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *json = responseObject[@"cast"];
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
                 
                 movie.movieId = dict[@"id"];
                 NSString *URL = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=e55425032d3d0f371fc776f302e7c09b",movie.movieId];
                 [manager GET:URL parameters:nil
                      success:^(AFHTTPRequestOperation *operation, id responseObject)
                  {
                      if (responseObject)
                      {
                          NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:responseObject];
                          movie.revenue = dict[@"revenue"];
                          movie.runTime = dict[@"runtime"];
                          movie.budget = dict[@"budget"];
                          
                          NSDictionary *dit = dict;
                          NSString *string = dit[@"tagline"];
                          if ([string isEqual:[NSNull null]] || !string.length) {
                              string = @"这么老的片子，木有宣传！";
                          }
                          movie.tagline = string;
                      }
                  }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          NSLog(@"Detail数据抓取失败！");
                      }];
                 
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
