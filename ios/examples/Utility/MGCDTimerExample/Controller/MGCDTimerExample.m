//
//  MGCDTimerExample.m
//  ios
//
//  Created by 高敏 on 2018/6/6.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "MGCDTimerExample.h"
#import "MGCDTimer.h"

@interface MGCDTimerExample ()

@end

@implementation MGCDTimerExample

- (void)dealloc{
    NSLog(@"MGCDTimerExample -- dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    MGCDTimer *timer = [MGCDTimer timerWithTimeInterval:1 block:^(MGCDTimer *timer) {
//        NSLog(@"123");
//    } repeats:YES];
    
//    MGCDTimer *gcdtimer = [MGCDTimer timerWithTimeInterval:1 target:self selector:@selector(runMGCDTimer:) repeats:YES];
//
////    [gcdtimer fire];
    
   [NSTimer timerWithTimeInterval:1 target:self selector:@selector(runNSTimer) userInfo:nil repeats:NO];
//    [nstimer fire];
    
}

- (void)runNSTimer{
    NSLog(@"runNSTimer -- 123");
}

- (void)runMGCDTimer:(MGCDTimer *)timer{
    NSLog(@"123");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
