//
//  CountDownTimer.m
//  CountDownTimer
//
//  Created by NetEase on 16/3/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "CountDownTimer.h"

@interface CountDownTimer()
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) TimerStatus timerStatus;
@end

@implementation CountDownTimer

- (void)pauseTimer
{
    if (self.timer != nil) {
        if(self.timerStatus != TimerStatusSuspend){
            dispatch_suspend(self.timer);
            self.timerStatus = TimerStatusSuspend;
        }
    }
}

- (void)resumeTimer
{
    if (self.timer != nil) {
        if(self.timerStatus != TimerStatusResume){
            dispatch_resume(self.timer);
            self.timerStatus = TimerStatusResume;
        }
    }
}

- (void)cancelTimer
{
    if (self.timer != nil) {
        if(self.timerStatus == TimerStatusResume){
            
            dispatch_source_cancel(self.timer);
        }
        else if (self.timerStatus == TimerStatusSuspend){
            dispatch_resume(_timer);
            dispatch_source_cancel(self.timer);
        }
        
        _timer = nil;
        self.timerStatus = TimerStatusCancel;
    }
}

- (void)setCountDownTime:(CGFloat)aTime
{
    __block CGFloat time = aTime;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(showCountDownTimer:)])
    {
        [self.delegate showCountDownTimer:time];
    }
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 0.5*NSEC_PER_SEC, 0); //每10秒触发timer，误差1秒
    
    dispatch_source_set_event_handler(_timer, ^{
        time -=0.5;
        double intTimer = floor(time);
        
        if (time == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(self.delegate && [self.delegate respondsToSelector:@selector(endCountDownTimer:)])
                {
                    [self.delegate endCountDownTimer:time];
                }
            });
        }
        else{
            if (intTimer >0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(self.delegate && [self.delegate respondsToSelector:@selector(showCountDownTimer:)])
                    {
                        [self.delegate showCountDownTimer:intTimer];
                    }
                });
            }
        }
    });
    
    self.timerStatus = TimerStatusSuspend;
    
    [self resumeTimer];
}
@end
