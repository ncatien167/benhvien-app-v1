//
//  ApiRequest.m
//  benhvien-app
//
//  Created by 507-3 on 8/4/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "ApiRequest.h"

@implementation ApiRequest

+ (void)loginWithEmail:(NSString *)email password:(NSString *)password completionBlock:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"email": email,
                                 @"password": password
                                 };
    [[ApiManager sharedClient] requestApiWithEndpoint:Login method:POST parameters:parameters hasAuth:(BOOL)false completion:completion];
}

+ (void)searchHospitalByName:(NSString *)name completionBlock:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"name": name,
                                 };
    [[ApiManager sharedClient] requestApiWithEndpoint:SearchByName method:GET parameters:parameters hasAuth:(BOOL)true completion:completion];
}

+ (void)getHospitalWithCompletion:(ApiCompletionBlock)completion {
    [[ApiManager sharedClient] requestApiWithEndpoint:Cities method:GET parameters:nil hasAuth:(BOOL)true completion:completion];
}

+ (void)getHospitalWithHospitalCity:(NSString *)name hospitalDistrict:(NSString *)districtes page:(NSInteger)page completion:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"city": name,
                                 @"district": districtes,
                                 @"page": @(page)};
    [[ApiManager sharedClient] requestApiWithEndpoint:SearchByDistrictCity method:GET parameters:parameters hasAuth:(BOOL)true completion:completion];
}

+ (void)getHospitalWithHospitalCity:(NSString *)city page:(NSInteger)page completion:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"city": city,
                                 @"page": @(page)};
    [[ApiManager sharedClient] requestApiWithEndpoint:SearchByCity method:GET parameters:parameters hasAuth:(BOOL)true completion:completion];
}

+ (void)getHospitalInfoWithId:(NSString *)_id completion:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"id": _id
                                 };
    [[ApiManager sharedClient] requestApiWithEndpoint:HospitalInfo method:GET parameters:parameters hasAuth:(BOOL)true completion:completion];
}

+ (void)registerUser:(NSString *)email password:(NSString *)password city:(NSString *)city fullName:(NSString *)fullName completion:completion {
    NSDictionary *paramaters = @{@"email": email,
                                 @"password": password,
                                 @"role": @"email",
                                 @"city": city,
                                 @"fullName": fullName};
    [[ApiManager sharedClient] requestApiWithEndpoint:Register method:POST parameters:paramaters hasAuth:(BOOL)false completion:completion];
}

+ (void)changePasswordWithUserId:(NSString *)userId oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completion:(ApiCompletionBlock)completion {
    NSDictionary *paramaters = @{@"password": oldPassword,
                                 @"newPassword": newPassword,
                                 @"id": userId
                                 };
    [[ApiManager sharedClient] requestApiWithEndpoint:ChangePassword method:PUT parameters:paramaters hasAuth:true completion:completion];
}

@end
