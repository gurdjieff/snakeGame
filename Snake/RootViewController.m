//
//  RootViewController.m
//  Snake
//
//  Created by daiyuzhang on 14-11-12.
//  Copyright (c) 2014年 daiyuzhang. All rights reserved.
//

#import "RootViewController.h"
#import "UIViewExt.h"
#define oneCellMove 0.2

@interface RootViewController ()
{
    NSMutableArray * snakeAry;
    int direction;
    float everyStepTime;
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
        [self.view addSubview:btn];
    }
}

-(void)initData
{
    snakeAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor= [UIColor redColor];
        btn.frame = CGRectMake(50+i*20, 50, 20, 20);
        [btn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];

        btn.tag = 100 + i;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [UIColor blueColor].CGColor;
        [self.view addSubview:btn];
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
    [self performSelector:@selector(__moveSnake) withObject:nil afterDelay:oneCellMove*([snakeAry count]+2)];
    [self ___moveSnake:[snakeAry count] - 1];
    return;
    
    [UIView animateWithDuration:0.1 animations:^{
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

    }];
    
    
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

- (void)viewDidLoad
{
    [self initData];

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self addTouchMethod];
//    [self addBtns];
    [self moveSnake];
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
