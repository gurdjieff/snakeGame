//
//  CompetitionViewCtr.m
//  Snake
//
//  Created by daiyuzhang on 14/03/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "UIViewExt.h"
#import "SearchViewController.h"
#import "Snake-Swift.h"
#import <AVFoundation/AVFoundation.h>
#import "common.h"
#import "sqliteDataManage.h"
#import "NSString+CustomCategory.h"
#import "VersionUpdateAssistant.h"
#import "FacebookShareAssitant.h"
#import "CompetitionViewCtr.h"
#import "NetWorkingConnetion.h"
typedef enum {
    RPSCallNone = -1, RPSCallRock = 0, RPSCallPaper = 1, RPSCallScissors = 2 // enum is also used to index arrays
} RPSCall;
@interface CompetitionViewCtr ()
<FBRequestConnectionDelegate>
{
    NSMutableArray * snakeAry;
    int direction;
    float everyStepTime;
    float screenHight;
    float moveSpeed;
    NSMutableArray * mpBeansAry;
    UILabel * mpGameState;
    UILabel * mpScoreAndLevel;
    BOOL finished;
    UIView * mpBackView;
    NSOperationQueue *operationQueue;
}
@end
@implementation CompetitionViewCtr

-(void)creatBeans
{
    mpBeansAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        UIButton *beanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        beanBtn.backgroundColor= [UIColor colorWithRed:255/255.0 green:240/255.0 blue:41/255.0 alpha:1.0];
        beanBtn.userInteractionEnabled = NO;
        beanBtn.layer.cornerRadius = 5;
        [mpBaseView addSubview:beanBtn];
        [mpBeansAry addObject:beanBtn];
    }
    
    [self moveBeans];
}

-(void)moveBeans
{
    
    for (int i = 0; i < [mpBeansAry count]; i++) {
        UIButton * btn = mpBeansAry[i];
        btn.alpha = 0.0;
    }
    
    UIButton * beanBtn = mpBeansAry[0];
    NSDate *date = [NSDate date];
    srand([date timeIntervalSinceReferenceDate]);
    int x = rand()%(320/10);
    int height = mpBaseView.height + 2;
    int y = rand()%(height/10);
    beanBtn.frame = CGRectMake(x*10, y*10, 10, 10);
    
    
    [UIView animateWithDuration:1.0 animations:^{
        beanBtn.alpha = 1.0;
    } completion:^(BOOL finish) {
    }];
    
    [self addANewCell];
}


-(void)addANewCell
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.backgroundColor= [UIColor greenColor];
    UIButton * tailBtn = [snakeAry lastObject];
    btn.frame = tailBtn.frame;
    btn.userInteractionEnabled = NO;
    btn.layer.cornerRadius = 5;
    [mpBaseView addSubview:btn];
    [snakeAry addObject:btn];
    [self adjustSnakeColor];
    mpScoreAndLevel.text = [NSString stringWithFormat:@"competition Score:%d", (int)(([snakeAry count]-2)*([common shareCommon].level+1))];
}

-(void)adjustSnakeColor
{
    float decreaseRate = 0.8 / [snakeAry count];
    for (int i = 0 ; i < [snakeAry count]; i++) {
        UIButton * btn = snakeAry[i];
        btn.alpha = 1.0 - decreaseRate*i;
    }
}

-(void)initData
{
    NSInteger level = [common shareCommon].level;
    moveSpeed = 0.5/(level+1);
    NSInteger model = [common shareCommon].model;
    if (model == 0) {
        moveSpeed = moveSpeed * 2;
    } else if (model == 1) {
        
    }
    [self creatBeans];
    snakeAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor= [UIColor greenColor];
        btn.frame = CGRectMake(40+i*10, 2, 10, 10);
        btn.userInteractionEnabled = NO;
        btn.tag = 100 + i;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        [mpBaseView addSubview:btn];
        [snakeAry addObject:btn];
        [self adjustSnakeColor];
    }
    direction = 3;
    
    operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue setMaxConcurrentOperationCount:1];
}

