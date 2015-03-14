//
//  main.m
//  Snake
//
//  Created by daiyuzhang on 14-11-12.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "sqliteDataManage.h"
#import "NSString+CustomCategory.h"

void DefaultUncaughtExceptionHandler(NSException *exception);
void DefaultUncaughtExceptionHandler(NSException *exception)
{
    NSArray* lpCallStackSymbols = [exception callStackSymbols];
    NSString* lpReason = [exception reason];
    NSString* lpName = [exception name];
    NSString *crashInfo = [NSString stringWithFormat:@"=============Crash Report=============\n"
                           "Version: %@\n\n"
                           "Application Specific Information: %@\n"
                           "Reason: %@\n\n"
                           "callStackSymbols:\n---------------------------------\n%@"
                           , [NSString stringWithFormat:@""]
                           , lpName
                           , lpReason
                           , [lpCallStackSymbols componentsJoinedByString:@"\n"]];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO crash_info (date,content) VALUES ('%@', '%@')", [NSString getCurrentDateStr], crashInfo];
    [[sqliteDataManage sharedSqliteDataManage] executeSql:sql];
}


int main(int argc, char * argv[])
{
    @autoreleasepool {
	  NSSetUncaughtExceptionHandler(DefaultUncaughtExceptionHandler);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


