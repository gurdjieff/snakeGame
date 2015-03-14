//
//  CompetedViewController.m
//  Snake
//
//  Created by daiyuzhang on 14/03/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "CompetedViewController.h"
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

@interface CompetedViewController ()
<FBRequestConnectionDelegate>
{
    NSMutableArray * snakeAry;
    NSMutableArray * snakeAry2;
    NSMutableArray * repositoryAry;

    int direction;
    int direction2;

    float everyStepTime;
    float screenHight;
    float moveSpeed;
    NSMutableArray * mpBeansAry;
    UILabel * mpGameState;
    UILabel * mpScoreAndLevel;
    BOOL finished;
    UIView * mpBackView;
    NSOperationQueue *operationQueue;
    NSUInteger type;
    
}
@end
@implementation CompetedViewController
-(void)moveToLeft
{
    
}

-(void)moveToRight
{
    
}

-(void)moveToUp
{
    
}

-(void)moveToDown
{
    
}

-(void)snakePostionAdjust
{
    for (int i = 1 ; i < [snakeAry count]; i++) {
        UIButton * btnHead = snakeAry[0];
        UIButton * btnBody = snakeAry[i];
        if (CGRectContainsPoint(btnHead.frame, btnBody.center)) {
            mpGameState.hidden = NO;
            mpGameState.text = @"Game Over";
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
        mpGameState.text = @"Game Over";
    }
    
    for (int i = 1 ; i < [snakeAry2 count]; i++) {
        UIButton * btnHead = snakeAry2[0];
        UIButton * btnBody = snakeAry2[i];
        if (CGRectContainsPoint(btnHead.frame, btnBody.center)) {
            mpGameState.hidden = NO;
            mpGameState.text = @"Game Over";
            [[MusicManager shareMusicManager].faileAudio play];
            finished = YES;
        }
    }
    
    btn = snakeAry2[0];
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
        mpGameState.text = @"Game Over";
    }

//    [self transmitData];
    
}
-(void)toMoveSnake
{
    if (finished) {
//        [self storeScores];
        return;
    }
    for (int i = (int)[snakeAry count] - 1; i > 0; i--) {
        UIButton * btn1 = snakeAry[i];
        UIButton * btn2 = snakeAry[i-1];
        btn1.frame = btn2.frame;
    }
    
    for (int i = (int)[snakeAry2 count] - 1; i > 0; i--) {
        UIButton * btn1 = snakeAry2[i];
        UIButton * btn2 = snakeAry2[i-1];
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
    
    
    
    UIButton * btn2 = snakeAry2[0];
    if (direction2 == 0) {
        btn2.top = btn2.top - 10;
    } else if (direction2 == 1) {
        btn2.left = btn2.left - 10;
    } else if (direction2 == 2) {
        btn2.right = btn.right + 10;
    } else {
        btn2.top = btn2.top + 10;
    }

//    UIButton * bean = mpBeansAry[0];
//    if (CGRectContainsPoint(btn.frame, bean.center)) {
//        [self moveBeans];
//        [[MusicManager shareMusicManager].biteAudio play];
//    } else if (CGRectContainsPoint(btn2.frame, bean.center)) {
//        [self moveBeans2];
//        [[MusicManager shareMusicManager].biteAudio play];
//    } else {
//        [self transmitData];
//
//    }
//    
//    [self snakePostionAdjust];
    
    [self transmitData];

}

-(void)moveSnake
{
    
}


- (void)upSwipe:(UIGestureRecognizer *)recognizer {
    NSLog(@"upSwipe");
    if (type == 0) {
        if (direction != 3) {
            direction = 0;
        }
    } else {
        if (direction2 != 3) {
            direction2 = 0;
        }
    }
    
}
- (void)downSwipe:(UIGestureRecognizer *)recognizer {
    NSLog(@"downSwipe");

    if (type == 0) {
        if (direction != 0) {
            direction = 3;
        }
    } else {
        if (direction2 != 0) {
            direction2 = 3;
        }
    }
    
}
- (void)leftSwipe:(UIGestureRecognizer *)recognizer {
    NSLog(@"leftSwipe");

    if (type == 0) {
        if (direction != 2) {
            direction = 1;
        }
    } else {
        if (direction2 != 2) {
            direction2 = 1;
        }
    }
    
}
- (void)rightSwipe:(UIGestureRecognizer *)recognizer {
    NSLog(@"rightSwipe");
    NSLog(@"direction:%d", direction);
    NSLog(@"direction2:%d", direction2);


    if (type == 0) {
        if (direction != 1) {
            direction = 2;
        }
    } else {
        if (direction2 != 1) {
            direction2 = 2;
        }
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


#pragma mark addviews
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


-(void)addControlEvents
{
    if ([common shareCommon].model == 0) {
//        [self initMotion];
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
    //    mpScoreAndLevel.hidden = YES;
    mpScoreAndLevel.text = [NSString stringWithFormat:@"Score:%d  Level:%d", (int)[snakeAry count]-2, (int)[common shareCommon].level+1];
    mpScoreAndLevel.textAlignment = NSTextAlignmentCenter;
    mpScoreAndLevel.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:mpScoreAndLevel];
}

-(void)leftBtnClick
{
    finished = YES;
    [self.navigationController popViewControllerAnimated:YES];
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


#pragma mark network
-(void)transmitData
{
    NSMutableDictionary * dicInfo = [[NSMutableDictionary alloc] init];
    [dicInfo setObject:@"movement" forKey:@"type"];
    
    NSMutableArray * ary = [[NSMutableArray alloc] init];
    for (int i = 0; i < [snakeAry count]; i++) {
        UIButton * btn = [snakeAry objectAtIndex:i];
        NSString * frame = NSStringFromCGRect(btn.frame);
        [ary addObject:frame];
    }
    
    [dicInfo setObject:ary forKey:@"snakeAry"];
    
    NSMutableArray * ary2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < [snakeAry2 count]; i++) {
        UIButton * btn = [snakeAry2 objectAtIndex:i];
        NSString * frame = NSStringFromCGRect(btn.frame);
        [ary2 addObject:frame];
    }
    
    [dicInfo setObject:ary2 forKey:@"snakeAry2"];
    
    
    NSMutableArray * ary3 = [[NSMutableArray alloc] init];
    for (int i = 0; i < [mpBeansAry count]; i++) {
        UIButton * btn = [mpBeansAry objectAtIndex:i];
        NSString * frame = NSStringFromCGRect(btn.frame);
        [ary3 addObject:frame];
    }
    
    [dicInfo setObject:ary3 forKey:@"mpBeansAry"];
    
    [dicInfo setObject:[NSNumber numberWithInteger:direction] forKey:@"direction"];
    [dicInfo setObject:[NSNumber numberWithInteger:direction2] forKey:@"direction2"];

    
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
    
    for (int i = 0; i < [mpBeansAry count]; i++) {
        UIButton *btn = mpBeansAry[i];
        [btn removeFromSuperview];
    }
    [mpBeansAry removeAllObjects];
    
    for (int i = 0; i < [snakeAry count]; i++) {
        UIButton *btn = snakeAry[i];
        [btn removeFromSuperview];
    }
    [snakeAry removeAllObjects];
    
    for (int i = 0; i < [snakeAry2 count]; i++) {
        UIButton *btn = snakeAry2[i];
        [btn removeFromSuperview];
    }
    [snakeAry2 removeAllObjects];
    

    for (int i = 0; i < 1; i++) {
        UIButton *beanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        beanBtn.backgroundColor= [UIColor colorWithRed:255/255.0 green:240/255.0 blue:41/255.0 alpha:1.0];
        NSString * framStr = temp[@"mpBeansAry"][0];
        beanBtn.frame = CGRectFromString(framStr);
        beanBtn.userInteractionEnabled = NO;
        beanBtn.layer.cornerRadius = 5;
        [mpBaseView addSubview:beanBtn];
        [mpBeansAry addObject:beanBtn];
    }

    for (int i = 0; i < [temp[@"snakeAry"] count]; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor= [UIColor greenColor];
        NSString * framStr = temp[@"snakeAry"][i];
        btn.frame = CGRectFromString(framStr);
        btn.userInteractionEnabled = NO;
        btn.tag = 100 + i;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        [mpBaseView addSubview:btn];
        [snakeAry addObject:btn];
        [self adjustSnakeColor];
    }
    
    snakeAry2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor= [UIColor greenColor];
        NSString * framStr = temp[@"snakeAry2"][i];
        btn.frame = CGRectFromString(framStr);
        btn.userInteractionEnabled = NO;
        btn.tag = 100 + i;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        [mpBaseView addSubview:btn];
        [snakeAry2 addObject:btn];
        [self adjustSnakeColor];
    }

    direction = [temp[@"direction"] intValue];
    direction2 = [temp[@"direction2"] intValue];

//    NSLog(@"%@", ob.object);
    [self performSelector:@selector(toMoveSnake) withObject:nil afterDelay:0.2];
}


#pragma mark - initiation

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

-(void)moveBeans2
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
    
    [self addANewCell2];
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
    mpScoreAndLevel.text = [NSString stringWithFormat:@"Score:%d  Level:%d", (int)(([snakeAry count]-2)*([common shareCommon].level+1)), (int)[common shareCommon].level+1];
    [self transmitData];
}

-(void)addANewCell2
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.backgroundColor= [UIColor greenColor];
    UIButton * tailBtn = [snakeAry2 lastObject];
    btn.frame = tailBtn.frame;
    btn.userInteractionEnabled = NO;
    btn.layer.cornerRadius = 5;
    [mpBaseView addSubview:btn];
    [snakeAry2 addObject:btn];
    [self adjustSnakeColor];
    mpScoreAndLevel.text = [NSString stringWithFormat:@"Score:%d  Level:%d", (int)(([snakeAry2 count]-2)*([common shareCommon].level+1)), (int)[common shareCommon].level+1];
    [self transmitData];
}


