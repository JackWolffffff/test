//
//  EncryptionUtil.m
//  HttpRequest
//
//  Created by rongjun on 15/3/10.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

#import "EncryptionUtil.h"

#import <CommonCrypto/CommonDigest.h>

@implementation EncryptionUtil

//md5加密方法
- (NSString *) md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *) authcode:(NSString *) string
              operation:(NSString *) operation
                    key:(NSString *) key
                 expiry:(NSInteger *) expiry
                charset:(NSString *)charset
{
    if(string != nil)
    {
        if ([operation isEqualToString:@"DECODE"])
        {
            string = [string stringByReplacingOccurrencesOfString:@"\\.0\\."
                                                       withString:@" "];
            string = [string stringByReplacingOccurrencesOfString:@"\\.1\\."
                                                       withString:@"="];
            string = [string stringByReplacingOccurrencesOfString:@"\\.2\\."
                                                       withString:@"+"];
            string = [string stringByReplacingOccurrencesOfString:@"\\.3\\."
                                                       withString:@"/"];
        }
    }
    //note 加入随机密钥，可以令密文无任何规律，即便是原文和密钥完全相同，加密结果也会每次不同，增大破解难度。
    //note 取值越大，密文变动规律越大，密文变化 = 16 的 $ckey_length 次方
    //note 当此值为 0 时，则不产生随机密钥
    NSInteger ckey_length = 4; //note 随机密钥长度 取值 0-32;
    
    //如果$key不为空 则对$key进行md5加密 如果为空则对 GLOBAL_AUTH_KEY 进行md5加密并赋值给$key
    if (key != nil)
    {
        key = [self md5:key];
    }
    //把$key从0到16位截断并把阶段后的字符串进行md5加密
    NSString *keya = [self md5:[key substringWithRange: NSMakeRange(0, 16)]];
    NSString *keyb = [self md5:[key substringWithRange: NSMakeRange(16, 16)]];
    NSString *keyc = [[NSString alloc] init];
    if (ckey_length > 0)
    {
        if ([operation isEqualToString:@"DECODE"])
        {
            keyc = [string substringWithRange:NSMakeRange(o, ckey_length)];
        }
        else
        {
            keyc = []
        }
    }
    
}

@end