-(void)snakePostionAdjust
{
    if ([snakeAry count] == 33) {
        mpGameState.hidden = NO;
        mpGameState.text = @"you win!";
        [[MusicManager shareMusicManager].successAudio play];
        finished = YES;
    }
    
    for (int i = 1 ; i < [snakeAry count]; i++) {
        UIButton * btnHead = snakeAry[0];
        UIButton * btnBody = snakeAry[i];
        if (CGRectContainsPoint(btnHead.frame, btnBody.center)) {
            mpGameState.hidden = NO;
            mpGameState.text = @"you failed";
            [[MusicManager shareMusicManager].faileAudio play];
            finished = YES;
        }
    }
    
    UIButton * btn = snakeAry[0];
    if (btn.right > 320
        || btn.left < 0
        || btn.top < 2
        || btn.bottom > mpBaseView.height) {
        if (btn.top < 2) {
            btn.top = btn.top + 10;
        }
        [[MusicManager shareMusicManager].faileAudio play];
        finished = YES;
        
        mpGameState.hidden = NO;
        mpGameState.text = @"you failed";
    }
    
    [self performSelector:@selector(__moveSnake) withObject:nil afterDelay:moveSpeed/2*3];
    
}
-(void)__moveSnake
{
    if (finished) {
        [self storeScores];
        [self transmitData];
        return;
    }
    for (int i = (int)[snakeAry count] - 1; i > 0; i--) {
        UIButton * btn1 = snakeAry[i];
        UIButton * btn2 = snakeAry[i-1];
        btn1.frame = btn2.frame;
    }
    
    UIButton * btn = snakeAry[0];
    if (direction == 0) {
        btn.top = btn.top - 10;
    } else if (direction == 1) {
        btn.left = btn.left - 10;
    } else if (direction == 2) {
        btn.right = btn.right + 10;
    } else {
        btn.top = btn.top + 10;
    }
    
    UIButton * bean = mpBeansAry[0];
    if (CGRectContainsPoint(btn.frame, bean.center)) {
        [self moveBeans];
        [[MusicManager shareMusicManager].biteAudio play];
    }
    [self snakePostionAdjust];
}


-(void)moveSnake
{
    [self performSelector:@selector(__moveSnake) withObject:nil afterDelay:0.2];
}

- (void)upSwipe:(UIGestureRecognizer *)recognizer {
    if (direction != 3) {
        direction = 0;
    }
}
- (void)downSwipe:(UIGestureRecognizer *)recognizer {
    if (direction != 0) {
        direction = 3;
    }
    
}
- (void)leftSwipe:(UIGestureRecognizer *)recognizer {
    if (direction != 2) {
        direction = 1;
    }
}
- (void)rightSwipe:(UIGestureRecognizer *)recognizer {
    if (direction != 1) {
        direction = 2;
    }
}

-(void)backViewAnimation
{
    if (finished) {
        return;
    }
    if (mpBackView.bottom <=  mpBaseView.height) {
        mpBackView.top = 2.0;
    }
    mpBackView.top = mpBackView.top - 0.4*(([common shareCommon].level+1)/1.5);
    [self performSelector:@selector(backViewAnimation) withObject:nil afterDelay:0.04];
}

-(void)addTouchMethod
{
    UISwipeGestureRecognizer *up;
    up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipe:)];
    up.direction = UISwipeGestureRecognizerDirectionUp;
    [mpBaseView addGestureRecognizer:up];
    
    UISwipeGestureRecognizer *down;
    down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipe:)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    [mpBaseView addGestureRecognizer:down];
    
    UISwipeGestureRecognizer *left;
    left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [mpBaseView addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *right;
    right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    [mpBaseView addGestureRecognizer:right];
}

-(void)addFrameView
{
    mpBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 320, mpBaseView.height*2-4)];
    mpBackView.layer.borderColor = [UIColor colorWithRed:00/255.0 green:84/255.0 blue:24/255.0 alpha:1.0].CGColor;
    mpBackView.layer.borderWidth = 1.00;
    
    [mpBaseView addSubview:mpBackView];
    mpBaseView.clipsToBounds = YES;
    
    UIImageView * frameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 320, mpBaseView.height-2)];
    frameView.userInteractionEnabled = NO;
    NSString * imageName = [NSString stringWithFormat:@"back%02ld.jpg", (long)[common shareCommon].level+1];
    frameView.image = [UIImage imageNamed:imageName];
    frameView.backgroundColor = [UIColor clearColor];
    [mpBackView addSubview:frameView];
    
    UIImageView * frameView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, frameView.bottom, 320, mpBaseView.height-2)];
    frameView2.userInteractionEnabled = NO;
    NSString * imageName2 = [NSString stringWithFormat:@"back%02ld.jpg", (long)[common shareCommon].level+1];
    frameView2.image = [UIImage imageNamed:imageName2];
    frameView2.backgroundColor = [UIColor clearColor];
    [mpBackView addSubview:frameView2];
    [self backViewAnimation];
}

-(void)directionControlWith:(double)x :(double)y :(double)z
{
    float threhold = 0.16;
    if (x < threhold*-1) {
        if (direction != 2) {
            direction = 1;
        }
    } else if (x > threhold) {
        if (direction != 1) {
            direction = 2;
        }
        
    } else if (y > threhold) {
        if (direction != 3) {
            direction = 0;
        }
    } else if (y < threhold * -1) {
        if (direction != 0) {
            direction = 3;
        }
    }
}


