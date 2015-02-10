//
//  NSString+CustomCategory.h
//  FinanceTrade
//
//  Created by gurdjieff on 13-4-2.
//

#import <Foundation/Foundation.h>

@interface NSString (CustomCategory)
+(NSString *)getAppPath;
-(BOOL)ifInvolveStr:(NSString *)str;
- (NSString *) stringFromMD5;
-(NSString *)hashCode;
-(NSString *)FormartTwoDecimals;

+(NSString *)getCurrentDateStr;

@end
