//
//  Student.m
//  L02
//
//  Created by MrMessy on 15/5/15.
//  Copyright (c) 2015年 MrMessy. All rights reserved.
//

#import "Student.h"

@implementation Student

- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@(%@) 学号:%@ 年级:%@ %@",
     self.name,
     self.age,
     self.studentId,
     self.studentClass,
     self.hobby];
    return descriptionString;
}

+(instancetype)randomItem{
    
    NSArray *nameNumber = @[@"朱剑波",@"张三",@"李四"];
    NSArray *randomAge = @[@"23",@"24",@"25"];
    NSArray *randomId = @[@"1006030",@"1006040",@"1006050"];
    NSArray *classNumber = @[@"一年级",@"二年级",@"三年级"];
    NSArray *hobbyNumber = @[@"篮球",@"足球",@"网球"];
    NSArray *studentImage = @[@"student_01.JPG",@"student_02.JPG",@"student_03.JPG",@"student_04.JPG"];
    
    NSInteger nameIndex = arc4random() % [nameNumber count];
    NSInteger ageIndex = arc4random() % [randomAge count];
    NSInteger idIndex = arc4random() % [randomId count];
    NSInteger classIndex = arc4random() % [classNumber count];
    NSInteger hobbyIndex = arc4random() % [hobbyNumber count];
    NSInteger imageIndex = arc4random() % [studentImage count];
    
    NSString *randomNameNumber = [NSString stringWithFormat:@"%@",nameNumber[nameIndex]];
    
    NSString *randomAgeNumber = [NSString stringWithFormat:@"%@",randomAge[ageIndex]];
    
    NSString *randomIdNumber = [NSString stringWithFormat:@"%@",
                                randomId[idIndex]];
    NSString *randomClassNumber = [NSString stringWithFormat:@"%@",classNumber[classIndex]];
    
    NSString *randomHobbyNumber = [NSString stringWithFormat:@"%@",hobbyNumber[hobbyIndex]];
    NSString *randomStudentImage = [NSString stringWithFormat:@"%@",studentImage[imageIndex]];
    
    Student *jb = [[Student alloc]init];
    jb.name = randomNameNumber;
    jb.age = randomAgeNumber;
    jb.studentId = randomIdNumber;
    jb.studentClass = randomClassNumber;
    jb.hobby = randomHobbyNumber;
    jb.image = [UIImage imageNamed:randomStudentImage];

    return jb;
}
@end
