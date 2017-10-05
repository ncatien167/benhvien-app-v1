//
//  ApiManager.m
//  benhvien-app
//
//  Created by 507-3 on 8/4/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "ApiManager.h"
#import "ApiEndpoint.h"
#import "UserDataManager.h"
@interface ApiManager ()
{
    
}

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation ApiManager

+ (instancetype)sharedClient {
    static ApiManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ApiManager alloc] init];
        [_sharedClient setupManager];
    });
    return  _sharedClient;
}

- (void)setupManager {
    self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
}

-(void)setupHeader {
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content_Type"];
    [self.manager.requestSerializer setValue:[self getAccessToken] forHTTPHeaderField:@"Authorization"];
}

- (NSString *)getAccessToken {
    NSString *token = [NSString stringWithFormat:@"JWT %@",[UserDataManager shareClient].accessToken];
    return token;
}

- (void)requestApiWithEndpoint:(NSString *)endpoint
                        method:(ApiMethod)method
                    parameters:(NSDictionary *)parameters
                       hasAuth:(BOOL)hasAuth
                    completion:(ApiCompletionBlock)completion {
    NSString *fullURL = [NSString stringWithFormat:@"%@%@", BaseURL, endpoint];
    if (hasAuth) {
        [self setupHeader];
    }
    [self setupHeader];
    switch (method) {
        case GET: {
            [self processGetRequestWithURL:fullURL parameters:parameters completion:completion];
            break;
        }
        case POST: {
            [self processPostRequestWithURL:fullURL parameters:parameters completion:completion];
            break;
        }
        case PUT: {
            [self processPutRequestWithURL:fullURL parameters:parameters completion:completion];
            break;
        }
        default:
            break;
    }
}

#pragma mark - GET

- (void)processGetRequestWithURL:(NSString *)url
                      parameters:(NSDictionary *)parameters
                      completion:(ApiCompletionBlock)completion {
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self processSuccessWithRespone:responseObject completion:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self processFailureWithError:error completion:completion];
    }];
}

#pragma mark - POST

- (void)processPostRequestWithURL:(NSString *)url
                       parameters:(NSDictionary *)parameters
                       completion:(ApiCompletionBlock)completion {
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self processSuccessWithRespone:responseObject completion:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self processFailureWithError:error completion:completion];
    }];
}

#pragma mark - PUT
- (void)processPutRequestWithURL:(NSString *)url
                      parameters:(NSDictionary *)parameters
                      completion:(ApiCompletionBlock)completion {
    [self.manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self processSuccessWithRespone:responseObject completion:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self processFailureWithError:error completion:completion];
    }];
}

#pragma  mark - SUCCESS

- (void)processSuccessWithRespone:(id)responseObject completion:(ApiCompletionBlock)completion {
    ApiResponse *res = [ApiResponse initWithRespone:responseObject];
    if (completion) {
        completion(res, nil);
        NSLog(@"%@",responseObject);
    }
}

#pragma  mark - FAILURE

- (void)processFailureWithError:(NSError *)error completion:(ApiCompletionBlock)completion {
    if (completion) {
        completion(nil, error);
        NSLog(@"%@",error);
    }
}

@end
