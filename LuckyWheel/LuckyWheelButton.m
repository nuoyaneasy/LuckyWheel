//
//  LuckyWheelButton.m
//  LuckyWheel
//
//  Created by Yang Chao on 3/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "LuckyWheelButton.h"

@implementation LuckyWheelButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = 50;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width - imageW ) * 0.5;
    CGFloat imageY = 20;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)setHighlighted:(BOOL)highlighted {
    return;
}
@end
