//
//  NSDate+Addition.m
//  Vbill
//
//  Created by gurd102 on 14-4-1.
//  Copyright (c) 2014年 daiyuzhang. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)
-(NSString *)getCurrentDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddhhmmss"];
    return [formatter stringFromDate:self];
}

-(NSString *)getCurrentDateTwo
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    return [formatter stringFromDate:self];
}

-(NSString *)getCurrentMonthFirtsDate
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * components = [cal components:NSYearCalendarUnit
                                     | NSMonthCalendarUnit
                                     | NSDayCalendarUnit
                                     | NSHourCalendarUnit
                                     | NSMinuteCalendarUnit
                                     | NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSInteger year = [components year];
    NSInteger month = [components month];
    return [NSString stringWithFormat:@"%ld%02ld01000000", (long)year, (long)month];
}

@end
