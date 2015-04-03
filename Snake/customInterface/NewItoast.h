//
//  NewItoast.h
//  Examination
//
//  Created by gurdjieff on 13-8-12.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewItoast : UIButton
{
    NSString * mpMessage;
    UILabel * mpLabel;
}
@property(nonatomic, retain) NSString * message;
+(void)showItoastWithMessage:(NSString *)message;
+(NewItoast *)sharedNewItoast;

@end
