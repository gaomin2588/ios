//
//  UITextField+mAdd.h
//  ios
//
//  Created by 高敏 on 2018/6/6.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, TextLimitOptions) {
    // 没有限制
    TextLimitNone                                = 1 << 0,
    // 过滤表情符号
    TextLimitEmoji                               = 1 << 1,
    // 过滤非法字符串
    TextLimitUnlawfulCharacter                   = 1 << 2,
    // 过滤非汉字、字母、数字字符
    TextLimitOnlyExistChineseOrLetterOrNumber    = 1 << 3,
    // 自定义需要的过滤字符串 RegularExpression
    TextLimitCustomByRegularExpression           = 1 << 4,
    // 自定义需要的过滤字符串 CharacterSet
    TextLimitCustomByCharacterSet                = 1 << 5
};

@interface UITextField (mAdd)

// 默认长度  INT_MAX
@property (nonatomic, assign)   NSUInteger maxLength;
@property (nonatomic, assign)   NSUInteger currentTextLength;
@property (nonatomic, assign)   TextLimitOptions limitOptions;
@property (nonatomic, copy)     NSString *regularExpressionText;
@property (nonatomic, copy)     NSString *characterSetText;
@property (nonatomic, copy)     void (^observeTextChangedBlock) (NSString *text);


@end
