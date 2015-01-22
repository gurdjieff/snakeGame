//
//  RootViewController.m
//  Snake
//
//  Created by daiyuzhang on 14-11-12.
//  Copyright (c) 2014年 daiyuzhang. All rights reserved.
//

#import "RootViewController.h"
#import "UIViewExt.h"
#import "SecondControllerViewController.h"
#import "SearchViewController.h"

#define oneCellMove 0.2

@interface RootViewController ()
{
    NSMutableArray * snakeAry;
    int direction;
    float everyStepTime;
    float screenHight;
}
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addImageView
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, frame.size.height)];
    backGround.image = [UIImage imageNamed:@"background2.png"];
    [self.view addSubview:backGround];
}

-(void)addInstructionBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(255, 30, 58, 53);
    btn.frame = CGRectMake(200, screenHight-120, 80, 30);

    //    btn.backgroundColor = [UIColor redColor];
    [btn setBackgroundImage:[UIImage imageNamed:@"instruction.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

-(void)addHighScoresBtn
{
   
}

-(void)addBtns
{
    UIButton * soundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    soundBtn.frame = CGRectMake(280, 30, 25, 26);
    [soundBtn setBackgroundImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
    [self.view addSubview:soundBtn];
    
    
    UIButton * snakeImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    snakeImageBtn.frame = CGRectMake(0, 0, 69, 62);
    snakeImageBtn.center = CGPointMake(160, 150);

    [snakeImageBtn setBackgroundImage:[UIImage imageNamed:@"snakePic.png"] forState:UIControlStateNormal];
    [self.view addSubview:snakeImageBtn];
    
    
    UIButton * snakeTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    snakeTitleBtn.frame = CGRectMake(0, 0, 122, 29);
    snakeTitleBtn.center = CGPointMake(160, snakeImageBtn.bottom + 30);
    
    [snakeTitleBtn setBackgroundImage:[UIImage imageNamed:@"snakeTitle.png"] forState:UIControlStateNormal];
    [self.view addSubview:snakeTitleBtn];


    
    UIButton * startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(0, 0, 79, 24);
    startBtn.center = CGPointMake(160, screenHight-220);
    [startBtn setBackgroundImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    
    UIButton * instructionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    instructionBtn.frame = CGRectMake(40, startBtn.bottom + 40, 81, 11);
    [instructionBtn setBackgroundImage:[UIImage imageNamed:@"instruction.png"] forState:UIControlStateNormal];
    [self.view addSubview:instructionBtn];
    
    UIButton * highScoresBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    highScoresBtn.frame = CGRectMake(instructionBtn.right + 80, startBtn.bottom + 40, 81, 11);
    [highScoresBtn setBackgroundImage:[UIImage imageNamed:@"highScores.png"] forState:UIControlStateNormal];
    [self.view addSubview:highScoresBtn];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 79, 24);
    searchBtn.center = CGPointMake(160, startBtn.center.y+140);
//    [searchBtn setBackgroundImage:[UIImage imageNamed:@"highScores.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchCompetitor) forControlEvents:UIControlEventTouchUpInside];

    [searchBtn setTitle:@"search" forState:UIControlStateNormal];
    [self.view addSubview:searchBtn];
}
-(void)searchCompetitor
{
    SearchViewController * searchView = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchView animated:YES];
}

-(void)startGame
{
    SecondControllerViewController * sc = [[SecondControllerViewController alloc] init];
    [self.navigationController pushViewController:sc animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    screenHight = [[UIScreen mainScreen] bounds].size.height;

    [self addImageView];
    [self addBtns];
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
