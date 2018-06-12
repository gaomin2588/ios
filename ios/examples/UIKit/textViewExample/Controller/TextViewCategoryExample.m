//
//  TextViewExample.m
//  ios
//
//  Created by 高敏 on 2018/6/5.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "TextViewCategoryExample.h"
#import "UITextView+mAdd.h"

@interface TextViewCategoryExample ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation TextViewCategoryExample

- (void)dealloc{
    NSLog(@"释放TextViewExample");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
    
    self.textView.m_placeholder = @"placeholder";
    self.textView.font = [UIFont systemFontOfSize:17];
    self.textView.m_filtrationOptions = TextFiltrationEmoji;
    self.textView.m_maxLength = 11;
    self.textView.m_observeTextChangedBlock = ^(NSString *text) {
        NSLog(@"observeTextChangedBlock -- %@", text);
    };
}

- (UITextView *)textView{
    if (_textView) return _textView;
//    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 100)];
    _textView = [[UITextView alloc] init];
    _textView.frame = CGRectMake(0, 100, kScreenWidth, 100);
    return _textView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.textView endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
