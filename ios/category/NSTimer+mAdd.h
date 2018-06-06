//
//  NSTimer+loserAdd.h
//  ios-demo
//
//  Created by 高敏 on 2018/6/5.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (mAdd)

+ (NSTimer *)m_timerWithTimeInterval:(NSTimeInterval)ti
                                      block:(void(^)(NSTimer *timer))block
                                    repeats:(BOOL)repeats;


+ (NSTimer *)m_scheduledWithTimeInterval:(NSTimeInterval)ti
                                      block:(void(^)(NSTimer *timer))block
                                    repeats:(BOOL)repeats;


@end
