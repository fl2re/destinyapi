//
//  Util.h
//  DestinyApiTest
//
//  Created by Alexander (Dohrn) Dohrn on 1/15/16.
//  Copyright © 2016 Alexander (Dohrn) Dohrn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Util : NSObject

+ (void)apiCall:(NSString*)endPoint
     withParams:(NSDictionary*)params
  andCompletion:(void (^)(AFHTTPRequestOperation *operation, id responseObject))completion
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *))failed;

+ (void)apiPost:(NSString*)endPoint
     withParams:(NSDictionary*)params
  andCompletion:(void (^)(AFHTTPRequestOperation *operation, id responseObject))completion
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *))failed;

+ (void)apiPut:(NSString *)endPoint
    withParams:(NSDictionary *)params
 andCompletion:(void (^)(AFHTTPRequestOperation *, id))completion
       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *))failed;

+ (void)apiDelete:(NSString *)endPoint
   withCompletion:(void (^)(AFHTTPRequestOperation *, id))completion
          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *))failed;

@end
