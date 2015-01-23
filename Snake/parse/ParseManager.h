//
//  ParseManager.h
//  parseCheck
//
//  Created by daiyuzhang on 14-12-1.
//  Copyright (c) 2014年 gurd102. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface ParseManager : NSObject
+(ParseManager *)shareParseCheck;
-(void)storeToken:(NSString *)token;

@end
