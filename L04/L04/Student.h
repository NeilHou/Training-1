//
//  Student.h
//  L02
//
//  Created by MrMessy on 15/5/15.
//  Copyright (c) 2015年 MrMessy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Student : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *studentId;
@property (nonatomic, strong) NSString *studentClass;
@property (nonatomic, strong) NSString *hobby;
@property (nonatomic, retain) UIImage *image;

//+(instancetype)randomItem;

+ (instancetype) studentsCard:(int) value;
@end