-(void)adjustSnakeColor
{
    float decreaseRate = 0.8 / [snakeAry count];
    for (int i = 0 ; i < [snakeAry count]; i++) {
        UIButton * btn = snakeAry[i];
        btn.alpha = 1.0 - decreaseRate*i;
    }
    
    decreaseRate = 0.8 / [snakeAry2 count];
    for (int i = 0 ; i < [snakeAry2 count]; i++) {
        UIButton * btn = snakeAry2[i];
        btn.alpha = 1.0 - decreaseRate*i;
    }
}

-(void)initBeans
{
    mpBeansAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        UIButton *beanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        beanBtn.backgroundColor= [UIColor colorWithRed:255/255.0 green:240/255.0 blue:41/255.0 alpha:1.0];
        beanBtn.alpha = 0.0;
        beanBtn.userInteractionEnabled = NO;
        beanBtn.layer.cornerRadius = 5;
        [mpBaseView addSubview:beanBtn];
        [mpBeansAry addObject:beanBtn];

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
}

-(void)initData
{
    type = [common shareCommon].type;
    NSInteger level = [common shareCommon].level;
    moveSpeed = 0.5/(level+1);
//    moveSpeed = 1;

    NSInteger model = [common shareCommon].model;
    if (model == 0) {
        moveSpeed = moveSpeed * 2;
    } else if (model == 1) {
        
    }
    [self initBeans];
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
    
    snakeAry2 = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor= [UIColor greenColor];
        btn.frame = CGRectMake(240+i*10, mpBaseView.height-10, 10, 10);
        btn.userInteractionEnabled = NO;
        btn.tag = 100 + i;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        [mpBaseView addSubview:btn];
        [snakeAry2 addObject:btn];
        [self adjustSnakeColor];
    }
    direction = 3;
    direction2 = 0;
    
    if ([common shareCommon].type == 0) {
        [self transmitData];
    }
}


-(void)initOperationQueue
{
    operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue setMaxConcurrentOperationCount:1];
}


-(void)initNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedMovement:) name:@"movement" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self initNotification];
    [self initOperationQueue];

    [self addBaseView];
    [self addFrameView];
    [self addLeftButton];
    
    [self initData];
    [self addControlEvents];
    [self addGameStateLabel];
    [self addRightButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
