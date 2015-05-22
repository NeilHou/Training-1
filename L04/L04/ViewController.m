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
//ssssss
//test2

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
    self.tableView.rowHeight = 100;
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Load the NIB file
    UINib *nib = [UINib nibWithNibName:@"StudentCell" bundle:nil];
    
    // Register this NIB, which contains the cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"StudentCell"];

    //[self.tableView registerClass:[StudentCell class] forCellReuseIdentifier:@"StudentCell"];

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
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    StudentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
    Student *student = self.studentsArray[indexPath.row];
    
    // 自定义cell 信息
    cell.imageView.image = [UIImage imageNamed:@"student_01.jpg"];
    cell.idLabel.text = student.studentId;
    cell.nameLabel.text = student.name;
    cell.classLabel.text = student.studentClass;
    cell.timeLabel.text = [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]];// stringWithFormat
    
    //设置字体大小
//    cell.textLabel.font = [UIFont systemFontOfSize:30];
    
    //设置cell高度
//
//    
//    //设置accessorytype符号
//    cell.accessoryType = UITableViewCellAccessoryDetailButton;
//    
//    //设置字体颜色
//    cell.textLabel.textColor = [UIColor redColor];
//    //sss
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 44.f;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
