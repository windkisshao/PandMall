//
//  UILabel+BM.m
//  BeeMusicPlayer
//
//  Created by Sherlock on 2017/3/2.
//  Copyright © 2017年 陈浩. All rights reserved.
//

#import "UILabel+BM.h"

@implementation UILabel (BM)

+ (instancetype)labelWithTitle:(NSString *)title textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment font:(UIFont *)font frame:(CGRect)frame {
    return ({
        UILabel *instance = [[UILabel alloc] initWithFrame:frame];
        instance.text = title;
        instance.textColor = color;
        instance.textAlignment = alignment;
        instance.font = font;
        instance;
    });
}

- (id)initWithTitle:(NSString *)title textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment fontOfSize:(CGFloat)size
{
    self = [super init];
    
    self.text = title;
    self.textColor = color;
    self.textAlignment = alignment;
    self.font = [UIFont systemFontOfSize:size];
    return self;
}


-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}


@end
