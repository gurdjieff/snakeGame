//
//  NetWorkingConnetion.m
//  Snake
//
//  Created by daiyuzhang on 23/01/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "NetWorkingConnetion.h"
#import "common.h"
#import "AppDelegate.h"
#import "LevelViewController.h"
#import "SecondControllerViewController.h"
@interface NetWorkingConnetion ()
{
    NSMutableArray * mpAry;
    NSString * invitationHost;
}

@end


@implementation NetWorkingConnetion
@synthesize networkDelegate;
@synthesize clientSocket = _clientSocket;
@synthesize serviceSocket = _serviceSocket;
+(NetWorkingConnetion *)shareNetWorkingConnnetion
{
    static NetWorkingConnetion *instance = nil;
    if (instance == nil) {
        instance = [[NetWorkingConnetion alloc] init];
    }
    return instance;
}

-(void)creatServiceSocket
{
    NSError * err = nil;
    _serviceSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [_serviceSocket enableBroadcast:YES error:&err];
    [_serviceSocket bindToPort:8080 error:&err];
    [_serviceSocket receiveWithTimeout:-1 tag:0];
}

-(void)creatClientSocket
{
    _clientSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    NSError * err = nil;
    [_clientSocket enableBroadcast:YES error:&err];
    [_clientSocket bindToPort:8080 error:&err];
}


- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
    
}


- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    
}

-(void)onUdpSocketDidClose:(AsyncUdpSocket *)sock
{
    
}


- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    NSError * error = nil;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"%@", dic);
    NSString * newHost = [NSString stringWithString:host];
    if ([newHost hasPrefix:@"::ffff"]) {
        newHost = [newHost substringFromIndex:7];
    }
    
    if ([dic[@"type"] isEqualToString:@"search"]
        && ![host isEqualToString:[common getIPAddress]]
        && ![host isEqualToString:@"192.168.1.101"]) {
        NSString * str = [UIDevice currentDevice].name;
        NSMutableDictionary * dicInfo = [[NSMutableDictionary alloc] init];
        [dicInfo setObject:@"searchRespon" forKey:@"type"];
        [dicInfo setObject:str forKey:@"name"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dicInfo options:NSJSONWritingPrettyPrinted error:&error];
        [_clientSocket sendData:jsonData toHost:newHost port:PORT withTimeout:-1 tag:0];
    } else if ([dic[@"type"] isEqualToString:@"searchRespon"]) {
        NSMutableDictionary * dicInfo = [[NSMutableDictionary alloc] init];
        [dicInfo setObject:@"searchRespon" forKey:@"type"];
        [dicInfo setObject:host forKey:@"host"];
        [dicInfo setObject:[NSNumber numberWithInt:port] forKey:@"port"];
        [dicInfo setObject:dic[@"name"] forKey:@"name"];
        [networkDelegate receivedRespondFromBroadCast:dicInfo];
    } else if ([dic[@"type"] isEqualToString:@"invitation"]) {
        invitationHost = newHost;
        NSString * message = [NSString stringWithFormat:@"%@ invite you to play together", dic[@"name"]];
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"no",@"yes", nil];
        [alertView show];

    } else if ([dic[@"type"] isEqualToString:@"invitationRespon"]) {
        invitationHost = newHost;
        AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.nc popToRootViewControllerAnimated:NO];
        [common shareCommon].model = 1;
        [common shareCommon].level = 2;
        SecondControllerViewController * sc = [[SecondControllerViewController alloc] init];
        [appDelegate.nc pushViewController:sc animated:YES];
        [common shareCommon].host = newHost;
    }
    [_serviceSocket receiveWithTimeout:-1 tag:0];
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSError * error = nil;
        NSString * str = [UIDevice currentDevice].name;
        NSMutableDictionary * dicInfo = [[NSMutableDictionary alloc] init];
        [dicInfo setObject:@"invitationRespon" forKey:@"type"];
        [dicInfo setObject:str forKey:@"name"];
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dicInfo options:NSJSONWritingPrettyPrinted error:&error];
        [_clientSocket sendData:jsonData toHost:invitationHost port:PORT withTimeout:-1 tag:0];
        [common shareCommon].host = invitationHost;
        AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate.nc popToRootViewControllerAnimated:NO];
        [common shareCommon].model = 1;
        [common shareCommon].level = 2;
        SecondControllerViewController * sc = [[SecondControllerViewController alloc] init];
        [appDelegate.nc pushViewController:sc animated:YES];

    }
}

-(void)startGame
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"choose model" delegate:self cancelButtonTitle:nil otherButtonTitles:@"gravity",@"sweep", nil];
    
    [alertView show];
}

-(void)__sendInitalData
{
    NSMutableDictionary * dicInfo = [[NSMutableDictionary alloc] init];
    [dicInfo setObject:@"search" forKey:@"type"];
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dicInfo options:NSJSONWritingPrettyPrinted error:&error];
    [_clientSocket sendData:jsonData toHost:@"192.168.1.101" port:PORT withTimeout:1 tag:0];
    [_clientSocket sendData:jsonData toHost:@"255.255.255.255" port:PORT withTimeout:1 tag:0];
}
-(void)sendInitalData
{
    [self __sendInitalData];
//    [NSThread detachNewThreadSelector:@selector(__sendInitalData) toTarget:self withObject:nil];
}


@end
