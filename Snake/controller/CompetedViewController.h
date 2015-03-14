//
//  CompetedViewController.h
//  Snake
//
//  Created by daiyuzhang on 14/03/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "common.h"
#import "NetWorkingConnetion.h"
typedef enum {
    RPSCallNone = -1, RPSCallRock = 0, RPSCallPaper = 1, RPSCallScissors = 2 // enum is also used to index arrays
} RPSCall;
@interface CompetedViewController : BaseViewController
@end
