//
//  VersionUpdateAssistant.h
//  launchAnimationAndVersionCheck
//
//  Created by gurd102 on 14-7-24.
//  Copyright (c) 2014 gurd102. All rights reserved.
//

#import <Foundation/Foundation.h>


#define appNewestInfo @"http://itunes.apple.com/lookup?id=966273001"
#define appDownLoadUrl @"https://itunes.apple.com/us/app/snakegame-1.0/id966273001?l=zh&ls=1&mt=8"
@interface VersionUpdateAssistant : NSObject
+(void)updateAppVersionInfomation;
+(void)checkAppVersionInfomation;
@end
