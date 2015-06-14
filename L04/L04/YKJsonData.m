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
#import "KVNProgress.h"

static NSString *HUBstrLoading = @"正在载入数据...";
static NSString *HUBstrSuccess = @"搞定！";

@implementation YKJsonData

+ (void)alternativeDataWithUrl:(NSString *)url success:(void (^)(id movie))success fail:(void (^)())fail{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [KVNProgress showWithStatus:HUBstrLoading];
    
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
                 [KVNProgress dismiss];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",error);
             if (fail) {
                 fail();
             }
         }];
}

+ (void)castsDataWithUrl:(NSString *)url
                 success:(void (^)(id movie))success
                    fail:(void (^)())fail{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [KVNProgress showWithStatus:HUBstrLoading];
    
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
                 [KVNProgress dismiss];
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
    
    //显示HUB
    [KVNProgress showWithStatus:HUBstrLoading];
//    dispatch_main_after(3.5f, ^{
//        [KVNProgress showWithStatus:@"耐心点，要么数据太多，要么你网速太慢"];
//    });
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *json = responseObject[@"results"];
             NSMutableArray *movies = [[NSMutableArray alloc]init];
             for (NSDictionary *dict in json) {
                 YKMovie *movie = [[YKMovie alloc] initWithDictionary:dict];
                 
                 movie.movieId = dict[@"id"];
                 NSString *URL = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@?api_key=e55425032d3d0f371fc776f302e7c09b",movie.movieId];
                 
                 NSError *error;
                 
                 //加载一个NSURL对象
                 NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
                 
                 //将请求的url数据放到NSData对象中
                 NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                 
                 if (response) {
                     //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
                     NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];

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
                 [movies addObject:movie];
             }
             if (success) {
                 success(movies);
                 NSLog(@"Data数据到手");
                 [KVNProgress showSuccessWithStatus:HUBstrSuccess];
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

static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

@end
