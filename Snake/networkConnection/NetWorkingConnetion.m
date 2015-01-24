//
//  NetWorkingConnetion.m
//  Snake
//
//  Created by daiyuzhang on 23/01/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "NetWorkingConnetion.h"
#import "AsyncUdpSocket.h"
#define serviceIP @"192.168.1.102"
#define PORT 8888
@interface NetWorkingConnetion ()
{
    AsyncUdpSocket * _serviceSocket;
    AsyncUdpSocket * _clientSocket;
    NSMutableArray * mpAry;
}

@end


@implementation NetWorkingConnetion
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
    _serviceSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    NSError * err = nil;
    [_serviceSocket enableBroadcast:YES error:&err];
    [_serviceSocket bindToPort:8888 error:&err];
    [_serviceSocket receiveWithTimeout:-1 tag:0];
}

-(void)creatClientSocket
{
    _clientSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    NSError * err = nil;
    [_clientSocket enableBroadcast:YES error:&err];
    [_clientSocket bindToPort:8888 error:&err];
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
    
    NSString * info = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([info isEqualToString:@"broadcast"]) {
        NSString * str = [UIDevice currentDevice].name;
        [_clientSocket sendData:[str dataUsingEncoding:NSUTF8StringEncoding] toHost:host port:PORT withTimeout:-1 tag:0];

    }
        [_serviceSocket receiveWithTimeout:-1 tag:0];


//    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"altert" message:info delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
//    [alertView show];
    return NO;
}



-(void)sendInitalData
{
    NSData * data = [@"broadcast" dataUsingEncoding:NSUTF8StringEncoding];
    [_clientSocket sendData:data toHost:@"255.255.255.255" port:PORT withTimeout:-1 tag:0];
//    [_clientSocket sendData:data toHost:@"192.168.1.31" port:PORT withTimeout:-1 tag:0];

    
}



@end
