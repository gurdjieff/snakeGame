//
//  ParseManager.h
//  parseCheck
//
//  Created by daiyuzhang on 14-12-1.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface ParseManager : NSObject
+(ParseManager *)shareParseCheck;
-(void)storeToken:(NSString *)token;

@end
