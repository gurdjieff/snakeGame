//
//  BaseViewController.m
//  Snake
//
//  Created by daiyuzhang on 23/01/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController
-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addLeftButton
{
    UIButton * lpLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    [lpLeftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        lpLeftBtn.backgroundColor = [UIColor grayColor];
    [lpLeftBtn setBackgroundImage:[UIImage imageNamed:@"Icon_LeftArrow_Normal.png"] forState:UIControlStateNormal];
    [self.view addSubview:lpLeftBtn];
}

-(void)addImageView
{
    //    ;
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight)];
    backGround.image = [UIImage imageNamed:@"back.jpg"];
    [self.view addSubview:backGround];
}

-(void)addBaseView
{
    mpBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 44+20, 320, screenHeight-44-22)];
    mpBaseView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mpBaseView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addImageView];
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
