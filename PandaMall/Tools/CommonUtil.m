//
//  CommonUtil.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "CommonUtil.h"

@implementation CommonUtil

+ (void)doTaskAfter:(NSTimeInterval)delayTime withBlock:(dispatch_block_t)block
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

+ (void)doTaskInMainQueue:(dispatch_block_t)block
{
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

+(NSString *)convertArrayToJsonString:(NSArray *)array{
    if (array.count <= 0) return @"";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSArray *)convertJsonStringToArray:(NSString *)string
{
    if (string.length <= 0) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

+(NSString *)convertDictionaryToJsonString:(NSDictionary *)dic {
    if (dic.count <= 0) return @"";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)convertJsonStringToDictionary:(NSString *)string
{
    if (string.length <= 0) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;

    }
    return dic;

}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void)sortObjArrayWithKey:(NSString *)key array:(NSMutableArray *)arr ascending:(BOOL)ascending
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    [arr sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

+ (CGFloat)widthAdjustString:(NSString *)string font:(UIFont *)font
{
    CGSize strSize = [string sizeWithAttributes:@{NSFontAttributeName:font}];
    return strSize.width;
}

+ (CGFloat)heightAdjustWidth:(CGFloat)width font:(UIFont *)font forString:(NSString *)string
{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    NSStringDrawingOptions options = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading);
    CGSize actualsize =[string boundingRectWithSize:size options:options attributes:dic context:nil].size;
    return ceilf(actualsize.height);
}

@end
