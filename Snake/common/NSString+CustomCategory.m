//
//  NSString+CustomCategory.m
//  FinanceTrade
//
//  Created by gurdjieff on 13-4-2.
//  Copyright (c) 2013年 cn.com.wxxr. All rights reserved.
//

#import "NSString+CustomCategory.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (CustomCategory)

-(NSString *)FormartTwoDecimals
{
    double value = [self doubleValue];
    if (value == 0) {
        return @"0";
    }
    return [NSString stringWithFormat:@"%.2lf",value];
}

+(NSString *)getAppPath
{
    NSArray * documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [documentPaths objectAtIndex:0];
}

-(BOOL)ifInvolveStr:(NSString *)str
{
    return [self rangeOfString:str options:NSCaseInsensitiveSearch].length > 0;
}

- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return [outputString autorelease];
}

-(NSString *)hashCode
{
    NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding];
    CC_SHA1_CTX ctx;
    uint8_t * hashBytes = NULL;
    NSData * hash = nil;
    
    hashBytes = malloc( CC_SHA1_DIGEST_LENGTH * sizeof(uint8_t) );
    memset((void *)hashBytes, 0x0, CC_SHA1_DIGEST_LENGTH);
    
    CC_SHA1_Init(&ctx);
    CC_SHA1_Update(&ctx, (void *)[data bytes], (CC_LONG)[data length]);
    CC_SHA1_Final(hashBytes, &ctx);
    hash = [NSData dataWithBytes:(const void *)hashBytes length:(NSUInteger)CC_SHA1_DIGEST_LENGTH];
    
    if (hashBytes)
        free(hashBytes);
    NSString* tmp = [[hash description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	tmp = [tmp stringByReplacingOccurrencesOfString:@" " withString:@""];
    return tmp;
}




@end
