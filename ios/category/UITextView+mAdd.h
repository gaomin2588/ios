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
@property (nonatomic, readonly) UILabel *m_placeholderLabel;
@property (nonatomic, strong)   NSString *m_placeholder;
@property (nonatomic, strong)   NSAttributedString *m_attributedPlaceholder;
@property (nonatomic, strong)   UIColor *m_placeholderColor;

// 默认长度  INT_MAX
@property (nonatomic, assign)   NSUInteger m_maxLength;
@property (nonatomic, assign)   NSUInteger m_currentTextLength;
@property (nonatomic, assign)   TextFiltrationOptions m_filtrationOptions;
@property (nonatomic, copy)     NSString *m_regularExpressionText;
@property (nonatomic, copy)     NSString *m_characterSetText;
@property (nonatomic, copy)     void (^m_observeTextChangedBlock) (NSString *text);

@end
