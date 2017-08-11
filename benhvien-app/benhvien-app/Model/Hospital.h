//
//  Hospital.h
//  benhvien-app
//
//  Created by 507-3 on 7/31/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hospital : NSObject

@property (strong, nonatomic) NSString *hospitalId;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *hospitalDescription;
@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSArray *images;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *phones;
@property (strong, nonatomic) NSString *street;

+ (instancetype)initWithRespone:(NSDictionary *)response;

@end
