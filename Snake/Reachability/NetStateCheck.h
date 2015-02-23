//
//  NetStateCheck.h
//  economicInfo
//
//  Created by gurdjieff on 12-12-4.
//
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetStateCheck : NSObject
{
    Reachability* mpHostReach;
}
@property (nonatomic, strong) Reachability * hostReach;
+(void)initNetState;
+(BOOL)checkNetWorkState;
+(NetStateCheck *)shareNetStateCheck;

@end
