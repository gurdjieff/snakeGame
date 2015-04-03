//
//  FeecbabkViewCtr.m
//  Snake
//
//  Created by daiyuzhang on 03/04/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "FeecbabkViewCtr.h"
#import "UIViewExt.h"
#import "commonDataOperation.h"
#import "NewItoast.h"

@interface FeecbabkViewCtr ()<downLoadDelegate>
{
    UITextView * textView;
    UITextField * mpTextField;
    NSOperationQueue * mpOperationQueue;
}
@end

@implementation FeecbabkViewCtr
-(void)addTextView
{
    textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 44+20, 300, screenHeight-44-20-20-30-180)];
    textView.layer.cornerRadius = 5.0;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 3.0;
    textView.font = [UIFont boldSystemFontOfSize:14];
    textView.backgroundColor = [UIColor whiteColor];
//    textView.textColor = [UIColor colorWithRed:255/255.0 green:166/255.0 blue:50/255.0 alpha:1.0];
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
    
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, textView.bottom, 300, 40)];
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [submitBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:166/255.0 blue:50/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:submitBtn];
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    [NewItoast showItoastWithMessage:@"submit success!"];

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    [NewItoast showItoastWithMessage:@"submit failed!"];

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submit
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString * time = [formatter stringFromDate:date];
    if (textView.text == nil || textView.text.length == 0) {
        [NewItoast showItoastWithMessage:@"please input.."];
        return;
    }
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.tag = 101;
    [operation.argumentDic setObject:textView.text forKey:@"info"];
    [operation.argumentDic setObject:time forKey:@"time"];

    operation.downInfoDelegate = self;
    [mpOperationQueue addOperation:operation];
}

-(void)addNavigationLabel
{
    UILabel *navigationLabel  = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 44)];
    navigationLabel.backgroundColor = [UIColor clearColor];
    navigationLabel.textColor = [UIColor colorWithRed:255/255.0 green:166/255.0 blue:50/255.0 alpha:1.0];
    navigationLabel.text = @"Feedback";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:navigationLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textView resignFirstResponder];
}

-(void)initData
{
    mpOperationQueue = [[NSOperationQueue alloc] init];
    [mpOperationQueue setMaxConcurrentOperationCount:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self addImageView];
    [self addNavigationLabel];
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
