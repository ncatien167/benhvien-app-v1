//
//  UserDataManager.m
//  benhvien-app
//
//  Created by AnhTien on 9/15/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "UserDataManager.h"
#import "Constants.h"

@implementation UserDataManager
@synthesize accessToken = _accessToken;
@synthesize userId = _userId;
@synthesize role = _role;
@synthesize email = _email;
@synthesize city = _city;
@synthesize fullname = _fullname;

+ (instancetype)shareClient {
    static UserDataManager *_sharedClient = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        _sharedClient = [[UserDataManager alloc] init];
    });
    return _sharedClient;
}

- (void)setUserData:(NSDictionary *)data {
    self.accesToken = [data objectForKey:@"token"];
    self.userId = [data objectForKey:@"userId"];
    self.role = [data objectForKey:@"role"];
    self.email = [data objectForKey:@"email"];
    self.city = [data objectForKey:@"city"];
    self.fullname = [data objectForKey:@"fullName"];
}

- (void)clearUserData {
    [NSUserDefaults setObject:nil forKey:UserToken];
    [NSUserDefaults setObject:nil forKey:UserId];
    [NSUserDefaults setObject:nil forKey:UserEmai];
    [NSUserDefaults setObject:nil forKey:UserFullName];
    [NSUserDefaults setObject:nil forKey:UserRole];
    [NSUserDefaults setObject:nil forKey:UserCity];
}

- (void)setAccesToken:(NSString *)accessToken {
    _accessToken = accessToken;
    [NSUserDefaults setObject:accessToken forKey:UserToken];
}

- (NSString *)accessToken {
    NSString *accessToken = [NSUserDefaults objectForKey:UserToken];
    if (accessToken) {
        return accessToken;
    } else {
        return  @"";
    }
}

- (void)setFullname:(NSString *)fullname {
    _fullname = fullname;
    [NSUserDefaults setObject:fullname forKey:UserFullName];
}

- (NSString *)fullname {
    NSString *fullname = [NSUserDefaults objectForKey:UserFullName];
    if (fullname) {
        return fullname;
    } else {
        return  @"";
    }
}

- (void)setUserId:(NSString *)userId {
    _userId = userId;
    [NSUserDefaults setObject:userId forKey:UserId];
}

- (NSString *)userId {
    NSString *userId = [NSUserDefaults objectForKey:UserId];
    if (userId) {
        return userId;
    } else {
        return  @"";
    }
}

- (void)setRole:(NSString *)role {
    _role = role;
    [NSUserDefaults setObject:role forKey:UserRole];
}

- (NSString *)role {
    NSString *role = [NSUserDefaults objectForKey:UserRole];
    if (role) {
        return role;
    } else {
        return  @"";
    }
}

- (void)setEmail:(NSString *)email {
    _email = email;
    [NSUserDefaults setObject:email forKey:UserEmai];
}

- (NSString *)email {
    NSString *email = [NSUserDefaults objectForKey:UserEmai];
    if (email) {
        return email;
    } else {
        return  @"";
    }
}

- (void)setCity:(NSString *)city {
    _city = city;
    [NSUserDefaults setObject:city forKey:UserCity];
}

- (NSString *)city {
    NSString *city = [NSUserDefaults objectForKey:UserCity];
    if (city) {
        return city;
    } else {
        return  @"";
    }
}

@end
