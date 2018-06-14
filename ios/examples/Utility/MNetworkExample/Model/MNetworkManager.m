//
//  MNetworkManager.m
//  ios
//
//  Created by 高敏 on 2018/6/14.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "MNetworkManager.h"
#import "NSString+mAdd.h"

static NSString *baseUrl = @"https://zufang.zooming-data.com";

@implementation MNetworkManager

+ (MNetwork *)shared{
    static MNetwork *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MNetwork alloc] initWithBaseUrl:baseUrl];
        [sharedInstance configRequesSerializer:[AFHTTPRequestSerializer serializer] responseSerializer:[AFJSONResponseSerializer serializer]];
        [sharedInstance configAcceptable:[NSSet setWithArray:@[@"application/json", @"text/plain"]]];
        [sharedInstance addDataFilter:^id (id result) {
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                BOOL success = result[@"success"];
                if (success == YES) {
                    return result[@"models"];
                }else{
                    NSError *error = [NSError errorWithDomain:@"MNetworkManager" code:888 userInfo:@{NSLocalizedDescriptionKey:result[@"errorMap"]}];
                    return error;
                }
            }
            
            return result;
        }];
    });
    
    NSString *time = [NSString stringWithFormat:@"%@",@((long)[[NSDate date] timeIntervalSince1970] * 1000)];
    NSString *token = @"94f65ec8-30e6-4ec2-a711-767e1aa2f638";
    NSString *salt = @"bd33e00cb003b58472e4995ad147e2d8";
    NSString *userId = @"9";
    NSString *valueCode = [[NSString stringWithFormat:@"%@%@%@%@",token,userId,time,salt] m_md5];
    [sharedInstance configHTTPHeaders:@{@"token":token,@"time":time, @"valueCode":valueCode}];
    
    return sharedInstance;
}

@end
