//
//  YKMenuTableViewController.m
//  L04
//
//  Created by Amos Wu on 15/6/3.
//
//

#import "YKMenuTableViewController.h"
#import "ViewController.h"

static NSString * const YKMunuViewControllerCellReuseId = @"YKMunuViewControllerCellReuseId";

@interface YKMenuTableViewController ()<UITabBarControllerDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *movieURLArray;
@property(nonatomic, assign) NSInteger previousRow;

@end

@implementation YKMenuTableViewController

- (id)initWithMenus:(NSArray *)menus
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _menus = menus;
    }
    return self;
}

- (NSArray *)menus
{
//    ViewController *vc = self.vc;
    if (!_menus) {
        _menus = MenuArray;
//        _menus = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"menusArray" ofType:@"plist"]];
    }
    return _menus;
}

#pragma mark - Managing the view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
        CGRect frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    //self.view.backgroundColor = [UIColor colorWithRed:0.9373 green:0.9373 blue:0.9569 alpha:1];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YKMunuViewControllerCellReuseId];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 29, self.view.bounds.size.width, self.view.bounds.size.height);
}

#pragma mark - Configuring the view’s layout behavior
//该方法可以隐藏信号栏

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    // Even if this view controller hides the status bar, implementing this method is still needed to match the center view controller's
//    // status bar style to avoid a flicker when the drawer is dragged and then left to open.
//    return UIStatusBarStyleLightContent;
//}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.menus.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YKMunuViewControllerCellReuseId forIndexPath:indexPath];

    cell.textLabel.text = _menus[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.movieURLArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"movieURL" ofType:@"plist"]];
    
    
    if (indexPath.row == self.previousRow) {
        // Close the drawer without no further actions on the center view controller
        [self.drawer close];
    }
    else {
        movieURL = self.movieURLArray[indexPath.row];
        
        //强制转换成子类
        ViewController* vc = (ViewController*)self.drawer.centerViewController;
        [vc loadReviews];

        [self.drawer close];
    }
    self.previousRow = indexPath.row;
}

@synthesize movieURL;

@end
