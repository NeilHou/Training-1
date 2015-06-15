//
//  YKSearchViewController.m
//  L04
//
//  Created by Amos Wu on 15/6/12.
//
//

#import "YKSearchViewController.h"
#import "YKMovie.h"
#import "YKJsonData.h"
#import "YKMoiveCell.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "YKProtocolDelegate.h"
#import "YKDetailViewController.h"
#import "KVNProgress.h"

@interface YKSearchViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@property (nonatomic, strong) NSMutableArray *searchDataArray;
@property (nonatomic, strong) YKMoiveCell *cell;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIAlertView *alertView;

-(void)closeTheSearch;

@end

@implementation YKSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    self.searchTableView.rowHeight = 165;
    self.searchTableView.separatorColor = [UIColor blueColor]; //设置分隔线的颜色
    self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone; //设置开始时隐藏分割线
    
    UINib *nib = [UINib nibWithNibName:@"YKMoiveCell" bundle:nil];
    [self.searchTableView registerNib:nib forCellReuseIdentifier:@"YKMoiveCell"];
    
    //实现搜索功能
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    _searchBar.placeholder = @"Amos请您\"输入电影名称\"";   //设置占位符
    _searchBar.delegate = self;   //设置控件代理
    [self.searchBar sizeToFit];
    self.searchTableView.tableHeaderView = self.searchBar;

    self.navigationItem.title = @"搜索";
    
    [self showTheMovies];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.isPush == YES) {

    }else{
        UIBarButtonItem *rightbutton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self  action:@selector(cancelButton:)];
        self.navigationItem.rightBarButtonItem = rightbutton;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    searchBar.showsCancelButton = YES;
    
    NSLog(@"2.shuould begin");
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    searchBar.text = @"";
    NSLog(@"3.did begin");
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"4.did end");
    searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self searchfromjson:searchBar.text];
    NSLog(@"输入了：%@", searchBar.text);
    
    [self.searchBar resignFirstResponder];
}

- (void)showTheMovies
{
    [self.searchBar resignFirstResponder];
    NSString *searchText;
    
    if ([_delegate respondsToSelector:@selector(textValue)])
    {
        searchText = [_delegate textValue];
    }
    
    BOOL ifSearch = [searchText isEqualToString:@""] || searchText == nil;
    if (ifSearch == NO) {
        [self searchfromjson:searchText];
    }
}

//点击搜索框上的 取消按钮时 调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"6.cancle clicked");

    [self closeTheSearch];
    _searchBar.text = @"";
    _searchBar.showsCancelButton = NO;
}

-(void)closeTheSearch
{
    [_searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Search from Json method
//该方法可以从服务器搜索请求数据
- (void)searchfromjson:(NSString *) keyString
{
    [_searchDataArray removeAllObjects];
    
    NSString *str = keyString;
    //使用该方法返回一个新的NSString，用于过滤和转换所有不合法的字符
    keyString = [keyString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *searchURL = [NSString stringWithFormat:@"http://api.themoviedb.org/3/search/movie?query=%@&api_key=e55425032d3d0f371fc776f302e7c09b", keyString];
    
    
    [YKJsonData MovieDataWithUrl:searchURL
                         success:^(id movie) {
                             _searchDataArray = movie;
                             self.navigationItem.title = [NSString stringWithFormat:@"\"%@\"的搜索结果(%lu)", str, (unsigned long)_searchDataArray.count];
                             
                             NSString *str = [NSString stringWithFormat:@"成功返回(%lu)个结果", (unsigned long)_searchDataArray.count];
                             NSString *rightStr = @"在Amos&Kathy的帮助下，看来你找到了想要的内容^_^";
                             NSString *wrongStr = @"Sorry，没有能找到相关的电影，换个名字试试吧~";
                             
                             if (_searchDataArray.count == 0){
                                 _alertView = [[UIAlertView alloc] initWithTitle:str message:wrongStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                             }else{
                                 _alertView = [[UIAlertView alloc] initWithTitle:str message:rightStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                             }
                             [KVNProgress dismiss];
                             self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                             [_alertView show];
                             [self.searchTableView reloadData];
                         } fail:^{
                         }];
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _cell = [tableView dequeueReusableCellWithIdentifier:@"YKMoiveCell" forIndexPath:indexPath];
    _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //初始化一个状态指示器
    _activityIndicatorView = [[UIActivityIndicatorView alloc]
                              initWithFrame:CGRectMake(57.0,70.0,30.0,30.0)];
    
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;  //设置样式
    _activityIndicatorView.hidesWhenStopped = YES;  //停止后自动隐藏
    [_cell addSubview:_activityIndicatorView];  //附着在当前试图
    [_activityIndicatorView startAnimating];
    
        // 使用searchData作为表格显示的数据
    YKMovie *movie = _searchDataArray[indexPath.row];
    
    [self loadTheCellData:movie];
    
    return _cell;
}

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YKDetailViewController *detailViewController = [[YKDetailViewController alloc] init];

    YKMovie *selectedMovie = _searchDataArray[indexPath.row];
    detailViewController.movie = selectedMovie;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [self performSelector:@selector(delectCell:) withObject:nil afterDelay:0.5];
}

#pragma mark - 移除单元格选中时的高亮状态的方法
- (void)delectCell:(id)sender
{
    [self.searchTableView deselectRowAtIndexPath:[self.searchTableView indexPathForSelectedRow] animated:YES];
}

@end
