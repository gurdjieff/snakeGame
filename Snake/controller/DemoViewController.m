//
//  DemoViewController.m
//  Snake
//
//  Created by daiyuzhang on 01/05/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "DemoViewController.h"
#import "UIViewExt.h"
#define oneCellMove 0.1

@interface DemoViewController ()
{
    NSMutableArray * snakeAry;
    int direction;
    float everyStepTime;
    UILabel * mpScoreAndLevel;
    NSString * directionStr;


}
@end

@implementation DemoViewController

-(void)addGameStateLabel
{    
    mpScoreAndLevel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 44)];
    mpScoreAndLevel.backgroundColor = [UIColor clearColor];
    mpScoreAndLevel.textColor = [UIColor blueColor];
    mpScoreAndLevel.textAlignment = NSTextAlignmentCenter;
    mpScoreAndLevel.font = [UIFont boldSystemFontOfSize:18];
    mpScoreAndLevel.text = @"down";
    [self.view addSubview:mpScoreAndLevel];
}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 100) {
        direction = 0;
        directionStr = @"up";
    } else if (btn.tag == 101) {
        direction = 1;
        directionStr = @"left";

    } else if (btn.tag == 102) {
        direction = 2;
        directionStr = @"right";

    } else if (btn.tag == 103) {
        direction = 3;
        directionStr = @"down";

        
    } else if (btn.tag == 104) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor= [UIColor redColor];
        btn.frame = CGRectMake(140, 350+40, 40, 40);

        [btn setTitle:[NSString stringWithFormat:@"%d", (int)[snakeAry count]] forState:UIControlStateNormal];
        UIButton * lastBtn = [snakeAry lastObject];
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blueColor].CGColor;
        [snakeAry addObject:btn];
        [self.view addSubview:btn];
        [UIView animateWithDuration:0.5 animations:^{
            btn.frame = lastBtn.frame;

        }];
        
    }
    mpScoreAndLevel.text = directionStr;

}


-(void)addBtns
{
    for (int i = 0; i < 5; i++) {
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
            
        } else if (i == 4) {
            btn.frame = CGRectMake(140, 350+40, 40, 40);
            btn.backgroundColor= [UIColor orangeColor];
        }
        
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        [self.view addSubview:btn];
    }
}

-(void)initData
{
    snakeAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor= [UIColor redColor];
        btn.frame = CGRectMake(50+i*20, 50, 20, 20);
        [btn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        
        btn.tag = 100 + i;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blueColor].CGColor;
        [self.view addSubview:btn];
        [snakeAry addObject:btn];
    }
    direction = 3;
    
}

-(void)___moveSnake:(unsigned long)index
{
    [UIView animateWithDuration:oneCellMove animations:^{
        
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
        }
    }];
    
}

-(void)__moveSnake
{
    [self ___moveSnake:[snakeAry count] - 1];
    [self performSelector:@selector(__moveSnake) withObject:nil afterDelay:oneCellMove*([snakeAry count]+2)];

}



-(void)moveSnake
{
    [self performSelector:@selector(__moveSnake) withObject:nil afterDelay:0.2];
}

- (void)upSwipe:(UIGestureRecognizer *)recognizer {
    direction = 0;
}
- (void)downSwipe:(UIGestureRecognizer *)recognizer {
    direction = 3;
    
}
- (void)leftSwipe:(UIGestureRecognizer *)recognizer {
    direction = 1;
    
}
- (void)rightSwipe:(UIGestureRecognizer *)recognizer {
    direction = 2;
    
}

-(void)addTouchMethod
{
    UISwipeGestureRecognizer *up;
    up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipe:)];
    up.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:up];
    
    UISwipeGestureRecognizer *down;
    down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipe:)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:down];
    
    UISwipeGestureRecognizer *left;
    left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *right;
    right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:right];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
//    [self addImageView];
    [self addLeftButton];
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self addTouchMethod];
    [self addBtns];
    [self moveSnake];
    [self addGameStateLabel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
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