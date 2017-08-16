//
//  ApiRequest.h
//  benhvien-app
//
//  Created by 507-3 on 8/4/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIkit/UIkit.h>
#import "ApiManager.h"
#import "ApiEndpoint.h"

@interface ApiRequest : NSObject

+ (void)loginWithEmail:(NSString *)email password:(NSString *)password completionBlock:(ApiCompletionBlock)completion;
+ (void)searchHospitalByName:(NSString *)name completionBlock:(ApiCompletionBlock)completion;
+ (void)getHospitalWithCompletion:(ApiCompletionBlock)completion;
+ (void)getHospitalWithHospitalCity:(NSString *)name hospitalDistrict:(NSString *)districtes completion:(ApiCompletionBlock)completion;
+ (void)getHospitalWithHospitalCity:(NSString *)city completion:(ApiCompletionBlock)completion;
+ (void)getHospitalInfoWithId:(NSString *)_id completion:(ApiCompletionBlock)completion;

@end
