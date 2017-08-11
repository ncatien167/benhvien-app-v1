//
//  Hospital.m
//  benhvien-app
//
//  Created by 507-3 on 7/31/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "Hospital.h"

@implementation Hospital

+ (instancetype)initWithRespone:(NSDictionary *)response {
    Hospital *res = [[Hospital alloc] init];
    [res parseResponse:response];
    return res;
}

- (void)parseResponse:(NSDictionary *)response {
    NSString *hospitalId = [response objectForKey:@"_id"];
    if (hospitalId && ![hospitalId isKindOfClass:[NSNull class]]) {
        self.hospitalId = hospitalId;
    }
    
    NSString *avatar = [response objectForKey:@"avatar"];
    if (avatar && ![avatar isKindOfClass:[NSNull class]]) {
        self.avatar = avatar;
    }else {
        self.avatar = @"";
    }
    
    NSString *city = [response objectForKey:@"city"];
    if (city && ![city isKindOfClass:[NSNull class]]) {
        self.city = city;
    }else {
        self.city = @"";
    }
    
    NSString *hospitalDescription = [response objectForKey:@"description"];
    if (hospitalDescription && ![hospitalDescription isKindOfClass:[NSNull class]]) {
        self.hospitalDescription = hospitalDescription;
    }else {
        self.hospitalDescription = @"";
    }
    
    NSString *district = [response objectForKey:@"district"];
    if (district && ![district isKindOfClass:[NSNull class]]) {
        self.district = district;
    }else {
        self.district = @"";
    }
    
    NSArray *images = (NSArray *)[response objectForKey:@"images"];
    if (images && ![images isKindOfClass:[NSNull class]]) {
        self.images = images;
    }else {
        self.images = [NSArray new];
    }
    
    NSNumber *latitude = [response objectForKey:@"latitude"];
    if (latitude && ![latitude isKindOfClass:[NSNull class]]) {
        self.latitude = [latitude doubleValue];
    }
    
    NSNumber *longitude = [response objectForKey:@"longitude"];
    if (longitude && ![longitude isKindOfClass:[NSNull class]]) {
        self.longitude = [longitude doubleValue];
    }
    
    NSString *name = [response objectForKey:@"name"];
    if (name && ![name isKindOfClass:[NSNull class]]) {
        self.name = name;
    }else {
        self.name = @"";
    }
    
    NSArray *phones = (NSArray *)[response objectForKey:@"phones"];
    if (phones && ![phones isKindOfClass:[NSNull class]]) {
        self.phones = phones;
    }else {
        self.phones = [NSArray new];
    }
    
    NSString *street = [response objectForKey:@"street"];
    if (street && ![street isKindOfClass:[NSNull class]]) {
        self.street = street;
    }else {
        self.street = @"";
    }

}

@end
