//
//  ApiResponse.m
//  benhvien-app
//
//  Created by 507-3 on 8/4/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "ApiResponse.h"

@implementation ApiResponse

+ (instancetype)initWithRespone:(NSDictionary *)response {
    ApiResponse *servoResponse = [[ApiResponse alloc] init];
    [servoResponse parseResponse:response];
    return servoResponse;
}

- (void)parseResponse:(NSDictionary *)response {  
    NSString *message = [response objectForKey:@"message"];
    if ([message isKindOfClass:[NSNull class]]) {
        self.message = @"";
    }else {
        self.message = message;
    }
    
    NSNumber *success = [response objectForKey:@"success"];
    if (success) {
        self.sucsess = [success boolValue];
    }
    
    self.data = [response objectForKey:@"data"];
    self.originalResponse = response;
}

@end
