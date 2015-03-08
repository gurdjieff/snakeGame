//
//  customNavigationCtr.m
//  Snake
//
//  Created by daiyuzhang on 08/03/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "customNavigationCtr.h"

@implementation customNavigationCtr
+(customNavigationCtr *)shareCustomNavigationCtr
{
    static customNavigationCtr * instance =  nil;
    if (instance == nil) {
        instance = [[customNavigationCtr alloc] init];
    }
    return instance;
}

@end
