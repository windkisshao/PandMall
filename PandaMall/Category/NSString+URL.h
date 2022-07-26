//
//  NSString+URL.h
//  LiveWallpaper
//
//  Created by Sherlock on 2018/5/10.
//  Copyright © 2018年 陈浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

/**
*  URLEncode
*/
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

+ (NSString*)safeStr:(NSString*)str;
@end
