//
//  YKAlternativeTableViewController.m
//  L04
//
//  Created by Amos Wu on 15/6/4.
//
//

#import "YKAlternativeTableViewController.h"
#import "YKDetailViewController.h"
#import "YKMovie.h"

static NSString * const YKAlternativeCellReuseId = @"YKAlternativeCellReuseId";

@interface YKAlternativeTableViewController ()
{
    YKAlternativeTableViewController *ATC;
}
@property (nonatomic, strong) UITableViewCell *cell;

@end

@implementation YKAlternativeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO; //设置不允许点选
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YKAlternativeCellReuseId];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
    _cell=[tableView dequeueReusableCellWithIdentifier:YKAlternativeCellReuseId];
    
    //初始化cell的类型
    _cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                reuseIdentifier:YKAlternativeCellReuseId];

    self.navigationItem.title = [NSString stringWithFormat:@"包含%lu个结果", [_movies count]];
    
    YKMovie *movie = _movies[indexPath.row];
    
    _cell.textLabel.text = [movie title];
    _cell.detailTextLabel.text = [movie country];
    
    return _cell;
}


- (void) reloadAlternativeData:(id)movies
{
    _movies = movies;
    [self.tableView reloadData];
}

@end
