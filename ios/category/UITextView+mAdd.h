//
//  UITextView+mAdd.h
//  ios-demo
//
//  Created by 高敏 on 2018/6/5.
//  Copyright © 2018年 losemo4. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, TextFiltrationOptions) {
    // 没有限制
    TextFiltrationNone                                = 1 << 0,
    // 过滤表情符号
    TextFiltrationEmoji                               = 1 << 1,
    // 过滤非法字符串
    TextFiltrationUnlawfulCharacter                   = 1 << 2,
    // 过滤非汉字、字母、数字字符
    TextFiltrationOnlyExistChineseOrLetterOrNumber    = 1 << 3,
    // 自定义需要的过滤字符串 RegularExpression
    TextFiltrationCustomByRegularExpression           = 1 << 4,
    // 自定义需要的过滤字符串 CharacterSet
    TextFiltrationCustomByCharacterSet                = 1 << 5
};



@interface UITextView (mAdd)

// placeholder
@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, strong)   NSString *placeholder;
@property (nonatomic, strong)   NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong)   UIColor *placeholderColor;

// 默认长度  INT_MAX
@property (nonatomic, assign)   NSUInteger maxLength;
@property (nonatomic, assign)   NSUInteger currentTextLength;
@property (nonatomic, assign)   TextFiltrationOptions filtrationOptions;
@property (nonatomic, copy)     NSString *regularExpressionText;
@property (nonatomic, copy)     NSString *characterSetText;
@property (nonatomic, copy)     void (^observeTextChangedBlock) (NSString *text);

@end
