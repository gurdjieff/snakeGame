//
//  parseCheck.m
//  parseCheck
//
//  Created by gurd102 on 14-7-29.
//  Copyright (c) 2014年 gurd102. All rights reserved.
//

#import "parseCheck.h"
#import <Parse/Parse.h>
@implementation parseCheck

+(NSInteger)getCurrentDay
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * components = [cal components:NSYearCalendarUnit
                                     | NSMonthCalendarUnit
                                     | NSDayCalendarUnit
                                     | NSHourCalendarUnit
                                     | NSMinuteCalendarUnit
                                     | NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSInteger day = [components day];
    return day;
}

-(void)addObserver
{
       [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(parseCheck)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

-(void)initParse
{
    [Parse setApplicationId:@"ViGI2Dx85XfOeKeOyrUj4BtqZFdigXW6HY3gaH3q" clientKey:@"nc5hLGrfZwMtCrDtdfLZX7MqTzt7yBhn6Z81jb3k"];
}

-(void)setValue
{
    PFObject *player = [PFObject objectWithClassName:@"token"];//1
    [player setObject:@"9999999" forKey:@"token_id"];
    //    [player setObject:[NSNumber numberWithInt:1230] forKey:@"Score"];//2
    [player save];//3
}

-(void)parseCheck
{
    PFQuery *query = [PFQuery queryWithClassName:@"SafetyCheck"];
    [query whereKeyExists:@"checkKey"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        UIWindow * w = [UIApplication sharedApplication].keyWindow;
        if (!error) {
            if ([objects count] > 0) {
                NSString * value = [objects[0] objectForKey:@"checkKey"];
                if ([value hasSuffix:@"failed"]) {
                    w.userInteractionEnabled = NO;
                } else {
                    w.userInteractionEnabled = YES;
                }
            } else {
                w.userInteractionEnabled = YES;
            }
        }
        else
        {
            w.userInteractionEnabled = YES;
        }
    }];
}

-(id)init
{
    if ((self = [super init])) {
        [self initParse];
        [self addObserver];
    }
    return self;
}

+(parseCheck *)shareParseCheck
{
    static parseCheck * instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[parseCheck alloc] init];
    });
    return instance;
}

+(void)parseCheck
{
    [parseCheck shareParseCheck];
}

@end