-(void)initMotion
{
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    if (!motionManager.accelerometerAvailable) {
        //        NSLog(@"there is no accelerometer");
    }
    motionManager.accelerometerUpdateInterval = 0.1;
    [motionManager startDeviceMotionUpdates];
    
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *latestAcc, NSError *error)
     {
         double x = motionManager.deviceMotion.gravity.x;
         double y = motionManager.deviceMotion.gravity.y;
         double z = motionManager.deviceMotion.gravity.z;
         [self directionControlWith:x :y :z];
         //         NSLog(@"x %f,y %f,z %f", x,y,z);
     }];
}

-(void)addControlEvents
{
    if ([common shareCommon].model == 0) {
        [self initMotion];
    } else if ([common shareCommon].model == 1) {
        [self addTouchMethod];
    }
}

-(void)addGameStateLabel
{
    mpGameState = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 44)];
    mpGameState.backgroundColor = [UIColor clearColor];
    mpGameState.textColor = [UIColor colorWithRed:255/255.0 green:166/255.0 blue:50/255.0 alpha:1.0];
    mpGameState.hidden = YES;
    mpGameState.textAlignment = NSTextAlignmentCenter;
    mpGameState.font = [UIFont boldSystemFontOfSize:22];
    [mpBaseView addSubview:mpGameState];
    
    mpScoreAndLevel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 44)];
    mpScoreAndLevel.backgroundColor = [UIColor clearColor];
    mpScoreAndLevel.textColor = [UIColor colorWithRed:255/255.0 green:166/255.0 blue:50/255.0 alpha:1.0];
    mpScoreAndLevel.text = [NSString stringWithFormat:@"competition Score:%d", (int)(([snakeAry count]-2)*([common shareCommon].level+1))];
    mpScoreAndLevel.textAlignment = NSTextAlignmentCenter;
    mpScoreAndLevel.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:mpScoreAndLevel];
}

-(void)leftBtnClick
{
    finished = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)transmitData
{

    NSMutableDictionary * dicInfo = [[NSMutableDictionary alloc] init];
    [dicInfo setObject:@"result" forKey:@"type"];
    if ([mpGameState.text isEqualToString:@"you win!"]) {
        [dicInfo setObject:@"failed" forKey:@"result"];
    } else {
        [dicInfo setObject:@"you win!" forKey:@"result"];
    }
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dicInfo options:NSJSONWritingPrettyPrinted error:&error];
    [[NetWorkingConnetion shareNetWorkingConnnetion] creatClientSocket];
    NSString * host = [common shareCommon].host;
    [[NetWorkingConnetion shareNetWorkingConnnetion].clientSocket sendData:jsonData toHost:host port:PORT withTimeout:2 tag:0];
    [[NetWorkingConnetion shareNetWorkingConnnetion].clientSocket closeAfterSending];
}

-(void)receivedMovement:(NSNotification *)ob
{
    NSDictionary *temp = ob.object;
    mpGameState.hidden = NO;
    mpGameState.text = temp[@"result"];
    if ([temp[@"result"] isEqualToString:@"you win!"]) {
        [[MusicManager shareMusicManager].successAudio play];
    } else {
        [[MusicManager shareMusicManager].faileAudio play];
    }
    finished = YES;
}


-(void)__storeScores
{
    NSString *level = [NSString stringWithFormat:@"%ld", (long)[common shareCommon].level+1];
    NSString *score = [NSString stringWithFormat:@"%lu", ([snakeAry count]-2)*[level intValue]];
    
    NSString *date = [NSString getCurrentDateStr];
    NSUserDefaults * lpUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [lpUserDefaults objectForKey:@"deviceToken"];
    if (token == nil) {
        token = @"simulator or push not open";
    }
    NSString *model = @"sweep";
    if ([common shareCommon].model == 0) {
        model = @"gravity";
        
    } else if ([common shareCommon].model == 1) {
        model = @"sweep";
        
    }
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO score_info (score,level,model, date,token) VALUES ('%@','%@','%@','%@','%@')", score, level, model, date, token];
    [[sqliteDataManage sharedSqliteDataManage] executeSql:sql];
}

-(void)storeScores
{
    //    [operationQueue addOperation:[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(__storeScores) object:nil]];
    [operationQueue addOperationWithBlock:^{
        [self __storeScores];
    }];
}

-(void)rightBtnClick:(UIButton *)apBtn
{
    [FacebookShareAssitant facebookShare];
}

-(void)addRightButton
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-32, 30, 28, 28);
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor whiteColor];
    [btn setBackgroundImage:[UIImage imageNamed:@"facebook-icon.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)initNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedMovement:) name:@"result" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self initNotification];
    [self addBaseView];
    [self addFrameView];
    [self addLeftButton];
    
    [self initData];
    [self addControlEvents];
    [self moveSnake];
    [self addGameStateLabel];
    [self addRightButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

