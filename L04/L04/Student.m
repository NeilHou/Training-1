//
//  Student.m
//  L04
//
//  Created by Hanguang on 5/20/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import "Student.h"

//@property (strong, nonatomic) NSString *name;
//@property (strong, nonatomic) NSString *age;
//@property (strong, nonatomic) NSString *studentID;


@implementation Student
@synthesize name = _name;
@synthesize age = _age;
@synthesize studentId = _studentId;

- (NSString *)name{
    return _name;
}

- (void)setName:(NSString *)name{
    _name = name;
}

- (NSString *)age{
    
    return _age;
}

- (void)setAge:(NSString *)age{
    _age = age;
}

- (NSString *)studentId{
    return _studentId;
}

- (void)setStudentId:(NSString *)studentId{
    _studentId = studentId;
}


- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@(%@) 学号:%@",
     self.name,
     self.age,
     self.studentId];
    return descriptionString;
}

+(instancetype)randomItem{
    
    NSArray *nameNumber = @[@"jack",@"lucy",@"tom"];
    NSArray *randomAge = @[@"23",@"24",@"25"];
    NSArray *randomId = @[@"54321",@"12345",@"32415"];

    NSInteger nameIndex = arc4random() % [nameNumber count];
    NSInteger ageIndex = arc4random() % [randomAge count];
    NSInteger idIndex = arc4random() % [randomId count];
    
    NSString *randomNameNumber = [NSString stringWithFormat:@"%@",nameNumber[nameIndex]];
    
    NSString *randomAgeNumber = [NSString stringWithFormat:@"%@",randomAge[ageIndex]];
    
    NSString *randomIdNumber = [NSString stringWithFormat:@"%@",
                                randomId[idIndex]];
    
    Student *yb = [[Student alloc]init];
    yb.name = randomNameNumber;
    yb.age = randomAgeNumber;
    yb.studentId = randomIdNumber;
    
    return yb;
}





@end
