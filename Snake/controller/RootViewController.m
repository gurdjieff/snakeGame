//
//  RootViewController.m
//  Snake
//
//  Created by daiyuzhang on 14-11-12.
//

#import "RootViewController.h"
#import "UIViewExt.h"
#import "VersionUpdateAssistant.h"

#import "SecondControllerViewController.h"
#import "SearchViewController.h"
#import "HighScoresViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Snake-Swift.h"
#import "InstructionViewController.h"
#import "LevelViewController.h"
#import "FeecbabkViewCtr.h"
//#import "Snake_temp_caseinsensitive_rename_temp_caseinsensitive_rename-Swift.h"


#define oneCellMove 0.2

@interface RootViewController ()
<AVAudioPlayerDelegate, UIAlertViewDelegate>
{
    NSMutableArray * snakeAry;
    int direction;
    float everyStepTime;
    float screenHight;
    UIImageView * stopImage;

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
//    backGround.image = [UIImage imageNamed:@"background2.png"];
    backGround.image = [UIImage imageNamed:@"back20.jpg"];

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

-(void)highScoresBtnClick
{
    HighScoresViewController * viewController = [[HighScoresViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)switchSound:(UIButton *)soundBtn
{
    soundBtn.selected = !soundBtn.selected;
    if (soundBtn.selected == YES) {
        [soundBtn setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
        [[MusicManager shareMusicManager].bgcAudio play];


    } else {
        [soundBtn setImage:[UIImage imageNamed:@"soundStop.png"] forState:UIControlStateNormal];
        [[MusicManager shareMusicManager].bgcAudio stop];

    }
//    stopImage.hidden = !stopImage.hidden;
//    if (stopImage.hidden) {
//        [[MusicManager shareMusicManager].bgcAudio play];
//
//    } else {
//        [[MusicManager shareMusicManager].bgcAudio stop];
//
//    }

}

-(void)instructionBtnClick
{
    InstructionViewController * viewController = [[InstructionViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}


-(void)addBtns
{
    UIButton * soundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    soundBtn.frame = CGRectMake(270, 10, 50, 50);
    soundBtn.selected = YES;
    [soundBtn setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
    [soundBtn setContentMode:UIViewContentModeCenter];
    [soundBtn addTarget:self action:@selector(switchSound:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:soundBtn];
    
//    stopImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    stopImage.image = [UIImage imageNamed:@"stop.png"];
//    stopImage.contentMode = UIViewContentModeCenter;
//    stopImage.alpha = 0.7;
//    stopImage.hidden = YES;
//    [soundBtn addSubview:stopImage];
    
    
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
    [startBtn setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    
    UIButton * instructionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    instructionBtn.frame = CGRectMake(40, startBtn.bottom + 40, 81, 40);
//    instructionBtn.backgroundColor = [UIColor blueColor];

    [instructionBtn setImage:[UIImage imageNamed:@"instruction.png"] forState:UIControlStateNormal];
    [instructionBtn setContentMode:UIViewContentModeCenter];

    [instructionBtn addTarget:self action:@selector(instructionBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:instructionBtn];
    
    UIButton * highScoresBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    highScoresBtn.frame = CGRectMake(instructionBtn.right + 80, startBtn.bottom + 40, 81, 40);
    [highScoresBtn setImage:[UIImage imageNamed:@"highScores.png"] forState:UIControlStateNormal];
    [instructionBtn setContentMode:UIViewContentModeCenter];

    [highScoresBtn addTarget:self action:@selector(highScoresBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:highScoresBtn];
    
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 120, 50);
    searchBtn.center = CGPointMake(160, startBtn.center.y+140);
    [searchBtn addTarget:self action:@selector(searchCompetitor) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitle:@"search" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [searchBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:166/255.0 blue:50/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:searchBtn];
}
-(void)searchCompetitor
{
    SearchViewController * searchView = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchView animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    LevelViewController * sc = [[LevelViewController alloc] init];
    [common shareCommon].model = buttonIndex;
    [self.navigationController pushViewController:sc animated:YES];

}

-(void)startGame
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"choose model" delegate:self cancelButtonTitle:nil otherButtonTitles:@"gravity",@"sweep", nil];
    
    [alertView show];
}

-(void)initMusic
{
    [[MusicManager shareMusicManager].bgcAudio play];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{

}

-(void)versionUpdate
{
    [VersionUpdateAssistant checkAppVersionInfomation];
}

-(void)addVersionLabel
{
    UIButton * versionBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, screenHeight-40, 220, 40)];
    [versionBtn addTarget:self action:@selector(versionUpdate) forControlEvents:UIControlEventTouchUpInside];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleVersion"];
    [versionBtn setTitle:[NSString stringWithFormat:@"version:%@", currentVersion] forState:UIControlStateNormal];
    [versionBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:versionBtn];
}

-(void)addFeedbackBtn
{
//    UIButton * btn = [UIButton buttonWithType:];
    UIButton * feedbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(290, screenHeight-40, 25, 25)];
    [feedbackBtn addTarget:self action:@selector(feedback) forControlEvents:UIControlEventTouchUpInside];
//    [feedbackBtn setTitle:@"feedback" forState:UIControlStateNormal];
//    feedbackBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [feedbackBtn setBackgroundImage:[UIImage imageNamed:@"feedback.png"] forState:UIControlStateNormal];
    [feedbackBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:feedbackBtn];
}

-(void)feedback
{
    FeecbabkViewCtr * viewCtr = [[FeecbabkViewCtr alloc] init];
    [self.navigationController pushViewController:viewCtr animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    screenHight = [[UIScreen mainScreen] bounds].size.height;
    [self initMusic];

    [self addImageView];
    [self addBtns];
    [self addVersionLabel];
    [self addFeedbackBtn];
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
