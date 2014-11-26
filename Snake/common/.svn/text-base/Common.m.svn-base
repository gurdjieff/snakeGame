//
//  Common.m
//  Examination
//
//  Created by gurd on 13-7-15.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "Common.h"
#import "AppDelegate.h"
#import "SFHFKeychainUtils.h"

@implementation Common
+(NSString *)getDeviceIdentifer
{    
    NSString *idenfifer =  [SFHFKeychainUtils getPasswordForUsername:@"device"andServiceName:@"examination" error:nil];
    if (idenfifer == nil) {
        idenfifer = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        [SFHFKeychainUtils storeUsername:@"device" andPassword:idenfifer forServiceName:@"examination" updateExisting:NO error:nil];
    }
    return idenfifer;
}

+(NSOperationQueue *)getOperationQueue
{
    AppDelegate * lpDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return lpDelegate.operationQueue;
}



@end
