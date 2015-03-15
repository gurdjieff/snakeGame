//
//  FacebookShareAssitant.m
//  Snake
//
//  Created by daiyuzhang on 14/03/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "FacebookShareAssitant.h"

@implementation FacebookShareAssitant

+ (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}


+(void)facebookShare
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Snake game", @"name",
                                   @"Snake is a classic mobile phone game which is both simple and playable. ", @"caption",
                                   @"By controlling the direction of the snakehead to eat eggs, it makes the snake become longer and at the same time obtains points.", @"description",
                                   @"https://itunes.apple.com/us/app/id966273001", @"link",
                                   @"https://is5-ssl.mzstatic.com/image/thumb/Purple6/v4/47/14/96/471496ab-f799-f39a-a7c0-80598daf8940/pr_source.jpg/500x500bb-80.png", @"picture",
                                   nil];
    
https://is5-ssl.mzstatic.com/image/thumb/Purple6/v4/47/14/96/471496ab-f799-f39a-a7c0-80598daf8940/pr_source.jpg/500x500bb-80.png
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                  if (error) {
                                                      ;
                                                  } else {
                                                      if (result == FBWebDialogResultDialogNotCompleted) {
                                                          // User cancelled.
                                                          NSLog(@"User cancelled.");
                                                      } else {
                                                          // Handle the publish feed callback
                                                          NSDictionary *urlParams = [FacebookShareAssitant parseURLParams:[resultURL query]];
                                                          
                                                          if (![urlParams valueForKey:@"post_id"]) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                              
                                                          } else {
                                                              // User clicked the Share button
                                                              NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                              NSLog(@"result %@", result);
                                                          }
                                                      }
                                                  }
                                              }];
    
    
}

@end
