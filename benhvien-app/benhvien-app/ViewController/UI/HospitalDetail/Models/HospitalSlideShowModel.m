//
//  HospitalSlideShowModel.m
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HospitalSlideShowModel.h"

@implementation HospitalSlideShowModel

+ (instancetype)initWithData:(NSDictionary*)hospital {
    HospitalSlideShowModel *obj = [[HospitalSlideShowModel alloc] init];
    [obj parseData:hospital];
    return obj;
}

- (void)parseData:(NSDictionary*)data {
    
}

@end
