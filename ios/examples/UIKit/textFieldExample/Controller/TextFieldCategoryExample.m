//
//  TextFieldExample.m
//  ios
//
//  Created by 高敏 on 2018/6/6.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "TextFieldCategoryExample.h"
#import "UITextField+mAdd.h"

@interface TextFieldCategoryExample ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation TextFieldCategoryExample

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textField];
    
    self.textField.m_maxLength = 11;
    self.textField.m_limitOptions = TextLimitOnlyExistChineseOrLetterOrNumber;
    self.textField.m_observeTextChangedBlock = ^(NSString *text) {
        NSLog(@"%@", text);
    };
    
    
}



- (UITextField *)textField{
    if (_textField) return _textField;
    _textField = [[UITextField alloc] init];
    _textField.frame = CGRectMake(0, 100, kScreenWidth, 100);
    _textField.placeholder = @"placeholder";
    return _textField;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
