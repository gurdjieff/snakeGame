//
//  SecondControllerViewController.m
//  Snake
//
//  Created by daiyuzhang on 14-12-2.
//
#import <CoreMotion/CoreMotion.h>
#import "SecondControllerViewController.h"
#import "UIViewExt.h"
#import "SearchViewController.h"
#import "Snake-Swift.h"
#import <AVFoundation/AVFoundation.h>


@interface SecondControllerViewController ()
{
    NSMutableArray * snakeAry;
    int direction;
    float everyStepTime;
    float screenHight;
    float moveSpeed;
    NSMutableArray * mpBeansAry;
}
@end
@implementation SecondControllerViewController
@synthesize model;
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


-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 100) {
        direction = 0;
    } else if (btn.tag == 101) {
        direction = 1;
        
    } else if (btn.tag == 102) {
        direction = 2;
        
    } else if (btn.tag == 103) {
        direction = 3;
        
    }
}




-(void)addBtns
{
    for (int i = 0; i < 4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor= [UIColor blueColor];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        if (i == 0) {
            btn.frame = CGRectMake(140, 350, 40, 40);
        } else if (i == 1) {
            btn.frame = CGRectMake(140-40, 350+40, 40, 40);
            
        } else if (i == 2) {
            btn.frame = CGRectMake(140+40, 350+40, 40, 40);
            
        } else if (i == 3) {
            btn.frame = CGRectMake(140, 350+80, 40, 40);
            
        }
        
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        [mpBaseView addSubview:btn];
    }
}

-(void)creatBeans
{
    mpBeansAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        UIButton *beanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        beanBtn.backgroundColor= [UIColor colorWithRed:255/255.0 green:240/255.0 blue:41/255.0 alpha:1.0];
        beanBtn.userInteractionEnabled = NO;
        beanBtn.layer.cornerRadius = 10;
        beanBtn.layer.borderColor = [UIColor blackColor].CGColor;
        beanBtn.layer.borderWidth = 0.5;
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
    int x = rand()%(320/20);
    int height = mpBaseView.height - 2;
    int y = rand()%(height/20);
    beanBtn.frame = CGRectMake(x*20, y*20, 20, 20);


    [UIView animateWithDuration:1.0 animations:^{
        beanBtn.alpha = 1.0;
    } completion:^(BOOL finish) {
    }];
    
    [self addANewCell];
    
}


-(void)addANewCell
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.backgroundColor= [UIColor colorWithRed:71/255.0 green:240/255.0 blue:41/255.0 alpha:1.0];
    UIButton * tailBtn = [snakeAry lastObject];
    btn.frame = tailBtn.frame;
    btn.userInteractionEnabled = NO;
    btn.layer.cornerRadius = 4;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 0.5;
    [mpBaseView addSubview:btn];
    [snakeAry addObject:btn];
    [self adjustSnakeColor];

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
    moveSpeed = 0.2;
    [self creatBeans];
    snakeAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor= [UIColor colorWithRed:71/255.0 green:240/255.0 blue:41/255.0 alpha:1.0];
        btn.frame = CGRectMake(40+i*20, 2, 20, 20);
        btn.userInteractionEnabled = NO;
//        [btn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        
        btn.tag = 100 + i;
        btn.layer.cornerRadius = 4;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = 0.5;
        [mpBaseView addSubview:btn];
        [snakeAry addObject:btn];
        [self adjustSnakeColor];
    }
    direction = 3;
}

