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

@interface YKMenuTableViewController ()

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
        _menus = [NSArray arrayWithObjects:@"正在上映", @"即将上映", @"最为流行", @"评分最高", @"搜索结果", nil];
//        _menus = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"menusArray" ofType:@"plist"]];
    }
    return _menus;
}

#pragma mark - Managing the view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);//不知道为什么，并不能控制tableview的位置
    
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YKMunuViewControllerCellReuseId];
}

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
    if (indexPath.row == self.previousRow) {
        // Close the drawer without no further actions on the center view controller
        [self.drawer close];
    }
    else {
        [self.drawer close];
    }
    self.previousRow = indexPath.row;
}

@end
