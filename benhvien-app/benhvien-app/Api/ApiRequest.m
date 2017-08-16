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
    [[ApiManager sharedClient] requestApiWithEndpoint:Login method:POST parameters:parameters completion:completion];
}

+ (void)searchHospitalByName:(NSString *)name completionBlock:(ApiCompletionBlock)completion {
    NSDictionary *parameters = @{@"name": name,
                                 };
    [[ApiManager sharedClient] requestApiWithEndpoint:SearchByName method:GET parameters:parameters completion:completion];
}

+ (void)getHospitalCities:(ApiCompletionBlock)completion {
    [[ApiManager sharedClient] requestApiWithEndpoint:Cities method:GET parameters:nil completion:completion];
}

@end
