//
//  MNetwork.h
//  ios
//
//  Created by 高敏 on 2018/6/11.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <PromiseKit/PromiseKit.h>

typedef NS_ENUM(NSInteger, HTTPMethod) {
    GET,
    POST
};



@interface MNetwork : NSObject

@property (nonatomic, copy, readonly) NSString *baseUrl;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithBaseUrl:(nullable NSString *)baseUrl;

- (void)configAcceptable:(NSSet *)acceptable;

- (void)configHTTPHeaders:(NSDictionary *)httpHeaders;

- (void)configRequesSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer
      responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer;


- (void)addDataFilter:(id (^)(id result))dataFilter;


- (nullable NSURLSessionTask *)requestWithUrl:(NSString *)url
                          httpMethod:(HTTPMethod)httpMethod
                              params:(nullable id)params
                            progress:(nullable void (^)(NSProgress *downloadProgress))progress
                             success:(nullable void (^)(id result))success
                             failure:(nullable void (^)(NSError *error))failure;


@end
