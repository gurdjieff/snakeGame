//
//  SearchViewController.m
//  Snake
//
//  Created by daiyuzhang on 22/01/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "SearchViewController.h"
#import "NetWorkingConnetion.h"
@interface SearchViewController ()
{
    NSMutableArray * mpAry;
}

@end

@implementation SearchViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageView];
    [self addLeftButton];
    [[NetWorkingConnetion shareNetWorkingConnnetion] creatClientSocket];
    [[NetWorkingConnetion shareNetWorkingConnnetion] sendInitalData];    // Do any additional setup after loading the view.
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
