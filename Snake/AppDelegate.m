//
//  AppDelegate.m
//  Snake
//
//  Created by daiyuzhang on 14-11-12.
//
#import <FacebookSDK/FacebookSDK.h>

#import "AppDelegate.h"
#import "RootViewController.h"
#import "LaunchAnimationView.h"
#import "sqliteDataManage.h"
#import "ParseManager.h"
#import <Parse/Parse.h>
#import "AsyncSocket.h"
#import "AsyncUdpSocket.h"
#import "NetWorkingConnetion.h"
#import "ParseManager.h"
#import "common.h"
#import "NetStateCheck.h"
#import "customNavigationCtr.h"
#import "VersionUpdateAssistant.h"


@interface AppDelegate()
{
    AsyncUdpSocket * _serviceSocket;
    AsyncUdpSocket * _clientSocket;
    NSMutableArray * mpAry;
}

@end


@implementation AppDelegate
@synthesize nc;
-(void)crashTest
{
    NSArray * array = [[NSArray alloc] init];
    NSLog(@"%@",[array objectAtIndex:2]);
}

-(void)getIpAddress
{
    NSString * ipAddress = [common getIPAddress];
    NSLog(@"%@", ipAddress);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    RootViewController * rvc = [[RootViewController alloc] init];
    nc = [[UINavigationController alloc] initWithRootViewController:rvc];
    nc.navigationBar.hidden = YES;
    self.window.rootViewController = nc;
    [self initParse];
//    [[NSString alloc] init];
    
    [self registerPushNotification];
    [self.window makeKeyAndVisible];
    [sqliteDataManage sharedSqliteDataManage];
    
    [LaunchAnimationView addLaunchAnimationViewImages];
//    [self crashTest];
    [self getIpAddress];
    return YES;
}

-(void)sentCrashDataToParse
{
    sqliteDataManage * sqliteInstance = [sqliteDataManage sharedSqliteDataManage];
    NSString * selectSql = [NSString stringWithFormat:@"select * from crash_info"];
    NSMutableArray * ary = [[NSMutableArray alloc] init];
    sqlite3_stmt * statement = [sqliteInstance selectData:selectSql];
    while (sqlite3_step(statement) == SQLITE_ROW) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        
        NSString * dateStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
        NSString * content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
        [dic setObject:dateStr forKey:@"date"];
        [dic setObject:content forKey:@"content"];
        [ary addObject:dic];
    }
    sqlite3_finalize(statement);
    [sqliteInstance closeSqlite];

    for (int i = 0; i < [ary count]; i++) {
        PFObject *player = [PFObject objectWithClassName:@"Crash"];//1

        player[@"date"] = ary[i][@"date"];
        player[@"content"] = ary[i][@"content"];
    
    
        [player saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                if (i == [ary count]-1) {
                    NSString *sql = [NSString stringWithFormat:@"delete from crash_info"];
                    [[sqliteDataManage sharedSqliteDataManage] executeSql:sql];
                }
            } else {
            }
        }];
    }
}

-(void)sentScoresDataToParse
{
    sqliteDataManage * sqliteInstance = [sqliteDataManage sharedSqliteDataManage];
    NSString * selectSql = [NSString stringWithFormat:@"select * from score_info"];
    NSMutableArray * ary = [[NSMutableArray alloc] init];
    sqlite3_stmt * statement = [sqliteInstance selectData:selectSql];
    while (sqlite3_step(statement) == SQLITE_ROW) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        NSString * score = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
        NSString * level = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
        NSString * model = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];

        NSString * dateStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
        NSString * token = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
        NSString * name = [[UIDevice currentDevice] name];
        [dic setObject:score forKey:@"score"];
        [dic setObject:level forKey:@"level"];
        [dic setObject:model forKey:@"model"];
        [dic setObject:dateStr forKey:@"date"];
        [dic setObject:token forKey:@"token"];
        [dic setObject:name forKey:@"name"];
        [ary addObject:dic];
    }
    sqlite3_finalize(statement);
    [sqliteInstance closeSqlite];
    
    for (int i = 0; i < [ary count]; i++) {
        PFObject *player = [PFObject objectWithClassName:@"Scores"];//1
        NSString * score = ary[i][@"score"];
        player[@"score"] = [NSNumber numberWithInt:[score intValue]];
        player[@"level"] = ary[i][@"level"];
        player[@"model"] = ary[i][@"model"];
        player[@"date"] = ary[i][@"date"];
        player[@"token"] = ary[i][@"token"];
        player[@"name"] = ary[i][@"name"];

        
        [player saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                if (i == [ary count]-1) {
                    NSString *sql = [NSString stringWithFormat:@"delete from score_info"];
                    [[sqliteDataManage sharedSqliteDataManage] executeSql:sql];
                }
            } else {
            }
        }];
    }

}

-(void)initParse
{
    [Parse setApplicationId:@"ViGI2Dx85XfOeKeOyrUj4BtqZFdigXW6HY3gaH3q" clientKey:@"nc5hLGrfZwMtCrDtdfLZX7MqTzt7yBhn6Z81jb3k"];
}

-(void)registerPushNotification
{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];

    if (systemVersion >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken: %@", deviceToken);
    NSString* tmp = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    tmp = [tmp stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults * lpUserDefaults = [NSUserDefaults standardUserDefaults];
    if (![lpUserDefaults objectForKey:@"deviceToken"]) {
        [lpUserDefaults setObject:tmp forKey:@"deviceToken"];
    }
    
    ParseManager * instance = [ParseManager shareParseCheck];
    [instance storeToken:tmp];
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];

}

- (void)launchNotification:(NSNotification*)apNotification
{
}
   
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL urlWasHandled = [FBAppCall handleOpenURL:url
                                sourceApplication:sourceApplication
                                  fallbackHandler:^(FBAppCall *call) {
                                      NSLog(@"Unhandled deep link: %@", url);
                                      // Here goes the code to handle the links
                                      // Use the links to show a relevant view of your app to the user
                                  }];
    
    return urlWasHandled;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[NetWorkingConnetion shareNetWorkingConnnetion] creatServiceSocket];

    NetStateCheck * instance = [NetStateCheck shareNetStateCheck];
    NetworkStatus lpNetstatus=[instance.hostReach currentReachabilityStatus];
//    if(lpNetstatus == kReachableViaWiFi) {
        [self sentCrashDataToParse];
        [self sentScoresDataToParse];
//    }
    [VersionUpdateAssistant updateAppVersionInfomation];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
