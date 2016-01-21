//
//  Util.m
//  DestinyApiTest
//
//  Created by Alexander (Dohrn) Dohrn on 1/15/16.
//  Copyright © 2016 Alexander (Dohrn) Dohrn. All rights reserved.
//

#import "Util.h"

NSString *API_KEY = @"478820c9e7cd48918f046502c668b848";

@implementation Util

+ (void)apiCall:(NSString *)endPoint withParams:(NSDictionary *)params andCompletion:(void (^)(AFHTTPRequestOperation *, id))completion failure:(void (^)(AFHTTPRequestOperation *operation, NSError *))failed{
    
    NSLog(endPoint);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:API_KEY forHTTPHeaderField:@"X-API-Key"];
    
    [manager
     GET:endPoint
	    parameters:params
     success: ^(AFHTTPRequestOperation *operation, id responseObject) {
         completion(operation, responseObject);
     }
     failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
         failed(operation, error);
     }];
}

//+ (void)apiPost:(NSString *)endPoint withParams:(NSDictionary *)params andCompletion:(void (^)(AFHTTPRequestOperation *, id))completion failure:(void (^)(AFHTTPRequestOperation *operation, NSError *))failed{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy = securityPolicy;
//    manager.securityPolicy.validatesDomainName = NO;
//    
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager
//     POST:endPoint
//	    parameters:params
//     success: ^(AFHTTPRequestOperation *operation, id responseObject) {
//         completion(operation, responseObject);
//     }
//     failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
//         failed(operation, error);
//     }];
//}
//
//+ (void)apiPut:(NSString *)endPoint withParams:(NSDictionary *)params andCompletion:(void (^)(AFHTTPRequestOperation *, id))completion failure:(void (^)(AFHTTPRequestOperation *operation, NSError *))failed{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy = securityPolicy;
//    manager.securityPolicy.validatesDomainName = NO;
//    
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager
//     PUT:endPoint
//	    parameters:params
//     success: ^(AFHTTPRequestOperation *operation, id responseObject) {
//         completion(operation, responseObject);
//     }
//     failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
//         failed(operation, error);
//     }];
//}
//
//+ (void)apiDelete:(NSString *)endPoint withCompletion:(void (^)(AFHTTPRequestOperation *, id))completion failure:(void (^)(AFHTTPRequestOperation *operation, NSError *))failed{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy = securityPolicy;
//    manager.securityPolicy.validatesDomainName = NO;
//    
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager
//     DELETE:endPoint
//	    parameters:@{}
//     success: ^(AFHTTPRequestOperation *operation, id responseObject) {
//         completion(operation, responseObject);
//     }
//     failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
//         failed(operation, error);
//     }];
//}

@end
