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

@property (weak, nonatomic) CYWheelView *wheelView;

@end

@implementation ViewController
- (IBAction)start:(id)sender {
    [self.wheelView startRotating];
}
- (IBAction)stop:(id)sender {
    [self.wheelView stopRotating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CYWheelView *wheelView = [CYWheelView wheelView];
    self.wheelView = wheelView;
    [self.view addSubview:wheelView];
    
}

@end
