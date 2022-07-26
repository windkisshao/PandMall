//
//  NSString+URL.m
//  LiveWallpaper
//
//  Created by Sherlock on 2018/5/10.
//  Copyright © 2018年 陈浩. All rights reserved.
//

#import "NSString+URL.h"
#import <AVFoundation/AVFoundation.h>

@implementation NSString (URL)

- (NSString *)URLEncodedString
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
//    NSString *unencodedString = self;
//    NSString *encodedString = (NSString *)
//    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                              (CFStringRef)unencodedString,
//                                                              NULL,
//                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                                              kCFStringEncodingUTF8));
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet]];
}



/**
 *  URLDecode
 */
-(NSString *)URLDecodedString
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
//    NSString *encodedString = self;
//    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
//                                                                                                                     (__bridge CFStringRef)encodedString,
//                                                                                                                     CFSTR(""),
//                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return [self stringByRemovingPercentEncoding];
}

+ (NSString*)safeStr:(NSString*)str
{
    if ([str isEqual:@"NULL"] || [str isKindOfClass:[NSNull class]] || [str isEqual:[NSNull null]] || [str isEqual:NULL] || [[str class] isSubclassOfClass:[NSNull class]] || str == nil || str == NULL || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"])
    {
        return @"";
    }
    
    if(![str isKindOfClass:[NSString class]])
    {
        return [NSString stringWithFormat:@"%@",str];
    }
    
    return str;
}
@end
