//
//  UITextField+mAdd.m
//  ios
//
//  Created by 高敏 on 2018/6/6.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "UITextField+mAdd.h"
#import <objc/runtime.h>



void textField_swizzleMethod(Class originalCls, SEL originalSelector, Class swizzledCls, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(originalCls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledCls, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(originalCls,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(originalCls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static const char *kMaxLenth                   = "kMaxLenth";
static const char *kLimitOptios                = "kLimitOptios";
static const char *kRegularExpressionText      = "kRegularExpressionText";
static const char *kCharacterSetText           = "kCharacterSetText";
static const char *kObserveTextChangedBlock    = "kObserveTextChangedBlock";


@implementation UITextField (mAdd)

@dynamic m_maxLength;
@dynamic m_limitOptions;
@dynamic m_regularExpressionText;
@dynamic m_characterSetText;
@dynamic m_currentTextLength;
@dynamic m_observeTextChangedBlock;

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textField_swizzleMethod([self class], NSSelectorFromString(@"delloc"), [self class], @selector(m_delloc));
        textField_swizzleMethod([self class], @selector(initWithFrame:), [self class], @selector(m_initWithFrame:));
        textField_swizzleMethod([self class], @selector(initWithCoder:), [self class], @selector(m_initWithCoder:));
    });
}
- (instancetype)m_initWithFrame:(CGRect)frame{
    
    [self addTextChangedObserve];
    return [self m_initWithFrame:frame];
}

- (instancetype)m_initWithCoder:(NSCoder *)aDecoder{
    [self addTextChangedObserve];
    return [self m_initWithCoder:aDecoder];
}

- (void)addTextChangedObserve{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTextWithOptions)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
}
- (void)m_delloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self m_delloc];
}

- (void)updateTextWithOptions{
    
    
    
    NSString *text = nil;
    if (self.m_limitOptions & TextLimitNone){
        // 不做任何操作
        text = self.text;
    }
    
    // 过滤表情
    if (self.m_limitOptions & TextLimitEmoji){
        NSString *orgionText = self.text;
        text = [self orgionStr:orgionText withRegex:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"];
    }
    
    if (self.m_limitOptions & TextLimitUnlawfulCharacter) {
        NSString *orgionText = self.text;
        text = [self orgionStr:orgionText withCharacterSetStr:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    }
    
    // 过滤字符串中的非汉字、字母、数字
    if (self.m_limitOptions & TextLimitOnlyExistChineseOrLetterOrNumber) {
        NSString *orgionText = self.text;
        text = [self orgionStr:orgionText withRegex:@"[^a-zA-Z0-9\u4e00-\u9fa5]"];
    }
    
    // 自定义 RegularExpression过滤
    if (self.m_limitOptions & TextLimitCustomByRegularExpression) {
        if (self.m_regularExpressionText && self.m_regularExpressionText.length > 0) {
            NSString *orgionText = self.text;
            text = [self orgionStr:orgionText withRegex:self.m_regularExpressionText];
        }else{
            text = self.text;
        }
    }
    
    // 自定义 CharacterSet过滤
    if (self.m_limitOptions & TextLimitCustomByCharacterSet) {
        if (self.m_characterSetText && self.m_characterSetText.length > 0) {
            NSString *orgionText = self.text;
            text = [self orgionStr:orgionText withCharacterSetStr:self.m_characterSetText];
        }else{
            text = self.text;
        }
    }
    
    
    
    [self limitText:text];
}

// CharacterSet
- (NSString *)orgionStr:(NSString *)orgionStr withCharacterSetStr:(NSString *)characterSetStr{
    NSMutableString *mutStr = [NSMutableString stringWithString:orgionStr];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:characterSetStr];
    NSString * hmutStr = [[mutStr componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    return hmutStr;
}


// RegularExpression
- (NSString *)orgionStr:(NSString *)orgionStr withRegex:(NSString *)regexStr{
    NSString *filterText = orgionStr;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:filterText options:NSMatchingReportCompletion range:NSMakeRange(0, filterText.length) withTemplate:@""];
    return result;
}


- (void)limitText:(NSString *)text{
    
    UITextRange *selectedRange = self.markedTextRange;
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return;
    }
    
    if ([text isEqualToString:self.text]) {
        
        if (text.length > self.m_maxLength) {
            self.text = [text substringToIndex:self.m_maxLength];
        }
        
    }else{
        
        if (text.length > self.m_maxLength) {
            self.text = [text substringToIndex:self.m_maxLength];
        }else{
            self.text = text;
        }
    }
    
    if (self.m_observeTextChangedBlock) {
        self.m_observeTextChangedBlock(self.text);
    }
    
    
}

- (void)setM_maxLength:(NSUInteger)maxLength{
    objc_setAssociatedObject(self, kMaxLenth, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
}

- (NSUInteger)m_maxLength{
    NSUInteger max = [objc_getAssociatedObject(self, kMaxLenth) integerValue];
    if (max) return max;
    max = INT_MAX;
    return max;
}


- (void)setM_limitOptions:(TextLimitOptions)limitOptions{
    objc_setAssociatedObject(self, kLimitOptios, @(limitOptions), OBJC_ASSOCIATION_ASSIGN);

}

- (TextLimitOptions)m_limitOptions{
    TextLimitOptions option = [objc_getAssociatedObject(self, kLimitOptios) integerValue];
    if (option)  return option;
    option = TextLimitNone;
    return option;

}


- (NSUInteger)m_currentTextLength{
    return self.text.length;
}

- (void)setM_regularExpressionText:(NSString *)regularExpressionText{
    objc_setAssociatedObject(self, kRegularExpressionText, regularExpressionText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)m_regularExpressionText{
    NSString *retext = objc_getAssociatedObject(self, kRegularExpressionText);
    if (retext) return retext;
    retext = @"";
    return retext;
}

- (void)setM_characterSetText:(NSString *)characterSetText{
    objc_setAssociatedObject(self, kCharacterSetText, characterSetText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)m_characterSetText{
    NSString *cstext = objc_getAssociatedObject(self, kCharacterSetText);
    if (cstext) return cstext;
    cstext = @"";
    return cstext;
}

- (void)setM_observeTextChangedBlock:(void (^)(NSString *))observeTextChangedBlock{
    objc_setAssociatedObject(self, kObserveTextChangedBlock, observeTextChangedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))m_observeTextChangedBlock{
    return objc_getAssociatedObject(self, kObserveTextChangedBlock);
}



@end
