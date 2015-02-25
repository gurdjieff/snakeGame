//
//  InstructionViewController.m
//  Snake
//
//  Created by daiyuzhang on 03/02/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "InstructionViewController.h"

@interface InstructionViewController ()

@end

@implementation InstructionViewController
-(void)addTextView
{
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 44+20+50, 300, screenHeight-44-20)];
    textView.editable = NO;
    textView.font = [UIFont boldSystemFontOfSize:20];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor colorWithRed:255/255.0 green:166/255.0 blue:50/255.0 alpha:1.0];
    

    textView.text = @"In the game, the player controls a snake through sweeping screen or gravity, which continuously grows longer. The snake is not allowed to touch boundary or bite its own tail. The current stage will be finished when a certain score is reached and the player continues to the next level.";
    [self.view addSubview:textView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageView];
    [self addLeftButton];
    [self addTextView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
