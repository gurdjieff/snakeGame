//
//  SearchViewController.m
//  Snake
//
//  Created by daiyuzhang on 22/01/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "SearchViewController.h"
#import "AsyncUdpSocket.h"
//#import <>
#define serviceIP @"192.168.1.102"
#define PORT 8888
@interface SearchViewController ()
{
    AsyncUdpSocket * _serviceSocket;
    AsyncUdpSocket * _clientSocket;
    NSMutableArray * mpAry;
}

@end

@implementation SearchViewController

-(void)creatClientSocket
{
    _clientSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    NSError * err = nil;
    [_clientSocket enableBroadcast:YES error:&err];
    [_clientSocket bindToPort:8888 error:&err];
}

-(NSString *)hostName {
    char baseHostName[256];
    long h = gethostid();
//    int success = gethostid()(baseHostName, 255);
//    if (success != 0) {
//        return nil;
//    }
//    baseHostName[255] = '/0';
    return nil;
}


-(void)creatServiceSocket
{
    [self hostName];
    _serviceSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    NSError * err = nil;
    [_serviceSocket enableBroadcast:YES error:&err];
    [_serviceSocket bindToPort:8888 error:&err];
    [_serviceSocket receiveWithTimeout:-1 tag:0];
    NSString * host =  _serviceSocket.localHost;
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
    [_serviceSocket receiveWithTimeout:-1 tag:0];
//    _serviceSocket.
//    NSLog(@"host----%@", sock.connectedHost);

    NSString * info = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"altert" message:info delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alertView show];
    return YES;
}



-(void)sendInitalData
{
    NSData * data = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];
//    [_clientSocket sendData:data toHost:serviceIP port:PORT withTimeout:-1 tag:999];
    
    [_clientSocket sendData:data toHost:@"255.255.255.255" port:PORT withTimeout:-1 tag:0];

}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self creatServiceSocket];
    [self creatClientSocket];
    [self performSelector:@selector(sendInitalData) withObject:nil afterDelay:3];
//    [self sendInitalData];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
