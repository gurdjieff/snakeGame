//
//  NetWorkingConnetion.h
//  Snake
//
//  Created by daiyuzhang on 23/01/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkConnection.h"
#import "AsyncUdpSocket.h"
#define PORT 8080

@interface NetWorkingConnetion : NSObject
{
    id<NetworkConnection>networkDelegate;
    AsyncUdpSocket * _serviceSocket;
    AsyncUdpSocket * _clientSocket;
}
@property(strong)AsyncUdpSocket * serviceSocket;
@property(strong)AsyncUdpSocket * clientSocket;

@property (strong) id<NetworkConnection>networkDelegate;
+(NetWorkingConnetion *)shareNetWorkingConnnetion;
-(void)creatClientSocket;
-(void)creatServiceSocket;
-(void)sendInitalData;

@end
