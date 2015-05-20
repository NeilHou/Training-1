//
//  ViewController.m
//  L04
//
//  Created by Hanguang on 5/20/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *studentsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = self.view.bounds;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + 40,
                                                                   frame.size.width, frame.size.height - 40)];
    [self.view addSubview:_tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

}

- (NSArray *)studentsArray {
    if (!_studentsArray) {
        _studentsArray = @[@"Wu yuke", @"Bao yuanshen", @"Yuan bo", @"Hou jianlei", @"Zhu jianbo",
                           @"Wu yuke", @"Bao yuanshen", @"Yuan bo", @"Hou jianlei", @"Zhu jianbo",
                           @"Wu yuke", @"Bao yuanshen", @"Yuan bo", @"Hou jianlei", @"Zhu jianbo",
                           @"Wu yuke", @"Bao yuanshen", @"Yuan bo", @"Hou jianlei", @"Zhu jianbo"];
    }
    return  _studentsArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.studentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *string = self.studentsArray[indexPath.row];
    cell.textLabel.text = string;
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
