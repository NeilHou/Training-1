//
//  YKSearchHistoryVC.m
//  L04
//
//  Created by Amos Wu on 15/6/14.
//
//

#import "YKSearchHistoryVC.h"

@interface YKSearchHistoryVC ()
@property (weak, nonatomic) IBOutlet UITableView *searchHistoryTableView;

@end

@implementation YKSearchHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.searchHistoryTableView.delegate = self;
//    self.searchHistoryTableView.dataSource = self;
    self.searchHistoryTableView.rowHeight = 44;
    
    UINib *nib = [UINib nibWithNibName:@"YKSearchHistoryVC" bundle:nil];
    [self.searchHistoryTableView registerNib:nib forCellReuseIdentifier:@"YKSearchHistoryVC"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
