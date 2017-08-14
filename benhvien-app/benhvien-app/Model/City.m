//
//  City.m
//  benhvien-app
//
//  Created by 507-3 on 8/14/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "City.h"

@implementation City

+ (instancetype)initWithData:(NSDictionary *)response {
    City *cities = [[City alloc] init];
    [cities parseData:response];
    return cities;
}

- (void)parseData:(NSDictionary *)data {
    NSString *name = [data objectForKey:@"name"];
    if (name && ![name isKindOfClass:[NSNull class]]) {
        self.name = name;
    }
    
    NSArray *districtes = [data objectForKey:@"districtes"];
    if (districtes && ![districtes isKindOfClass:[NSNull class]]) {
        self.district = [NSMutableArray new];
        for (NSDictionary *districtData in districtes) {
            NSString *districtName = [districtData objectForKey:@"name"];
            [self.district addObject:districtName];
        }
    }else {
        self.district = [NSMutableArray new];
    }
}

@end
