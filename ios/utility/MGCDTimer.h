//
//  MGCDTimer.h
//  ios
//
//  Created by 高敏 on 2018/6/6.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGCDTimer : NSObject

+ (MGCDTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                            target:(id)target
                          selector:(SEL)selector
                           repeats:(BOOL)repeats;

//+ (MGCDTimer *)timerWithTimeInterval:(NSTimeInterval)interval
//                               block:(void(^)(MGCDTimer *timer))block
//                             repeats:(BOOL)repeats;


- (instancetype)initWithFireTime:(NSTimeInterval)start
                        interval:(NSTimeInterval)interval
                          target:(id)target
                        selector:(SEL)selector
                         repeats:(BOOL)repeats NS_DESIGNATED_INITIALIZER;

@property (readonly) BOOL repeats;
@property (readonly) NSTimeInterval timeInterval;
@property (readonly, getter=isValid) BOOL valid;

- (void)invalidate;

- (void)fire;

@end
