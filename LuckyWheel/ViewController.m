//
//  ViewController.m
//  LuckyWheel
//
//  Created by Yang Chao on 3/27/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "ViewController.h"
#import "CYWheelView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CYWheelView *wheelView = [CYWheelView wheelView];
    [self.view addSubview:wheelView];
    
}

@end
