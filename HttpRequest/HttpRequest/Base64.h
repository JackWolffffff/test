//
//  Base64.h
//  HttpRequest
//
//  Created by rongjun on 15/3/9.
//  Copyright (c) 2015年 Migoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject
+(NSString *)encode:(NSData *)data;
+(NSData *)decode:(NSString *)data;
@end
