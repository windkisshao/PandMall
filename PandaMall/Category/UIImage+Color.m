//
//  UIImage+Color.h
//  Glucometer
//
//  Created by yuwell on 2019/8/20.
//  Copyright © 2019 zhaofen. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)
//将颜色转换为图片
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

@end
