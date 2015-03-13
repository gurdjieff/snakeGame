//
//  SecondControllerViewController.h
//  Snake
//
//  Created by daiyuzhang on 14-12-2.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <FacebookSDK/FacebookSDK.h>
typedef enum {
    RPSCallNone = -1, RPSCallRock = 0, RPSCallPaper = 1, RPSCallScissors = 2 // enum is also used to index arrays
} RPSCall;
@interface SecondControllerViewController : BaseViewController
@end
