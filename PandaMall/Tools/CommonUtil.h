//
//  CommonUtil.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonUtil : NSObject

//延时任务
+ (void)doTaskAfter:(NSTimeInterval)delayTime withBlock:(dispatch_block_t)block;

//主线程
+ (void)doTaskInMainQueue:(dispatch_block_t)block;

+(NSString *)convertArrayToJsonString:(NSArray*)array;

+(NSArray*) convertJsonStringToArray:(NSString*) string;

+(NSString *)convertDictionaryToJsonString:(NSDictionary *)dic;

+ (NSDictionary *)convertJsonStringToDictionary:(NSString *)string;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (void)sortObjArrayWithKey:(NSString *)key array:(NSMutableArray *)arr ascending:(BOOL)ascending;

//单行文字内容宽度
+ (CGFloat)widthAdjustString:(NSString *)string font:(UIFont *)font;

//文字内容根据宽度自适应高度
+ (CGFloat)heightAdjustWidth:(CGFloat)width font:(UIFont *)font forString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
