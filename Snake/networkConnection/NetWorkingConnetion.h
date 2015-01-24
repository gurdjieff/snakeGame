//
//  NetWorkingConnetion.h
//  Snake
//
//  Created by daiyuzhang on 23/01/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkingConnetion : NSObject
+(NetWorkingConnetion *)shareNetWorkingConnnetion;
-(void)creatClientSocket;
-(void)creatServiceSocket;
-(void)sendInitalData;

@end
