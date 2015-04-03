//
//  commonDataOperation.h
//  economicInfo
//
//  Created by daiyu zhang on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "baseDataOperation.h"
#import "NSString+CustomCategory.h"


@interface commonDataOperation : baseDataOperation
{
    BOOL isPOST;
    BOOL showAnimation;
    NSMutableDictionary * mpArgumentDic;
}

@property (nonatomic, assign) NSMutableDictionary * argumentDic;
@property NSInteger tag;
@property BOOL isPOST;
@property BOOL showAnimation;

@end

