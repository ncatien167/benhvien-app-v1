//
//  ApiManager.h
//  benhvien-app
//
//  Created by 507-3 on 8/4/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
#import <AFNetworking/AFNetworking.h>
#import "ApiResponse.h"

typedef enum {
    GET,
    POST,
    PUT
}ApiMethod;

typedef void (^ApiCompletionBlock)(ApiResponse *response, NSError *error);

@interface ApiManager : NSObject

+ (instancetype)sharedClient;

- (void)requestApiWithEndpoint:(NSString *)endpoint method:(ApiMethod)method parameters:(NSDictionary *)parameters  hasAuth:(BOOL)hasAuth completion:(ApiCompletionBlock)completion;

@end
