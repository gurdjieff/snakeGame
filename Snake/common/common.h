//
//  common.h
//  Snake
//
//  Created by daiyuzhang on 23/01/2015.
//

#import <Foundation/Foundation.h>


#define screenHeight [[UIScreen mainScreen] bounds].size.height

@interface common : NSObject
@property NSInteger model;
@property (strong, nonatomic)NSString * host;
@property NSInteger port;
@property NSInteger level;
+(common *)shareCommon;

+ (NSString *)getIPAddress;
@end
