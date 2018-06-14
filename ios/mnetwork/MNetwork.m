//
//  MNetwork.m
//  ios
//
//  Created by 高敏 on 2018/6/11.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "MNetwork.h"


//#define force_inline __inline__ __attribute__((always_inline))
//
//static force_inline NSString *methodFromHTTPMethod(HTTPMethod method){
//    switch (method) {
//        case GET:
//            return @"GET";
//            break;
//            case POST:
//            return @"POST";
//        default:
//            return @"GET";
//            break;
//    }
//}

@interface MNetwork ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableDictionary *tasks;
@property (nonatomic, strong) NSMutableArray *dataFilters;

@end

@implementation MNetwork

- (instancetype)init{
    return [self initWithBaseUrl:@""];
}

- (instancetype)initWithBaseUrl:(NSString *)baseUrl{
    self = [super init];
    if (!self)  return nil;
    self.baseUrl = baseUrl;
    self.tasks = [NSMutableDictionary dictionary];
    self.dataFilters = [NSMutableArray array];
    self.ignoreBaseUrl = NO;
    return self;
}

- (AFHTTPSessionManager *)sessionManager{
    if (_sessionManager) return _sessionManager;
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return _sessionManager;
}

- (void)configAcceptable:(NSSet *)acceptable{
    [self.sessionManager.responseSerializer setAcceptableContentTypes:acceptable];
}

- (void)configRequesSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer{
    self.sessionManager.requestSerializer = requestSerializer;
    self.sessionManager.responseSerializer = responseSerializer;
}

- (void)configHTTPHeaders:(NSDictionary *)httpHeaders{
    
    for (NSString *key in httpHeaders.allKeys) {
        [self.sessionManager.requestSerializer setValue:httpHeaders[key] forHTTPHeaderField:key];
    }
}

- (void)addDataFilter:(id (^)(id))dataFilter{
    [self.dataFilters addObject:dataFilter];
}



- (NSURLSessionTask *)requestWithUrl:(NSString *)url
                          httpMethod:(HTTPMethod)httpMethod
                              params:(id)params
                            progress:(void (^)(NSProgress *))progress
                             success:(void (^)(id))success
                             failure:(void (^)(NSError *))failure{
    NSString *fullUrl = nil;
    if (self.ignoreBaseUrl) {
        fullUrl = url;
    }else{
        fullUrl = [NSString stringWithFormat:@"%@%@", self.baseUrl, url];
    }
    
    if (fullUrl.length == 0) {
        NSError *error = [NSError errorWithDomain:@"MNetwork" code:1 userInfo:@{NSLocalizedDescriptionKey:@"Your MNetwork's url is nil, please check out your url!"}];
        failure(error);
        return nil;
    }
    
    if (![NSURL URLWithString:fullUrl]) {
        NSError *error = [NSError errorWithDomain:@"MNetwork" code:2 userInfo:@{NSLocalizedDescriptionKey:@"Your Network has a error url, please check out your url!"}];
        failure(error);
        return nil;
    }
    
    __weak typeof(self) _self = self;
    NSURLSessionTask *networkTask = nil;
    if (httpMethod == GET) {
        
        networkTask = [self.sessionManager GET:fullUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_self requestSuccess:url HttpMethod:GET params:params task:task result:responseObject success:success failure:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [_self requestFailure:fullUrl HttpMethod:GET params:params task:task error:error failure:failure];
        }];
        return networkTask;
    }else if (httpMethod == POST){
       networkTask = [self.sessionManager POST:fullUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_self requestSuccess:url HttpMethod:POST params:params task:task result:responseObject success:success failure:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [_self requestFailure:fullUrl HttpMethod:POST params:params task:task error:error failure:failure];
        }];
        return networkTask;
    }
    
    if (!networkTask) {
        NSError *error = [NSError errorWithDomain:@"MNetwork" code:3 userInfo:@{NSLocalizedDescriptionKey:@"Your Network's sessionTask is nil, please check out your HTTPMethod!"}];
        failure(error);
    }
    
    return nil;
}


- (void)requestSuccess:(NSString *)url
            HttpMethod:(HTTPMethod)httpMethod
                params:(id)params
                  task:(NSURLSessionTask*)task
                 result:(id)result
               success:(void (^)(id))success
               failure:(void (^)(NSError *))failure{
    NSString *responseObj = result;
    for (id (^filter)(id) in self.dataFilters) {
        id obj = filter(responseObj);
        if ([obj isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)obj;
            [self requestFailure:url HttpMethod:httpMethod params:params task:task error:error failure:failure];
            return;
        }else{
            responseObj = obj;
        }
    }
    if (success) {
        success(responseObj);
    }
    
}




- (void)requestFailure:(NSString *)url
            HttpMethod:(HTTPMethod)httpMethod
                params:(id)params
                  task:(NSURLSessionTask*)task
                 error:(NSError *)error
               failure:(void (^)(NSError *))failure{
    
    if (failure) {
        failure(error);
    }
    
}



- (NSURLSessionTask *)POST:(NSString *)url
                    params:(id)params
                  progress:(void (^)(NSProgress *))progress
                   success:(void (^)(id))success
                   failure:(void (^)(NSError *))failure{
    return [self requestWithUrl:url httpMethod:POST params:params progress:progress success:success failure:failure];
}

- (NSURLSessionTask *)GET:(NSString *)url
                   params:(id)params
                 progress:(void (^)(NSProgress *))progress
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure{
    return [self requestWithUrl:url httpMethod:GET params:params progress:progress success:success failure:failure];
}


@end

@implementation MNetwork (Promise)

- (AnyPromise *)GET:(NSString *)url params:(id)params{
    return [self GET:url params:params progress:nil];
}

- (AnyPromise *)GET:(NSString *)url params:(id)params progress:(void (^)(NSProgress *))progress{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
       
        [self GET:url params:params progress:progress success:^(id responseObj) {
            resolve(responseObj);
        } failure:^(NSError *error) {
            resolve(error);
        }];
    }];
}

- (AnyPromise *)POST:(NSString *)url params:(id)params{
    return [self POST:url params:params progress:nil];
}

- (AnyPromise *)POST:(NSString *)url params:(id)params progress:(void (^)(NSProgress *))progress{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
        
        [self POST:url params:params progress:progress success:^(id responseObj) {
            resolve(responseObj);
        } failure:^(NSError *error) {
            resolve(error);
        }];
        
    }];
}


@end


