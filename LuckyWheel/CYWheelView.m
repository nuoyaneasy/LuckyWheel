//
//  CYWheelView.m
//  LuckyWheel
//
//  Created by Yang Chao on 3/27/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "CYWheelView.h"
#import "LuckyWheelButton.h"

#define wheelElementCount 12
#define angle2radian(x) ((x) / 180.0 * M_PI)

@interface CYWheelView ()

@property (weak, nonatomic) IBOutlet UIImageView *luckyRotateWheel;
@property (weak, nonatomic) UIButton *selectedButton;
@property (strong, nonatomic) CADisplayLink *link;

@end

@implementation CYWheelView

+ (instancetype)wheelView {
    return [[NSBundle mainBundle] loadNibNamed:@"CYWheelView" owner:nil options:nil][0];
}

#pragma mark - Properties

- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

    }
    return _link;
}

#pragma mark - Overriden

- (void)awakeFromNib {
    [self setupButtonsInWheel];
}

#pragma mark - Private Methos

- (void)setupButtonsInWheel {
    
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *selectedImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    //CGImageRef和Image对于像素点以及Point的处理不一样，对于CGImageRef来说，都是像素，所有需要乘以2
    CGFloat smallImageWidth = bigImage.size.width / wheelElementCount * [UIScreen mainScreen].scale;
    CGFloat smallImageHeight = bigImage.size.height * [UIScreen mainScreen].scale;
    
    self.luckyRotateWheel.userInteractionEnabled = YES;
    
    NSUInteger count = wheelElementCount;
    for (int i = 0; i < count; i++) {
        //Create buttons
        LuckyWheelButton *btn = [LuckyWheelButton buttonWithType:UIButtonTypeCustom];
        
        //Set button positions
        btn.bounds = CGRectMake(0, 0, 68, 143);
        btn.layer.anchorPoint = CGPointMake(0.5, 1.0);
        btn.layer.position = [self convertPoint:self.center fromView:self.superview];
        
        //Set button background image
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        CGRect clippedRect = CGRectMake(i * smallImageWidth, 0, smallImageWidth, smallImageHeight);

        CGImageRef smallImageRef = CGImageCreateWithImageInRect(bigImage.CGImage, clippedRect);
        
        [btn setImage:[UIImage imageWithCGImage:smallImageRef] forState:UIControlStateNormal];
        
        //Set button selected image clipped from big image
        clippedRect = CGRectMake(i * smallImageWidth, 0, smallImageWidth, smallImageHeight);
        smallImageRef = CGImageCreateWithImageInRect(selectedImage.CGImage, clippedRect);
        [btn setImage:[UIImage imageWithCGImage:smallImageRef] forState:UIControlStateSelected];
        
        //Listen button actions
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
        
        //Rotate button
        btn.layer.transform = CATransform3DMakeRotation(angle2radian((360 / wheelElementCount) * i), 0, 0, 1);
        
        if (i == 0) {
            btn.selected = YES;
        }
        
        //Add buttons
        [self.luckyRotateWheel addSubview:btn];
    }
}

- (void)btnClicked:(UIButton *)btn {
    self.selectedButton.selected = NO;
    self.selectedButton = btn;
    self.selectedButton.selected = YES;
}

#pragma marl - Rotating
- (void)startRotating {
    [self.link setPaused:NO];
}

- (void)stopRotating {
    [self.link setPaused:YES];
}

- (void)update {
    self.luckyRotateWheel.transform = CGAffineTransformRotate(self.luckyRotateWheel.transform, angle2radian(45 / 60.0));
}
- (IBAction)start:(id)sender {
    self.luckyRotateWheel.userInteractionEnabled = NO;
    [self stopRotating];
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI * 2 * 3);
    anim.duration = 0.5;
    //anim.repeatCount = MAXFLOAT;
    anim.delegate = self;
    
    [self.luckyRotateWheel.layer addAnimation:anim forKey:nil];
}

#pragma mark - Delegates

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.luckyRotateWheel.userInteractionEnabled = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startRotating];
    });
}

- (void)animationDidStart:(CAAnimation *)anim {
    
}

@end
