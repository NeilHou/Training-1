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
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YKSearchViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, YKProtocolDelegate>;

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *jsonArray;
@property (nonatomic, strong) NSArray *searchJsonArray;
@property (nonatomic, strong) NSDictionary *detailDict;
@property (nonatomic, strong) YKMoiveCell *cell;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic,copy) NSString * imageUrl;
@property (nonatomic,strong) UIImage *image;

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
    
    //实现搜索功能
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    _searchBar.placeholder = @"Amos请您\"输入英文电影名称\"";   //设置占位符
    _searchBar.delegate = self;   //设置控件代理
    [self.searchBar sizeToFit];
//    [self.searchBar becomeFirstResponder];
    self.tableView.tableHeaderView = self.searchBar;
    [self.tableView setContentOffset:CGPointMake(0.0,44.0) animated:YES]; //设置启动时搜索栏隐藏
    
    //设置用于储存资料的数组
    _detaildataArray = [NSMutableArray array];
    _searchDataArray = [NSMutableArray array];
    
    NSString *URL = nil;
    [self loadReviews: URL];
    
}

#pragma mark - Open drawer button
- (void)openDrawer:(id)sender
{
    [self.drawer openAndClose];
}

//- (void)returnToHome
//{
//    NSString *URL = nil;
//    [self loadReviews: URL];
//
//    [self dismissViewControllerAnimated:YES completion:^{
//        isSearch = NO;
//        _searchBar.text = @"";
//        [_searchBar resignFirstResponder];
//        [self.tableView setContentOffset:CGPointMake(0.0,-(20.0)) animated:YES]; //cancelhou搜索栏隐藏
//        _drawer.navigationItem.title = MenuArray[0];
//    }];
//}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.tableView reloadData];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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

    //初始化一个状态指示器
    _activityIndicatorView = [[UIActivityIndicatorView alloc]
                              initWithFrame:CGRectMake(57.0,70.0,30.0,30.0)];
    
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;  //设置样式
    _activityIndicatorView.hidesWhenStopped = YES;  //停止后自动隐藏
    [_cell addSubview:_activityIndicatorView];  //附着在当前试图
    [_activityIndicatorView startAnimating];
    
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

#pragma mark - 显示cell内容的方法

- (void)loadTheCellData:(YKMovie *)movie
{
    //创建一个状态栏的网络指示器
    UIApplication *myApp = [UIApplication sharedApplication];
    myApp.networkActivityIndicatorVisible = YES; //在开始下载数据时显示指示器
    
    _cell.titleLabel.text = movie.title;
    
    _cell.release_dateLabel.text = movie.release_date;
    _cell.voting_countLabel.text = [NSString stringWithFormat:@"(%@人评价)",movie.voting_count];
    
    double dVoting = [movie.voting doubleValue];
    if (dVoting < 0.5f) {
        _cell.votingLabel.text = @"0";
    }else{
    _cell.votingLabel.text = [NSString stringWithFormat:@"%.2g", dVoting];
    }
    
    double dPopularity = [movie.popularity doubleValue];
    if (dPopularity > 10.0f) {
        _cell.popularityLabel.textColor = [UIColor orangeColor];
        _cell.popularityLabel.text = [NSString stringWithFormat:@"\U0001F525%.4f", dPopularity];
    }else{
    _cell.popularityLabel.text = [NSString stringWithFormat:@"%.4f", dPopularity];
    _cell.popularityLabel.textColor = [UIColor blackColor];
    }
    
    //获取图片内容
    
    //异步处理cellImage
    NSString *imgURLString = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w92%@",movie.postPath];
    NSURL *posterURL = [NSURL URLWithString:imgURLString];

    [_cell.images sd_setImageWithURL:posterURL placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        myApp.networkActivityIndicatorVisible = NO;
    }];
    [_activityIndicatorView stopAnimating];
    
    NSNumberFormatter *numFormatter = [NSNumberFormatter new];
    numFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    _cell.budgetLabel.text = [NSString stringWithFormat:@"%@",[numFormatter stringFromNumber:movie.budget]];
    _cell.revenueLabel.text = [NSString stringWithFormat:@"%@",[numFormatter stringFromNumber:movie.revenue]];
    _cell.runtimeLabel.text = [NSString stringWithFormat:@"%@分钟", movie.runTime];
}

#pragma mark - 移除单元格选中时的高亮状态的方法
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
    
    searchBar.text = @"";
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

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"5.search clicked");
    [self.searchBar resignFirstResponder];
    [self popToSearchvc];
    
//    [self searchfromjson:searchBar.text];
    NSLog(@"输入了：%@", searchBar.text);
    
    // 调用filterBySubstring:方法执行搜索
    // [self filterBySubstring:searchBar.text];
}

- (void)popToSearchvc
{
    YKSearchViewController *searchVC = [YKSearchViewController new];
    //点击后弹出模态显示搜索结果
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchVC];
    searchVC.delegate = self;
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSString *)textValue{
    return _searchBar.text;
}

//点击搜索框上的 取消按钮时 调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"6.cancle clicked");
    
    isSearch = NO;
    _searchBar.text = @"";
    [_searchBar resignFirstResponder];
    [self.tableView setContentOffset:CGPointMake(0.0f,-(20.0f)) animated:YES]; //cancelhou搜索栏隐藏
}

#pragma mark - 抓取review的json数据的方法
- (void)loadReviews: (NSString *)movieURL
{
    if (!movieURL) {
        movieURL = @"http://api.themoviedb.org/3/movie/now_playing?api_key=e55425032d3d0f371fc776f302e7c09b";
    }
    [YKJsonData MovieDataWithUrl:movieURL
                       success:^(id movie) {
                           _detaildataArray = movie;
                           [self.tableView reloadData];
                       } fail:^{
                           
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
