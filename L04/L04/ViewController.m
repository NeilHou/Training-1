//
//  ViewController.m
//  L04
//
//  Created by Hanguang on 5/20/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "StudentCell.h"
#import "DetailViewController.h"
#import "AFNetworking.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *studentsArray;
//建一个接受json数据的集合
@property (strong, nonatomic) NSArray *jsonArray;

@end

@implementation ViewController

#pragma mark - View life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    CGRect frame = self.view.bounds;
    self.navigationController.navigationBarHidden = YES;
    //self.navigationItem.title = @"老师好";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"学生"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self action:@selector(showInfo)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Load the NIB file
    UINib *nib = [UINib nibWithNibName:@"StudentCell" bundle:nil];
    
    // Register this NIB, which contains the cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"StudentCell"];

    //[self.tableView registerClass:[StudentCell class] forCellReuseIdentifier:@"StudentCell"];

    [self loadReviews];
}

//写一个读取网络内容的方法
- (void) loadReviews
{
    //初始化jsonArray
    self.jsonArray = [NSArray new];
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    NSString *URL = @"http://api.staging.kangyu.co/v2/hospitals/206/reviews";
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            self.jsonArray = responseObject;
        }
        //抓取信息后刷新
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog (@"网页内容抓取失败");
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}


#pragma mark - Button methods

- (void)showInfo {
    NSLog(@"我了个去啊");
}

#pragma mark - Getter
//- (NSArray *)studentsArray {
//    if (!_studentsArray) {
//        // 生成可变数组
//        NSMutableArray *array = [NSMutableArray array];
//        // 循环5次 生成5个student
//        for (int i =0; i < 4; i++) {
//            // 初始化 student
//            Student *student = [Student studentsCard:i];
//
//            // 添加到数组
//            [array addObject:student];
//        }
//        _studentsArray = [array copy];
//    }
//    return  _studentsArray;
//}

#pragma mark - Tableview delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //更改section的数量
    //return [self.studentsArray count];
    return self.jsonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    StudentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
//    Student *student = self.studentsArray[indexPath.row];
//    ViewController *jsonItem = self.jsonArray[indexPath.row];
    NSDictionary *dict = self.jsonArray[indexPath.row];
    
    // 自定义cell 信息，改为从服务器抓取
    //设置name
    NSString *nameString = dict[@"username"];
    if ([nameString isEqual:[NSNull null]] || (!nameString.length)) {
        nameString = @"NOsee";
    }
    cell.nameLabel.text =nameString;
    [cell.nameLabel sizeToFit];
    //设置age
    cell.ageLabel.text = [NSString stringWithFormat:@"%@",dict[@"avg_rating"]];
    [cell.ageLabel sizeToFit];
    //设置ID
    cell.idLabel.text = [NSString stringWithFormat:@"%@",dict[@"id"]];
    [cell.idLabel sizeToFit];
    //设置class
    cell.classLabel.text = [NSString stringWithFormat:@"%@",dict[@"note"]];
    [cell.classLabel sizeToFit];
     //设置图片
//    cell.mugshotImageVIew.image = student.image;
    //设置时间
//  cell.timeLabel.text = [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",[NSDate date]];// stringWithFormat
    [cell.timeLabel sizeToFit];
    
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    DetailViewController *detailViewController = [[DetailViewController alloc] init];
//    
//    ViewController *selectedStudent = self.jsonArray[indexPath.row];
//    
//    detailViewController *jsonItem = [detailViewController new];
//    
//     = self.jsonArray[indexPath.row];
//    
//    
//    [self.navigationController pushViewController:detailViewController animated:YES];
//
//}



@end
