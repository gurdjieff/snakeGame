//
//  NSString+Ext.m
//  launchAnimationAndVersionCheck
//
//  Created by gurd102 on 14-7-24.
//  Copyright (c) 2014年 gurd102. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)
-(BOOL)isContainStr:(NSString *)str
{
    return [self rangeOfString:str options:NSCaseInsensitiveSearch].length > 0;
}

@end
