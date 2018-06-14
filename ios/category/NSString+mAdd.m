//
//  NSString+mAdd.m
//  ios
//
//  Created by 高敏 on 2018/6/14.
//  Copyright © 2018年 losermo4. All rights reserved.
//

#import "NSString+mAdd.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (mAdd)

- (NSString *)m_md5{
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    return output;
}

@end
