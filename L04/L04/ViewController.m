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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *jsonArray;
@property (nonatomic, strong) NSArray *searchJsonArray;
@property (nonatomic, strong) NSDictionary *detailDict;
//@property (nonatomic, strong) NSMutableArray *detaildataArray;

@end

@implementation ViewController

#pragma mark - View life cycle
bool isSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isSearch = NO;
    
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
    _searchDataArray = [NSMutableArray array];
    [self loadReviews];
    
    //实现搜索功能
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    _searchBar.placeholder = @"Amos请您\"输入电影名称\"";   //设置占位符
    _searchBar.delegate = self;   //设置控件代理
    [self.searchBar sizeToFit];
//    [self.searchBar becomeFirstResponder];
    self.tableView.tableHeaderView = self.searchBar;
    [self.tableView setContentOffset:CGPointMake(0.0,44.0) animated:YES]; //设置启动时搜索栏隐藏
}

- (void)loadReviews
{
    self.jsonArray = [NSArray new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = @"http://api.themoviedb.org/3/movie/now_playing?api_key=e55425032d3d0f371fc776f302e7c09b";
//    YKMoiveCell *movieCell = [YKMoiveCell new];
//    [movieCell.movieUIActivityIndicatorView setHidesWhenStopped:YES];
    
    [manager GET:URL parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"首页数据抓取成功");
         
         if (responseObject)
         {
//             [movieCell.movieUIActivityIndicatorView startAnimating];
             
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
                 
                 //获取图片内容
                 NSString *imgURLString = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w342%@", movie.postPath];
                 NSURL *imgURL = [NSURL URLWithString:imgURLString];
                 NSMutableData *imgData = [NSMutableData dataWithContentsOfURL:imgURL];
                 movie.image = [UIImage imageWithData:imgData];
                 
                 [_detaildataArray addObject:movie];
             }
//             [movieCell.movieUIActivityIndicatorView stopAnimating];
             NSLog(@"首页数据缓存成功");
         }
         [self.tableView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"数据抓取失败！");
         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _detaildataArray.count;
    if(isSearch)
    {
        // 使用searchData作为表格显示的数据
        return _searchDataArray.count;
    }
    else
    {
        // 否则使用原始的tableData座位表格显示的数据
        return _detaildataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKMoiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKMoiveCell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    // 如果处于搜索状态
    if(isSearch)
    {
        // 使用searchData作为表格显示的数据
        YKMovie *movie = _searchDataArray[indexPath.row];
        
        cell.titleLabel.text = movie.title;
        cell.images.image = movie.image;
        
        cell.release_dateLabel.text = movie.release_date;
        
        cell.popularityLabel.text = [NSString stringWithFormat:@"%@", movie.popularity];
        cell.voting_countLabel.text = [NSString stringWithFormat:@"(%@人评论)",movie.voting_count];
        cell.votingLabel.text = [NSString stringWithFormat:@"%@",movie.voting];
        NSLog(@"cell数据载入");
    }
    else{
        // 否则使用原始的tableData作为表格显示的数据
        YKMovie *movie = _detaildataArray[indexPath.row];
        
        cell.titleLabel.text = movie.title;
        cell.images.image = movie.image;
        
        cell.release_dateLabel.text = movie.release_date;
        
        cell.popularityLabel.text = [NSString stringWithFormat:@"%@", movie.popularity];
        cell.voting_countLabel.text = [NSString stringWithFormat:@"(%@人评论)",movie.voting_count];
        cell.votingLabel.text = [NSString stringWithFormat:@"%@",movie.voting];
        NSLog(@"cell数据载入");
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YKDetailViewController *detailViewController = [[YKDetailViewController alloc] init];
    
    if (isSearch){
        
        YKMovie *selectedMovie = _searchDataArray[indexPath.row];
        detailViewController.movie = selectedMovie;
        
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }else{
    
        YKMovie *selectedMovie = _detaildataArray[indexPath.row];
        detailViewController.movie = selectedMovie;
    
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    searchBar.showsCancelButton = YES;
    for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    NSLog(@"2.shuould begin");
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.text = @"";
    NSLog(@"3.did begin");
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"4.did end");
    searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search clicked");
    [self.searchBar resignFirstResponder];
    
    // 调用filterBySubstring:方法执行搜索
//    [self filterBySubstring:searchBar.text];

    [self searchfromjson:searchBar.text];
    self.navigationItem.title = [NSString stringWithFormat:@"\"%@\"的搜索结果", searchBar.text];
    NSLog(@"%@", searchBar.text);
}

//点击搜索框上的 取消按钮时 调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"cancle clicked");
    
    isSearch = NO;
    _searchBar.text = @"";
    [_searchBar resignFirstResponder];
    [self.tableView setContentOffset:CGPointMake(0.0,-(20.0)) animated:YES]; //cancelhou搜索栏隐藏
}

#pragma mark - search array method
//以下两个方法可实现表格内搜索
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    // 调用filterBySubstring:方法执行搜索
//    [self filterBySubstring:searchText];
//}
//
//- (void)filterBySubstring:(NSString*) subString
//{
//    // 设置为搜索状态
//    isSearch = YES;
//    // 定义搜索谓词
//    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@" , subString];
//    // 使用谓词过滤NSArray
//    _searchDataArray = [_detaildataArray filteredArrayUsingPredicate:pred];
//    // 让表格控件重新加载数据
//    [self.tableView reloadData];
//}

#pragma mark - Search from Json method
//该方法可以从服务器搜索请求数据
- (void)searchfromjson:(NSString *) keyString
{
    isSearch = YES;
    
    self.searchJsonArray = [NSArray new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *URL = [NSString stringWithFormat:@"http://api.themoviedb.org/3/search/movie?query=%@&api_key=e55425032d3d0f371fc776f302e7c09b", keyString];

    [manager GET:URL parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"搜索开始抓取");
         
         if (responseObject)
         {
             
             NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:responseObject];
             self.searchJsonArray = dict[@"results"];
             
             for (NSDictionary *dict in self.searchJsonArray) {
                 
                 YKMovie *movie = [YKMovie new];
                 
                 movie.postPath = dict[@"poster_path"];
                 movie.title = dict[@"title"];
                 movie.popularity = dict[@"popularity"];
                 movie.release_date = dict[@"release_date"];
                 movie.voting = dict[@"vote_average"];
                 movie.voting_count = dict[@"vote_count"];
                 movie.overview = dict[@"overview"];
                 
                 //获取图片内容
                 NSString *imgURLString = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w342%@", movie.postPath];
                 NSURL *imgURL = [NSURL URLWithString:imgURLString];
                 NSMutableData *imgData = [NSMutableData dataWithContentsOfURL:imgURL];
                 movie.image = [UIImage imageWithData:imgData];
                 
                 [_searchDataArray addObject:movie];
             }
             //             [movieCell.movieUIActivityIndicatorView stopAnimating];
             NSLog(@"搜索数据缓存成功");
         }
         [self.tableView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"搜索数据抓取失败！");
         }];
    
}
@end
