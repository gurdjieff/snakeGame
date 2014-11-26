//
//  NSString+CustomCategory.h
//  FinanceTrade
//
//  Created by gurdjieff on 13-4-2.
//  Copyright (c) 2013年 cn.com.wxxr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CustomCategory)
+(NSString *)getAppPath;
-(BOOL)ifInvolveStr:(NSString *)str;
- (NSString *) stringFromMD5;
-(NSString *)hashCode;
-(NSString *)FormartTwoDecimals;


@end
