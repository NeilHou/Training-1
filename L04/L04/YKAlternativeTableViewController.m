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
@end

@implementation YKAlternativeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:YKAlternativeCellReuseId];
    
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:YKAlternativeCellReuseId];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    self.navigationItem.title = [NSString stringWithFormat:@"包含%lu个结果", [_movies count]];
    
    YKMovie *movie = _movies[indexPath.row];
    
    cell.textLabel.text = [movie title];
    cell.detailTextLabel.text = [movie country];
    
    return cell;
}


- (void) reloadAlternativeData:(id)movies
{
    _movies = movies;
    [self.tableView reloadData];
}

@end
