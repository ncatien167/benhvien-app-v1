//
//  City.h
//  benhvien-app
//
//  Created by 507-3 on 8/14/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *district;

+ (instancetype)initWithData:(NSDictionary *)response;

@end
