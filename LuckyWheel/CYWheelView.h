//
//  CYWheelView.h
//  LuckyWheel
//
//  Created by Yang Chao on 3/27/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYWheelView : UIView

+ (instancetype)wheelView;

- (void)startRotating;

- (void)stopRotating;

@end
