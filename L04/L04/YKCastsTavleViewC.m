//
//  YKCastsTavleViewC.m
//  L04
//
//  Created by Amos Wu on 15/6/7.
//
//

#import "YKCastsTavleViewC.h"
#import "YKMovie.h"
#import "YKCastsCell.h"
#import "UIImageView+WebCache.h"

static NSString * const YKCastsCellReuseId = @"YKCastsCell";
@interface YKCastsTavleViewC()
@property (nonatomic, strong) YKCastsCell *cell;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation YKCastsTavleViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    self.tableView.allowsSelection = NO;
    
    UINib *nib = [UINib nibWithNibName:YKCastsCellReuseId bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:YKCastsCellReuseId];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YKCastsCellReuseId];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!_movies)
        return 0;
    else
        return [_movies count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [tableView dequeueReusableCellWithIdentifier:YKCastsCellReuseId forIndexPath:indexPath];
    
    self.navigationItem.title = [NSString stringWithFormat:@"共%lu个主要演员", [_movies count]];
    UIApplication *myApp = [UIApplication sharedApplication];
    myApp.networkActivityIndicatorVisible = YES;
    
    //初始化一个状态指示器
    _activityIndicatorView = [[UIActivityIndicatorView alloc]
                              initWithFrame:CGRectMake(23.0,25.0,30.0,30.0)];
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;  //设置样式
    _activityIndicatorView.hidesWhenStopped = YES;  //停止后自动隐藏
    [_cell addSubview:_activityIndicatorView];  //附着在当前试图
//    [_activityIndicatorView startAnimating];
    
    YKMovie *movie = _movies[indexPath.row];
    
    _cell.castsLabel.text = [movie name];
    _cell.characterLabel.text = [movie character];
    
    NSString *detailImgURLString = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w45%@",movie.profile_path];
    NSURL *detailURL = [NSURL URLWithString:detailImgURLString];
    
    [_cell.castsImage sd_setImageWithURL:detailURL
                   placeholderImage:nil
                            options:SDWebImageRetryFailed
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                              myApp.networkActivityIndicatorVisible = NO;
                          }];
    
    return _cell;
}


- (void) reloadCastsData:(id)movies
{
    _movies = movies;
    [self.tableView reloadData];
}
@end
