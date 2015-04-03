//
//  iLoadAnimationView.m
//  economicInfo
//
//  Created by daiyu zhang on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "iLoadAnimationView.h"
#import <QuartzCore/QuartzCore.h>
static iLoadAnimationView * iLoadAnimationViewInstance = nil;
@interface iLoadAnimationView(privateMethod)
-(void)addActivityIndecatorView;
@end

@implementation iLoadAnimationView

-(id)init
{
    if ((self = [super init])) {
        [self addSubViews];
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

//+(void)addSubViews
//{
//    [[iLoadAnimationView sharedILoadAnimationView] addSubViews];
//}

-(void)addSubViews
{
    UIWindow *lpWindow = [UIApplication sharedApplication].keyWindow;
    mpBackGroundView = [[UIView alloc] initWithFrame:CGRectMake(70, 160, 180, 100)];
    mpBackGroundView.backgroundColor = [UIColor blackColor];
    mpBackGroundView.alpha = 0.8;
    mpBackGroundView.layer.cornerRadius = 10;
    
    UILabel * lpble = [[UILabel alloc] initWithFrame:CGRectMake(30, 36, 140, 30)];
    lpble.textColor = [UIColor whiteColor];
    lpble.backgroundColor = [UIColor clearColor];
    lpble.textAlignment = NSTextAlignmentCenter;
    lpble.font = [UIFont systemFontOfSize:14];
    lpble.text = @"正在加载";
    [mpBackGroundView addSubview:lpble];
    [lpble release];
    
    
    mpIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(40, 40, 20, 20)];
    mpIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [mpBackGroundView addSubview:mpIndicatorView];
    [mpIndicatorView release];
    [lpWindow addSubview:mpBackGroundView];
    [mpBackGroundView release];
    mpBackGroundView.alpha = 0.0;
    isLoadFinish = YES;
}


-(void)__stopActivityIndecatorView
{
    if ([mpIndicatorView isAnimating] && mpBackGroundView.alpha == 1.0) {
        [UIView animateWithDuration:1.0 animations:^{
            mpBackGroundView.alpha = 0.0;
        } completion:^(BOOL finished){
            [mpIndicatorView stopAnimating];
        }];
    }
}


-(void)__startActivityIndecatorView
{
    if (![mpIndicatorView isAnimating] && mpBackGroundView.alpha == 0.0) {
        [UIView animateWithDuration:1.0 animations:^{
            mpBackGroundView.alpha = 1.0;
            [mpIndicatorView startAnimating];
        }];

        [self performSelector:@selector(__stopActivityIndecatorView) withObject:nil afterDelay:30.0];
    }
}

-(void)stopActivityIndecatorView
{
    [self performSelectorOnMainThread:@selector(__stopActivityIndecatorView) withObject:nil waitUntilDone:YES];
}


-(void)startActivityIndecatorView
{
    [self performSelectorOnMainThread:@selector(__startActivityIndecatorView) withObject:nil waitUntilDone:YES];
}



+(id)sharedILoadAnimationView
{
    
    if (!iLoadAnimationViewInstance) {
        iLoadAnimationViewInstance = [[iLoadAnimationView alloc] init];
    }
    
    return iLoadAnimationViewInstance;
}

+(void)stopLoadAnimation
{
    [[iLoadAnimationView sharedILoadAnimationView] stopActivityIndecatorView];
}

+(void)startLoadAnimation
{
    [[iLoadAnimationView sharedILoadAnimationView] startActivityIndecatorView];
}


@end


