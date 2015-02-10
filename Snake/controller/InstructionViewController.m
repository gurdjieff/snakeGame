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
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 44+20, 320, screenHeight-44-20)];
    textView.editable = NO;
    textView.font = [UIFont boldSystemFontOfSize:20];
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor whiteColor];
    textView.text = @"In the game, the player controls a snake, which continuously grows longer. The player can control the direction of the snake’s head (left, right, up, and down) while looking for something to eat with each bite getting a certain amount of points. At the same time, the snake’s body becomes longer. As it grows longer, playing becomes more difficult. The snake is not allowed to touch the wall or bite its own tail. The current stage will be finished when a certain score is reached and the player continues to the next level.";
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
