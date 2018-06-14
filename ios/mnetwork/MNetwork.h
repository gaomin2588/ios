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


//- (instancetype)init UNAVAILABLE_ATTRIBUTE;
//+ (instancetype)new UNAVAILABLE_ATTRIBUTE;


- (instancetype)initWithBaseUrl:(NSString *)baseUrl;

// default is NO
@property (nonatomic) BOOL ignoreBaseUrl;

@property (nonatomic, copy) NSString *baseUrl;


- (void)configAcceptable:(NSSet *)acceptable;

- (void)configHTTPHeaders:(NSDictionary *)httpHeaders;

- (void)configRequesSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer
      responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer;


- (void)addDataFilter:(id (^)(id result))dataFilter;


- (NSURLSessionTask *)requestWithUrl:(NSString *)url
                          httpMethod:(HTTPMethod)httpMethod
                              params:(id)params
                            progress:(void (^)(NSProgress *downloadProgress))progress
                             success:(void (^)(id result))success
                             failure:(void (^)(NSError *error))failure;

- (NSURLSessionTask *)POST:(NSString *)url
                    params:(id)params
                  progress:(void (^)(NSProgress *))progress
                   success:(void (^)(id))success
                   failure:(void (^)(NSError *))failure;

- (NSURLSessionTask *)GET:(NSString *)url
                   params:(id)params
                 progress:(void (^)(NSProgress *))progress
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure;


@end



@interface MNetwork (Promise)

- (AnyPromise *)GET:(NSString *)url
             params:(id)params;

- (AnyPromise *)GET:(NSString *)url
             params:(id)params
           progress:(void (^)(NSProgress *))progress;

- (AnyPromise *)POST:(NSString *)url
              params:(id)params;

- (AnyPromise *)POST:(NSString *)url
              params:(id)params
            progress:(void (^)(NSProgress *))progress;


@end









