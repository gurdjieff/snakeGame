//
//  iLoadAnimationView.h
//  economicInfo
//
//  Created by daiyu zhang on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iLoadAnimationView : NSObject
{
    @public
    BOOL isLoadFinish;
    UIActivityIndicatorView * mpIndicatorView;
    UIView * mpBackGroundView;
     UILabel * mpLabel;
}
+(void)startLoadAnimation;
+(void)stopLoadAnimation;
//+(void)addSubViews;
+(id)sharedILoadAnimationView;



@end
