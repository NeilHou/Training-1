//
//  ViewController.m
//  L04
//
//  Created by Hanguang on 5/20/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *studentsArray;

@end

@implementation ViewController

#pragma mark - View life cycle
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

#pragma mark - Getter
- (NSArray *)studentsArray {
    if (!_studentsArray) {
        // 生成可变数组
        NSMutableArray *array = [NSMutableArray array];
        // 循环5次 生成5个student
        for (int i =0; i < 5; i++) {
            // 初始化 student
            Student *student = [Student randomItem];
            
//            student.name =  @"朱剑波";
//            student.age = @"24";
//            student.studentId = @"100603170";
//            student.studentClass = @"一年级";
//            student.hobby = @"篮球";
            //TODO: 自定义学生变量 name age id
            

            // 添加到数组
            [array addObject:student];
       
        }
        
        _studentsArray = [array copy];
    }
    return  _studentsArray;
}
//push

#pragma mark - Tableview delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.studentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Student *student1 = self.studentsArray[indexPath.row];
    
    cell.textLabel.text = [student1 description];
    
    //设置字体大小
//    cell.textLabel.font = [UIFont systemFontOfSize:30];
    
    //设置cell高度
    self.tableView.rowHeight = 100;
    
    //设置accessorytype符号
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    //设置字体颜色
    cell.textLabel.textColor = [UIColor redColor];
    //sss
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
