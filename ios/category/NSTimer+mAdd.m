//
//  NSTimer+loserAdd.m
//  ios-demo
//
//  Created by 高敏 on 2018/6/5.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "NSTimer+mAdd.h"

@implementation NSTimer (mAdd)


+ (NSTimer *)m_timerWithTimeInterval:(NSTimeInterval)ti
                                                  block:(void(^)(NSTimer *timer))block
                                                repeats:(BOOL)repeats {
    NSTimer *timer = [NSTimer timerWithTimeInterval:ti
                                             target:self
                                           selector:@selector(m_block:)
                                           userInfo:block
                                            repeats:repeats];
    return timer;
}

+ (NSTimer *)m_scheduledWithTimeInterval:(NSTimeInterval)ti block:(void (^)(NSTimer *))block repeats:(BOOL)repeats{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti
                                                      target:self
                                                    selector:@selector(m_block:)
                                                    userInfo:block
                                                     repeats:repeats];
    return timer;
}


+ (void)m_block:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = timer.userInfo;
    if ( block ) block(timer);
}

@end
