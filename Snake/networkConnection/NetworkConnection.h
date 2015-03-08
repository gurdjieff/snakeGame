//
//  NetworkConnection.h
//  Snake
//
//  Created by daiyuzhang on 08/03/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkConnection <NSObject>
-(void)receivedRespondFromBroadCast:(NSDictionary *)info;
@end
