//
//  ViewController.m
//  ios
//
//  Created by 高敏 on 2018/6/5.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "ViewController.h"
#import "iOSExample.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    iOSExample *example = [iOSExample new];
    example.title = @"iOSExample";
    [self pushViewController:example animated:YES];
    
}




@end
