//
//  UserDataManager.h
//  benhvien-app
//
//  Created by AnhTien on 9/15/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSUserDefaults+Utility.h"

@interface UserDataManager : NSObject

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *role;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *fullname;

+ (instancetype)shareClient;
- (void)setUserData:(NSDictionary *)data;
- (void)clearUserData;

@end
