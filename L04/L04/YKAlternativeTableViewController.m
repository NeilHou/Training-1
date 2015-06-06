//
//  YKAlternativeTableViewController.m
//  L04
//
//  Created by Amos Wu on 15/6/4.
//
//

#import "YKAlternativeTableViewController.h"
#import "YKJsonData.h"
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:YKAlternativeCellReuseId];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:YKAlternativeCellReuseId];
    }
    
    YKDetailViewController *detailVC = [YKDetailViewController new];
    YKMovie *movie = detailVC.alternativeArray[indexPath.row];
    
    cell.textLabel.text = [movie title];
    cell.detailTextLabel.text = movie.country;
    
    return cell;
}
@end
