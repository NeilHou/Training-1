//
//  ViewController.m
//  L04
//
//  Created by Hanguang on 5/20/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import "ViewController.h"
#import "YKMoiveCell.h"
#import "YKDetailViewController.h"
#import "AFNetworking.h"
#import "YKMovie.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *jsonArray;
@property (nonatomic, strong) NSDictionary *detailDict;
//@property (nonatomic, strong) NSMutableArray *detaildataArray;

@end

@implementation ViewController

#pragma mark - View life cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 165;
    
    UINib *nib = [UINib nibWithNibName:@"YKMoiveCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"YKMoiveCell"];
    
    self.navigationItem.title = @"电影列表";
    
    _detaildataArray = [NSMutableArray array];
    [self loadReviews];
}

- (void)loadReviews
{
    self.jsonArray = [NSArray new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = @"http://api.themoviedb.org/3/movie/now_playing?api_key=e55425032d3d0f371fc776f302e7c09b";
    
    [manager GET:URL parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"数据抓取成功");
         
         if (responseObject)
         {
             NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:responseObject];
             self.jsonArray = dict[@"results"];
             
             for (NSDictionary *dict in self.jsonArray) {

                 YKMovie *movie = [YKMovie new];
             
                 movie.postPath = dict[@"poster_path"];
                 movie.title = dict[@"title"];
                 movie.popularity = dict[@"popularity"];
                 movie.release_date = dict[@"release_date"];
                 movie.voting = dict[@"vote_average"];
                 movie.voting_count = dict[@"vote_count"];
                 movie.overview = dict[@"overview"];
                 
                 [_detaildataArray addObject:movie];
             }
         }
         [self.tableView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"数据抓取失败！");
         }];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.tableView reloadData];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _detaildataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKMoiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKMoiveCell" forIndexPath:indexPath];
    
    YKMovie *movie = _detaildataArray[indexPath.row];

    cell.titleLabel.text = movie.title;
    
    //获取图片内容
    NSString *imgURLString = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w342%@", movie.postPath];
    NSURL *imgURL = [NSURL URLWithString:imgURLString];
    NSMutableData *imgData = [NSMutableData dataWithContentsOfURL:imgURL];
    cell.images.image = [UIImage imageWithData:imgData];
    
    cell.release_dateLabel.text = movie.release_date;
    
    cell.popularityLabel.text = [NSString stringWithFormat:@"%@", movie.popularity];
    cell.voting_countLabel.text = [NSString stringWithFormat:@"(%@人评论)",movie.voting_count];
    cell.votingLabel.text = [NSString stringWithFormat:@"%@",movie.voting];
    NSLog(@"cell数据载入");
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YKDetailViewController *detailViewController = [[YKDetailViewController alloc] init];
    
    //    Student *selectedStudent = self.studentsArray[indexPath.row];
    //
    //    detailViewController.student = selectedStudent;
    
    
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}
@end
