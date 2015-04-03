//
//  commonDataOperation.m
//  economicInfo
//
//  Created by daiyu zhang on 12-9-10.
//

#import "commonDataOperation.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "NSString+CustomCategory.h"
#import "iLoadAnimationView.h"
#import "JSON.h"
#import "sqliteDataManage.h"
#import "Common.h"
#define httpAddress @"http://172.20.10.3:9000/api/feedbacks"



@implementation commonDataOperation
@synthesize argumentDic = mpArgumentDic;
@synthesize isPOST;
@synthesize showAnimation;

-(id)init
{
    if ((self = [super init])) {
        mpArgumentDic = [[NSMutableDictionary alloc] init];
        isPOST = NO;
    }
    return self;
}

-(void)backToMainThread:(NSString *)dataString
{
    NSDictionary * dic = [dataString JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]]) {
    } else {
        return;
    }
    
    if ([downInfoDelegate respondsToSelector:@selector(requestFailed:withTag:)]) {
        [downInfoDelegate requestFailed:dataString withTag:miTag];
    }
    return;

    if ([downInfoDelegate respondsToSelector:@selector(downLoadWithInfo:with:)]) {
        [downInfoDelegate downLoadWithInfo:dataString with:miTag];
    }
}

-(void)requestFailBackToMainThread:(NSString *)dataString
{
    if ([downInfoDelegate respondsToSelector:@selector(requestFailed:withTag:)]) {
        [downInfoDelegate requestFailed:@"request failed" withTag:miTag];
    }
}

-(void)startTask
{
    NSString * lpMethod = @"GET";
    if (isPOST) {
        lpMethod = @"POST";
    }
    
    mpFormDataRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:httpAddress]];
    [mpFormDataRequest setRequestMethod:lpMethod];
    for (NSString * key in mpArgumentDic) {
        [mpFormDataRequest setPostValue:[mpArgumentDic objectForKey:key] forKey:key];
    }
    
    [mpFormDataRequest setTimeOutSeconds:15];
    [mpFormDataRequest startSynchronous];
    NSInteger liCode = [mpFormDataRequest responseStatusCode];
    
    NSMutableString * str = [[NSMutableString alloc] init];
//    [str appendFormat:@"%@?", serverIp];
    NSArray * ary = [mpArgumentDic allKeys];
    for (int i = 0; i < [ary count]; i++) {
        NSString * key = ary[i];
        NSString * value = mpArgumentDic[key];
        if (i == 0) {
            [str appendFormat:@"%@=%@", key, value];
        } else {
            [str appendFormat:@"&%@=%@", key, value];
        }
    }
//    NSLog(@"%@", str);
    [str release];
    
    if (liCode == 200) {
        NSString * lpInfo = [mpFormDataRequest responseString];
        [self performSelectorOnMainThread:@selector(backToMainThread:) withObject:lpInfo waitUntilDone:NO];
    } else {
        [self performSelectorOnMainThread:@selector(requestFailBackToMainThread:) withObject:nil waitUntilDone:NO];
    }
}

- (void) main
{
    [iLoadAnimationView startLoadAnimation];
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    [self startTask];
    [pool release];
    [iLoadAnimationView stopLoadAnimation];
}

-(void)dealloc
{
    [mpArgumentDic release], mpArgumentDic = nil;
    [super dealloc];
}




@end
