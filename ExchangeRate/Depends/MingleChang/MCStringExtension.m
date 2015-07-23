//
//  NSString+MC.m
//  Category_OS
//
//  Created by admin001 on 14/11/26.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

#import "MCStringExtension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (MCExtension)


-(BOOL)isAllSpaceAndNewLine{
    NSAssert([self isKindOfClass:[NSString class]], @"Must be a NSString Class");
    if ([[self trimSpaceAndNewLine]isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

-(NSString *)trimSpaceAndNewLine{
    NSAssert([self isKindOfClass:[NSString class]], @"Must be a NSString Class");
    NSCharacterSet *lCharacterSet=[NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:lCharacterSet];
}

-(NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

-(NSString *)URLEncode{
    NSString *resultStr = self;
    
    CFStringRef originalString = (__bridge CFStringRef) self;
    CFStringRef leaveUnescaped = CFSTR(" ");
    CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[]");
    
    CFStringRef escapedStr;
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,originalString,leaveUnescaped,forceEscaped,kCFStringEncodingUTF8);
    
    if( escapedStr )
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
        CFRelease(escapedStr);
        
        // replace spaces with plusses
        [mutableStr replaceOccurrencesOfString:@" " withString:@"%20" options:0 range:NSMakeRange(0, [mutableStr length])];
        resultStr = [mutableStr copy];
    }
    return resultStr;
}

@end
