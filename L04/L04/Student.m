//
//  Student.m
//  L04
//
//  Created by Hanguang on 5/20/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import "Student.h"

@implementation Student

+(instancetype)randomItem
{
    NSArray *nameNumber = @[@"harden",@"howard",@"ariza"];
    NSArray *randomAge = @[@"20",@"21",@"28"];
    NSArray *randomId = @[@"001",@"002",@"003"];
    NSArray *classNumber = @[@"one",@"two",@"three"];
    NSArray *hobbyNumber = @[@"basketball",@"soccoer",@"baseball"];

    
    
    NSInteger nameIndex = arc4random() % [nameNumber count];
    NSInteger ageIndex = arc4random() % [randomAge count];
    NSInteger idIndex = arc4random() % [randomId count];
    NSInteger classIndex = arc4random() % [classNumber count];
    NSInteger hobbyIndex = arc4random() % [hobbyNumber count];

    NSString *randomNameNumber = [NSString stringWithFormat:@"%@",nameNumber[nameIndex]];

    NSString *randomAgeNumber = [NSString stringWithFormat:@"%@",randomAge[ageIndex]];
    
    NSString *randomIdNumber = [NSString stringWithFormat:@"%@",randomId[idIndex]];
    
    NSString *randomClassNumber = [NSString stringWithFormat:@"%@",classNumber[classIndex]];
    
    NSString *randomHobbyNumber = [NSString stringWithFormat:@"%@",hobbyNumber[hobbyIndex]];
    
    Student *jl = [Student new];
    jl.name = randomNameNumber;
    jl.age = randomAgeNumber;
    jl.studentID = randomIdNumber;
    jl.studentClass = randomClassNumber;
    jl.hobby = randomHobbyNumber;
    
    return jl;
}


- (NSString *)description
{
     NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@-%@ ID-%@ Grade-%@ likes %@",self.name,self.age,self.studentID,self.studentClass,self.hobby];
    
    return descriptionString;
}



@end
