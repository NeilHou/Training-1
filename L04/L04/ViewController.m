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
#import "YKMenuTableViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *jsonArray;
@property (nonatomic, strong) NSArray *searchJsonArray;
@property (nonatomic, strong) NSDictionary *detailDict;
@property (nonatomic, strong) YKMoiveCell *cell;

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
    
    self.menus = [NSArray arrayWithObjects:@"正在上映", @"即将上映", @"最为流行", @"评分最高", @"搜索结果", nil];
    
#pragma mark - 设置navigationItem相关属性
    self.navigationItem.title = self.menus[0];
    UIImage *muneIcon = [UIImage imageNamed:@"menu-24.png"];
    UIImage *homeIcon = [UIImage imageNamed:@"home-25.png"];
    
    UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithImage:homeIcon style:UIBarButtonItemStylePlain target:self action:@selector(returnToHome)];
    self.navigationItem.rightBarButtonItem = rightbutton;

    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc] initWithImage:muneIcon style:UIBarButtonItemStylePlain target:self action:@selector(openDrawer:)];
    self.navigationItem.leftBarButtonItem = leftbutton;
    
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

#pragma mark - Open drawer button
- (void)openDrawer:(id)sender
{
    [self.drawer open];
}

- (void)returnToHome
{
    isSearch = NO;
    _searchBar.text = @"";
    [_searchBar resignFirstResponder];
    [self.tableView setContentOffset:CGPointMake(0.0,-(20.0)) animated:YES]; //cancelhou搜索栏隐藏
    [self.tableView reloadData];
    self.navigationItem.title = self.menus[0];
}

#pragma mark - 抓取review的json数据的方法
- (void)loadReviews
{
    self.jsonArray = [NSArray new];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = @"http://api.themoviedb.org/3/movie/now_playing?api_key=e55425032d3d0f371fc776f302e7c09b";
    
    [manager GET:URL parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"首页数据抓取成功");
         
         if (responseObject)
         {
             NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:responseObject];
             self.jsonArray = dict[@"results"];
             
             for (NSDictionary *dict in self.jsonArray) {

                 YKMovie *movie = [YKMovie new];
                 
                 //获取ID值，在跳转后获取详细信息
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
                              string = @"去看就是了，木有宣传！";
                          }
                          movie.tagline = string;
                      }
                      [self.tableView reloadData];
                  }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          NSLog(@"Detail数据抓取失败！");
                      }];
                 
                 movie.title = dict[@"title"];
                 movie.popularity = dict[@"popularity"];
                 movie.release_date = dict[@"release_date"];
                 movie.voting = dict[@"vote_average"];
                 movie.voting_count = dict[@"vote_count"];
                 movie.overview = dict[@"overview"];
                 
                 //获取图片内容
                 //异步处理cellImage
                 movie.postPath = dict[@"poster_path"];
                 NSString *imgURLString = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w92%@",movie.postPath];
                 NSURL *posterURL = [NSURL URLWithString:imgURLString];
                 
                 //异步抓取图片到imgData
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     NSMutableData *imgData = [NSMutableData dataWithContentsOfURL:posterURL];
                     
                     //从imgData赋值到image
                     UIImage *image = [UIImage imageWithData:imgData];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         movie.cellImage = image;
                     });
                     [self.tableView reloadData];
                 });
                 
                 //异步处理detailImage
                 NSString *detailImgURLString = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w500%@",movie.postPath];
                 NSURL *detailURL = [NSURL URLWithString:detailImgURLString];

                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     NSMutableData *imgData2 = [NSMutableData dataWithContentsOfURL:detailURL];

                     UIImage *image2 = [UIImage imageWithData:imgData2];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         movie.detailImage = image2;
                     });
                 });
                 
                 [_detaildataArray addObject:movie];
             }
             NSLog(@"首页数据缓存成功");
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
    _cell = [tableView dequeueReusableCellWithIdentifier:@"YKMoiveCell" forIndexPath:indexPath];
    
    _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    // 如果处于搜索状态
    if(isSearch)
    {
        // 使用searchData作为表格显示的数据
        YKMovie *movie = _searchDataArray[indexPath.row];
        [self loadTheCellData:movie];
    }
    else{
        // 否则使用原始的tableData作为表格显示的数据
        YKMovie *movie = _detaildataArray[indexPath.row];
        [self loadTheCellData:movie];
    }
    
    return _cell;
}

