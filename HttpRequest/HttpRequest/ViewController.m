//
//  ViewController.m
//  HttpRequest
//
//  Created by rongjun on 15/3/5.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

#import "ViewController.h"
#import "Base64Func.h"
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()

@end

@implementation ViewController

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

- (void)viewDidLoad {
    NSString * username = @"15034079275";
    NSString * pwd = @"1234567890";
    NSString * regID = @"";
    NSString * appType = @"";
    NSString * bizType = @"";
    //接口地址
    NSMutableString * result = [[NSMutableString alloc] initWithString:@"http://www.51baihong.com/widget?type=member_login&ajax=yes&action=remotelogin&loginkey="];
    NSMutableString * loginkey = [[NSMutableString alloc] init];
#pragma 对密码进行md5加密
    NSString * pwdMD5 = [self md5:pwd];
    NSLog(@"%@", pwdMD5);
    
    loginkey = [[NSMutableString alloc] initWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\",\"regID\":\"%@\"},\"appType\":\"%@\"},\"bizType\":\"%@\"}", username, pwd, regID, appType, bizType];
#pragma 对loginkey进行base64加密
    
    //loginkey与result拼接之前要进行base64加密
    [result appendString:loginkey];
    //{\"username\":\""+name+"\",\"password\":\""+pword+"\",\"regID\":\""+regID+"\"}",\"appType\":\""+appType+"\"}",\"bizType\":\""+Constant.BIZ_TYPE+"\"}"
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
