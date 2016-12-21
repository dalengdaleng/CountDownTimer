//
//  ViewController.m
//  CountDownTimer
//
//  Created by NetEase on 16/3/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import "CountDownTimer.h"

@interface ViewController ()<CountDownTimerProtocol>
@property (weak, nonatomic) IBOutlet UIButton *countButton;
@property (nonatomic, strong) CountDownTimer *countDownTimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //倒计时调用
    _countDownTimer = [[CountDownTimer alloc]init];
    _countDownTimer.delegate = self;
    [_countDownTimer setCountDownTime:12.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)countButtonPressed:(id)sender {
}

#pragma mark countdown delegate
- (void)showCountDownTimer:(CGFloat)aTime
{
    self.countButton.hidden = NO;
    
    [self.countButton setTitle:[NSString stringWithFormat:@"%d",(int)aTime] forState:UIControlStateNormal];
    [self.countButton setTitle:[NSString stringWithFormat:@"%d",(int)aTime] forState:UIControlStateHighlighted];
}

- (void)endCountDownTimer:(CGFloat)aTime
{
    self.countButton.hidden = YES;
}
@end