//显示cell内容的方法
- (void)loadTheCellData:(YKMovie *)movie
{
    _cell.titleLabel.text = movie.title;
    _cell.images.image = movie.cellImage;
    _cell.runtimeLabel.text = [NSString stringWithFormat:@"%@分钟", movie.runTime];
    
    _cell.release_dateLabel.text = movie.release_date;
    _cell.voting_countLabel.text = [NSString stringWithFormat:@"(%@人评价)",movie.voting_count];
    
    NSNumberFormatter *numFormatter = [NSNumberFormatter new];
    numFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    _cell.budgetLabel.text = [NSString stringWithFormat:@"%@",[numFormatter stringFromNumber:movie.budget]];
    _cell.revenueLabel.text = [NSString stringWithFormat:@"%@",[numFormatter stringFromNumber:movie.revenue]];
    
    double dVoting = [movie.voting doubleValue];
    _cell.votingLabel.text = [NSString stringWithFormat:@"%.2g", dVoting];
    
    double dPopularity = [movie.popularity doubleValue];
    if (dPopularity > 10.0f) {
        _cell.popularityLabel.textColor = [UIColor orangeColor];
        _cell.popularityLabel.text = [NSString stringWithFormat:@"%.4f (Hot~)", dPopularity];
    }else{
    _cell.popularityLabel.text = [NSString stringWithFormat:@"%.4f", dPopularity];
    _cell.popularityLabel.textColor = [UIColor blackColor];
    }
    
    NSLog(@"cell数据载入");
}

//移除单元格选中时的高亮状态的方法
- (void)delectCell:(id)sender
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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
    
    [self performSelector:@selector(delectCell:) withObject:nil afterDelay:0.5];
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

    [self searchfromjson:searchBar.text];
    NSLog(@"%@", searchBar.text);
    
    // 调用filterBySubstring:方法执行搜索
    // [self filterBySubstring:searchBar.text];
}

//点击搜索框上的 取消按钮时 调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"cancle clicked");
    
    isSearch = NO;
    _searchBar.text = @"";
    [_searchBar resignFirstResponder];
    [self.tableView setContentOffset:CGPointMake(0.0f,-(20.0f)) animated:YES]; //cancelhou搜索栏隐藏
}

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
                 
                 //获取ID值，在跳转后获取详细信息
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
                      [self.tableView reloadData];
                  }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          NSLog(@"Detail数据抓取失败！");
                      }];

                 movie.title = dict[@"title"];
                 
                 movie.popularity = dict[@"popularity"];
                 movie.release_date = dict[@"release_date"];
                 movie.voting = dict[@"vote_average"];
                 movie.voting_count = dict[@"vote_count"];
                 movie.overview = dict[@"overview"];
                 
                 //获取图片内容
#pragma mark posterPath
                 //异步处理cellImage
                 movie.postPath = dict[@"poster_path"];
                 NSString *imgURLString = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w92%@",movie.postPath];
                 NSURL *posterURL = [NSURL URLWithString:imgURLString];
                 
                 //异步抓取图片到imgData
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     NSMutableData *imgData = [NSMutableData dataWithContentsOfURL:posterURL];
                     
                     //从imgData赋值到image
                     UIImage *image = [UIImage imageWithData:imgData];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         movie.cellImage = image;
                     });
                     [self.tableView reloadData];
                 });
                 
                 //异步处理detailImage
                 NSString *detailImgURLString = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w500%@",movie.postPath];
                 NSURL *detailURL = [NSURL URLWithString:detailImgURLString];
                 
                 //异步抓取图片到imgData
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     NSMutableData *imgData2 = [NSMutableData dataWithContentsOfURL:detailURL];
                     
                     //从imgData赋值到image
                     UIImage *image2 = [UIImage imageWithData:imgData2];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         movie.detailImage = image2;
                     });
                 });
                 
                 [_searchDataArray addObject:movie];
             }
             //             [movieCell.movieUIActivityIndicatorView stopAnimating];
             NSLog(@"搜索数据缓存成功");
             self.navigationItem.title = [NSString stringWithFormat:@"\"%@\"的搜索结果(%lu)", _searchBar.text, (unsigned long)_searchDataArray.count];
         }
         [self.tableView reloadData];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"搜索数据抓取失败！");
         }];
}
@end

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
