//
//  ApiResponse.h
//  benhvien-app
//
//  Created by 507-3 on 8/4/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiResponse : NSObject

@property (nonatomic, strong) NSDictionary *originalResponse;
@property (nonatomic, strong) id data;
@property (nonatomic) BOOL sucsess;
@property (nonatomic, strong) NSString *message;

+ (instancetype)initWithRespone:(NSDictionary *)response;

@end
