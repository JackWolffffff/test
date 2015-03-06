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
#import <CommonCrypto/CommonCryptor.h>
#import "Base64Func.h"
#import "GTMBase64.h"

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
    
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString * username = @"15034079275";
    NSString * pwd = @"1234567890";
    NSString * regID = identifierForVendor; //设备ID
    NSString * appType = @"2"; //android 是1  ios 就是2
    NSString * bizType = @"1"; //买家版是1  卖家版是2
    //接口地址
    NSMutableString * result = [[NSMutableString alloc] initWithString:@"http://51baihong.eicp.net:8080/widget?type=member_login&ajax=yes&action=remotelogin&loginkey="];
    NSMutableString * loginkey = [[NSMutableString alloc] init];
    
    //对密码进行md5加密
    NSString * pwdMD5 = [self md5:pwd];
    //拼接loginkey
    loginkey = [[NSMutableString alloc] initWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\",\"regID\":\"%@\",\"appType\":\"%@\",\"bizType\":\"%@\"}", username, pwdMD5, regID, appType, bizType];
    
    NSLog(@"%@", loginkey);
#pragma 对loginkey进行base64加密
    NSData * data = [Base64Func dataWithBase64EncodedString:loginkey];

    NSString * loginkeyBase64 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [result appendString:loginkeyBase64];
    
    NSLog(@"passwordMD5:%@\n", pwdMD5);
    NSLog(@"loginkey:%@\n", loginkey);
    NSLog(@"loginkeyBase64: %@\n", loginkeyBase64);
    NSLog(@"result: %@", result);
    
    NSURL * url = [[NSURL alloc] initWithString:result];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString * jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"jsonData:%@\n", jsonData);
    }];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
