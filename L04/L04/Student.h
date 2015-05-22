//
//  Student.h
//  L04
//
//  Created by Hanguang on 5/20/15.
//  Copyright (c) 2015 Hanguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *studentID;
@property (strong, nonatomic) NSString *studentClass;
@property (strong, nonatomic) NSString *hobby;

+(instancetype)randomItem;
@end
