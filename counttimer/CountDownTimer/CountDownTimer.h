//
//  CountDownTimer.h
//  CountDownTimer
//
//  Created by NetEase on 16/3/16.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

@protocol CountDownTimerProtocol <NSObject>
@optional
- (void)showCountDownTimer:(CGFloat)aTime;
- (void)endCountDownTimer:(CGFloat)aTime;
@end

typedef NS_ENUM(NSUInteger,TimerStatus) {
    TimerStatusSuspend,
    TimerStatusResume,
    TimerStatusCancel
};

@interface CountDownTimer : NSObject

@property (nonatomic, assign) id<CountDownTimerProtocol>delegate;

- (void)pauseTimer;
- (void)resumeTimer;
- (void)cancelTimer;
- (void)setCountDownTime:(CGFloat)aTime;
@end
