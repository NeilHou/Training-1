//
//  ViewController.m
//  L05_2
//
//  Created by Amos Wu on 15/6/1.
//  Copyright (c) 2015年 Amos Wu. All rights reserved.
//

#import "ViewController.h"
#import "YKMoiveCell.h"
#import "YKDetailViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methed

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YKMoiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YKMoiveCell" forIndexPath:indexPath];
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
