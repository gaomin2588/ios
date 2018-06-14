//
//  MNetworkExample.m
//  ios
//
//  Created by 高敏 on 2018/6/14.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "MNetworkExample.h"
#import "MNetworkManager.h"
#import "NSString+mAdd.h"

static NSString *kMsgUnReadSum = @"/uc/shortMsg/tenantUnReadSum";


@interface MNetworkExample ()

@end

@implementation MNetworkExample

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *params = @{@"uId":@9};
    [[MNetworkManager shared] GET:kMsgUnReadSum params:params].
    then(^(id response){
        NSLog(@"response1 -- %@", response);
        return [[MNetworkManager shared] GET:kMsgUnReadSum params:params];
    }).then (^(id response){
        NSLog(@"response2 -- %@", response);
    }).then (^(id response){
        NSLog(@"response3 -- %@", response);
    }).catch(^(NSError *error){
        NSLog(@"error -- %@", error);
    });
    
    
    
    PMKWhen(@[[self task1], [self task2], [self task3]]).then(^(NSArray *tasks){
        NSLog(@"tasks -- %@", tasks);
    }).catch(^(NSError *error){
        NSLog(@"tasks -error -- %@", error);
    });
    
    PMKWhen(@[[self task4], [self task5], [self task6]]).then(^(NSArray *tasks){
        NSLog(@"tasks -- %@", tasks);
    }).catch(^(NSError *error){
        NSLog(@"tasks -error -- %@", error);
    });


}

- (AnyPromise *)task1{
    
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver reslover) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                reslover(@"task1");
            });
        });

    }];
}
- (AnyPromise *)task2{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver reslover) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                reslover(@"task2");
            });
        });

    }];
}
-(AnyPromise *)task3{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver reslover) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                reslover(@"task3");
            });
        });

    }];
}

-(AnyPromise *)task4{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver reslover) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                reslover(@"task4");
            });
        });
        
    }];
}

-(AnyPromise *)task5{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver reslover) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                reslover(@"task5");
            });
        });
        
    }];
}
-(AnyPromise *)task6{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver reslover) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSError *error = [NSError errorWithDomain:@"task6" code:6 userInfo:@{NSLocalizedDescriptionKey:@"taks6 is error"}];
                reslover(error);
            });
        });
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
