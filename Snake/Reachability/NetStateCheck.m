//
//  NetStateCheck.m
//  economicInfo
//
//  Created by gurdjieff on 12-12-4.
//
//

#import "NetStateCheck.h"

static NetStateCheck * NetStateInstance = nil;
@implementation NetStateCheck
@synthesize hostReach = mpHostReach;

- (BOOL)updateInterfaceWithReachability
{
//    NetworkStatus lpNetstatus=[mpHostReach currentReachabilityStatus];
//    if(lpNetstatus == NotReachable) {
//        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"reminder", nil)
//                                                      message:NSLocalizedString(@"network is not working!", nil)
//                                                     delegate:self
//                                            cancelButtonTitle:nil
//                                            otherButtonTitles:NSLocalizedString(@"ok", nil), nil];
//        [alert show];
//        return NO;
//    }
    
    return YES;
}

- (void) netStateChanged: (NSNotification* )note
{
//	Reachability* curReach = [note object];
//	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability];
}

-(void)initNetStateCheck
{
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(netStateChanged:)
                                                 name: @"NetworkReachabilityChangedNotification"
                                               object: nil];
    mpHostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
	[mpHostReach startNotifier];
}

-(id)init
{
    if ((self = [super init])) {
        [self initNetStateCheck];
    }
    return self;
}

+(id)shareNetStateCheck
{
    if (NetStateInstance == nil) {
        NetStateInstance = [[NetStateCheck alloc] init];
    }
    return NetStateInstance;
}

+(void)initNetState
{
    [self shareNetStateCheck];
}

+(BOOL)checkNetWorkState
{
    return [[NetStateCheck shareNetStateCheck] updateInterfaceWithReachability];
}

-(void)dealloc
{
    
}

@end
