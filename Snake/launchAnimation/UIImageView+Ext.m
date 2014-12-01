//
//  UIImageView+Ext.m
//  launchAnimationAndVersionCheck
//
//  Created by gurd102 on 14-7-24.
//  Copyright (c) 2014年 gurd102. All rights reserved.
//

#import "UIImageView+Ext.h"

@implementation UIImageView (Ext)
-(void)setImageWithFileName:(NSString *)fileName
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    CGFloat width = frame.size.width;

    NSArray * fileAry = [fileName componentsSeparatedByString:@"."];
    if ([fileAry count] != 2) {
        NSLog(@"file name is wrong");
        return;
    }
    
    NSString * filePath = nil;
    if (width == 320) {
        filePath = [[NSBundle mainBundle] pathForResource:[fileAry objectAtIndex:0] ofType:[fileAry objectAtIndex:1]];
    } else {
        if ([fileAry[0] hasSuffix:@"@2x"]) {
            filePath = [[NSBundle mainBundle] pathForResource:[fileAry objectAtIndex:0] ofType:[fileAry objectAtIndex:1]];
 
        } else {
            filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/@2x", [fileAry objectAtIndex:0]] ofType:[fileAry objectAtIndex:1]];
        }
    }
    
    if (filePath == nil) {
        NSLog(@"file name is wrong");
        return;
    }
    
    UIImage * image = [[UIImage alloc] initWithContentsOfFile:filePath];
    self.image = image;
}

@end
