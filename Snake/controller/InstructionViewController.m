//
//  InstructionViewController.m
//  Snake
//
//  Created by daiyuzhang on 03/02/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "InstructionViewController.h"
#import "DemoViewController.h"

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

-(void)addTestBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-50, 20, 50, 50);
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor clearColor];
//    [btn setBackgroundImage:[UIImage imageNamed:@"facebook-icon.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)rightBtnClick:(UIButton *)apBtn
{
    DemoViewController *lpViewCtr = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:lpViewCtr animated:YES];
}

-(void)addLabel
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageView];
    [self addLeftButton];
    [self addTextView];
    [self addTestBtn];
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
