//
//  CYWheelView.m
//  LuckyWheel
//
//  Created by Yang Chao on 3/27/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "CYWheelView.h"

#define wheelElementCount 12
#define angle2radian(x) ((x) / 180.0 * M_PI)

@interface CYWheelView ()

@property (weak, nonatomic) IBOutlet UIImageView *luckyRotateWheel;
@property (weak, nonatomic) UIButton *selectedButton;

@end

@implementation CYWheelView

+ (instancetype)wheelView {
    return [[NSBundle mainBundle] loadNibNamed:@"CYWheelView" owner:nil options:nil][0];
}

#pragma mark - Overriden

- (void)awakeFromNib {
    [self setupButtonsInWheel];
}

#pragma mark - Private Methos

- (void)setupButtonsInWheel {
    
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    
    //CGImageRef和Image对于像素点以及Point的处理不一样，对于CGImageRef来说，都是像素，所有需要乘以2
    CGFloat smallImageWidth = bigImage.size.width / wheelElementCount * [UIScreen mainScreen].scale;
    CGFloat smallImageHeight = bigImage.size.height * [UIScreen mainScreen].scale;
    
    self.luckyRotateWheel.userInteractionEnabled = YES;
    
    NSUInteger count = wheelElementCount;
    for (int i = 0; i < count; i++) {
        //Create buttons
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //Set button positions
        btn.bounds = CGRectMake(0, 0, 68, 143);
        btn.layer.anchorPoint = CGPointMake(0.5, 1.0);
        btn.layer.position = [self convertPoint:self.center fromView:self.superview];
        
        //Set button background image
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        CGRect clippedRect = CGRectMake(i * smallImageWidth, 0, smallImageWidth, smallImageHeight);

        CGImageRef smallImageRef = CGImageCreateWithImageInRect(bigImage.CGImage, clippedRect);
        
        [btn setImage:[UIImage imageWithCGImage:smallImageRef] forState:UIControlStateNormal];
        
        //Listen button actions
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //Rotate button
        btn.layer.transform = CATransform3DMakeRotation(angle2radian((360 / wheelElementCount) * i), 0, 0, 1);
        
        //Add buttons
        [self.luckyRotateWheel addSubview:btn];
    }
}

- (void)btnClicked:(UIButton *)btn {
    self.selectedButton.selected = NO;
    self.selectedButton = btn;
    self.selectedButton.selected = YES;
}

@end
