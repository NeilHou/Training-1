//
//  YKMenuTableViewController.m
//  L04
//
//  Created by Amos Wu on 15/6/3.
//
//

#import "YKMenuTableViewController.h"
#import "ViewController.h"
#import "YKSearchViewController.h"

static NSString * const YKMunuViewControllerCellReuseId = @"YKMunuViewControllerCellReuseId";

@interface YKMenuTableViewController ()<UITabBarControllerDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *movieURLArray;
@property(nonatomic, assign) NSInteger previousRow;

@end

@implementation YKMenuTableViewController
@synthesize menus1, menus2;

#pragma mark - Managing the view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menus1 = MenuArray1;
    menus2 = MenuArray2;
        CGRect frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    
    self.tableView.allowsSelection = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YKMunuViewControllerCellReuseId];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - 指定某一个Section的header的高度
//指定某一个Section的header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 64.0f;
    else
        return 15.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return menus1
            .count;
            break;
        case 1:
            return  [menus2 count];
            break;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YKMunuViewControllerCellReuseId forIndexPath:indexPath];

    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = menus1[indexPath.row];
            break;
        case 1:
            cell.textLabel.text = menus2[indexPath.row];
            break;
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    cell.highlighted = YES;
    
    return cell;
    
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.movieURLArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"movieURL" ofType:@"plist"]];
    [self performSelector:@selector(selectCell:) withObject:nil];
    
#pragma mark - 点选menu之后的动作
    
    switch (indexPath.section) {
        case 0:
            _drawer.navigationItem.title = MenuArray1[indexPath.row];  //首先改变title标题
            
            if (indexPath.row == self.previousRow) {
            }
            else {
                movieURL = self.movieURLArray[indexPath.row];
                ViewController* vc = (ViewController*)self.drawer.centerViewController;
                [vc loadReviews:movieURL];  //执行了loadReviews方法
                [vc.tableView reloadData];
            }
            [self.drawer close];
            break;
        case 1:
            if (indexPath.row == 0.0){
                
                YKSearchViewController *searchVC = [YKSearchViewController new];
                searchVC.isPush = YES;
                
                [self.navigationController pushViewController:searchVC animated:YES];
                
            }else if (indexPath.row == 1.0){
                
                
                
            }
            [self.drawer close];
            break;
        default:
            break;
    }
    
    self.previousRow = indexPath.row;
}

- (void)selectCell:(id)sender
{
    [self.tableView selectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@synthesize movieURL;

@end
