//
//  NSDate+Ext.m
//  launchAnimationAndVersionCheck
//
//  Created by gurd102 on 14-7-24.
//  Copyright (c) 2014年 gurd102. All rights reserved.
//

#import "NSDate+Ext.h"

@implementation NSDate (Ext)
+(NSString *)getCurrentDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    return [formatter stringFromDate:[NSDate date]];
}

@end
