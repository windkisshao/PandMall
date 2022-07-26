//
//  UILabel+BM.h
//  BeeMusicPlayer
//
//  Created by Sherlock on 2017/3/2.
//  Copyright © 2017年 陈浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BM)

+ (instancetype)labelWithTitle:(NSString *)title textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment font:(UIFont *)font frame:(CGRect)frame;

- (id)initWithTitle:(NSString *)title textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment fontOfSize:(CGFloat)size;

-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end