-(void)___moveSnake:(unsigned long)index
{
    
    
    [UIView animateWithDuration:moveSpeed/[snakeAry count] animations:^{
        
        if (index == 0) {
            UIButton * btn = snakeAry[0];
            if (direction == 0) {
                btn.top = btn.top - 20;
            } else if (direction == 1) {
                btn.left = btn.left - 20;
            } else if (direction == 2) {
                btn.right = btn.right + 20;
            } else {
                btn.top = btn.top + 20;
            }
        } else {
            UIButton * btn1 = snakeAry[index];
            UIButton * btn2 = snakeAry[index-1];
            btn1.frame = btn2.frame;
            
        }
        
        
    } completion:^(BOOL finished) {
        if (index > 0) {
            [self ___moveSnake:index-1];
        } else {
            UIButton * bean = mpBeansAry[0];
            UIButton * btn = snakeAry[0];

            if (CGRectContainsPoint(btn.frame, bean.center)) {
                [self moveBeans];


            }
            [self snakePostionAdjust];

        }
    }];

    
}

-(void)snakePostionAdjust
{
    for (int i = 0 ; i < [snakeAry count]; i++) {
        UIButton * btn = snakeAry[i];
        if (btn.right > 320) {
            btn.right = btn.right - 320;
        }
        
        if (btn.left < 0) {
            btn.left = btn.left + 320;
        }
        
        if (btn.top < 2) {
            btn.top = btn.top + mpBaseView.height-2;
        }
        
        if (btn.bottom > mpBaseView.height) {
            btn.bottom = btn.bottom - mpBaseView.height+2;
        }
    }


}
-(void)__moveSnake
{
    for (int i = (int)[snakeAry count] - 1; i > 0; i--) {
        UIButton * btn1 = snakeAry[i];
        UIButton * btn2 = snakeAry[i-1];
        btn1.frame = btn2.frame;
    }
    
    UIButton * btn = snakeAry[0];
    if (direction == 0) {
        btn.top = btn.top - 20;
    } else if (direction == 1) {
        btn.left = btn.left - 20;
    } else if (direction == 2) {
        btn.right = btn.right + 20;
    } else {
        btn.top = btn.top + 20;
    }
    
    UIButton * bean = mpBeansAry[0];
    if (CGRectContainsPoint(btn.frame, bean.center)) {
        [self moveBeans];
        [[MusicManager shareMusicManager].biteAudio play];
    }
    [self snakePostionAdjust];
    [self performSelector:@selector(__moveSnake) withObject:nil afterDelay:moveSpeed/2*3];
    

//    [UIView animateWithDuration:0.0 animations:^{
//        for (int i = (int)[snakeAry count] - 1; i > 0; i--) {
//            UIButton * btn1 = snakeAry[i];
//            UIButton * btn2 = snakeAry[i-1];
//            btn1.frame = btn2.frame;
//        }
//        
//        UIButton * btn = snakeAry[0];
//        if (direction == 0) {
//            btn.top = btn.top - 20;
//        } else if (direction == 1) {
//            btn.left = btn.left - 20;
//        } else if (direction == 2) {
//            btn.right = btn.right + 20;
//        } else {
//            btn.top = btn.top + 20;
//        }
//    } completion:^(BOOL finished) {
//        UIButton * bean = mpBeansAry[0];
//        UIButton * btn = snakeAry[0];
//        if (CGRectContainsPoint(btn.frame, bean.center)) {
//            [self moveBeans];
//        }
//        [self snakePostionAdjust];
//        [self performSelector:@selector(__moveSnake) withObject:nil afterDelay:moveSpeed/2*3];
//
//    }];
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
    UIView * frameView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 320, mpBaseView.height-2)];
    frameView.userInteractionEnabled = NO;
    frameView.layer.borderWidth = 2.00;
    frameView.layer.borderColor = [UIColor greenColor].CGColor;
    frameView.backgroundColor = [UIColor clearColor];
    [mpBaseView addSubview:frameView];
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
    if (model == 0) {
        [self initMotion];
    } else if (model == 1) {
        [self addTouchMethod];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageView];
    
    [self addLeftButton];
    [self addBaseView];
    [self addFrameView];

    [self initData];
    [self addControlEvents];
    //    [self addBtns];
    [self moveSnake];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self.navigationController popViewControllerAnimated:YES];
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
