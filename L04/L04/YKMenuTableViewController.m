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

@property (nonatomic, strong) NSArray *menus;
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
    if (!_menus) {
        
        _menus = [NSArray arrayWithObjects:@"正在上映", @"即将上映", @"最为流行", @"评分最高", @"搜索结果", nil];
//        _menus = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"menusArray" ofType:@"plist"]];
    }
    return _menus;
}

#pragma mark - Managing the view

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        // Reload the current center view controller and update its background color
        typeof(self) __weak weakSelf = self;
        [self.drawer reloadCenterViewControllerUsingBlock:^(){
            NSParameterAssert(weakSelf.menus);
            weakSelf.drawer.centerViewController.view.backgroundColor = weakSelf.colors[indexPath.row];
        }];
        
        //        // Replace the current center view controller with a new one
        //        ICSPlainColorViewController *center = [[ICSPlainColorViewController alloc] init];
        //        center.view.backgroundColor = [UIColor redColor];
        //        [self.drawer replaceCenterViewControllerWithViewController:center];
    }
    self.previousRow = indexPath.row;
}

@end
