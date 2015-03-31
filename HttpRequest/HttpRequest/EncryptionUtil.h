//
//  EncryptionUtil.h
//  HttpRequest
//
//  Created by rongjun on 15/3/10.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 加密工具
 */
/**
 *all set  GLOBAL_AUTH_KEY
 */
NSString * GLOBAL_AUTH_KEY = @"e317b362fafa0c96c20b8543d054b850";
@interface EncryptionUtil : NSObject

/**
 * 字符串加密以及解密函数
 *
 * @param string $string	原文或者密文
 * @param string $operation	操作(ENCODE | DECODE), 默认为 DECODE
 * @param string $key		密钥
 * @param int $expiry		密文有效期, 加密时候有效， 单位 秒，0 为永久有效
 * @return string		处理后的 原文或者 经过 base64_encode 处理后的密文
 *
 * @example
 *
 * 	$a = authcode('abc', 'ENCODE', 'key');
 * 	$b = authcode($a, 'DECODE', 'key');  // $b(abc)
 *
 * 	$a = authcode('abc', 'ENCODE', 'key', 3600);
 * 	$b = authcode('abc', 'DECODE', 'key'); // 在一个小时内，$b(abc)，否则 $b 为空
 */
- (NSString *) authcode:(NSString *) string
              operation:(NSString *) opration
                    key:(NSString *) key
                 expiry:(NSInteger *) expiry
                charset:(NSString * ) charset;

@end
