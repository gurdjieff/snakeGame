//
//  LaunchAnimationView.m
//  launchAnimationAndVersionCheck
//
//  Created by gurd102 on 14-7-24.
//  Copyright (c) 2014年 gurd102. All rights reserved.
//

#import "LaunchAnimationView.h"
#import "UIImageView+Ext.h"


@interface LaunchAnimationView()
<UIScrollViewDelegate> {
    NSMutableArray * imageNameAry;
    UIScrollView * _scrollView;
    UIPageControl * _pageControl;
    int currentPage;
    int pageCount;
}

@end
@implementation LaunchAnimationView

-(void)initData
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    CGFloat heith = frame.size.height;
//    多少张启动图，即有多少屏。
    imageNameAry = [[NSMutableArray alloc] init];
    if (heith == 480) {
//        3.5寸的启动图
        [imageNameAry addObject:@"launch1.jpg"];
        [imageNameAry addObject:@"launch2.jpg"];
        [imageNameAry addObject:@"launch3.jpg"];
        [imageNameAry addObject:@"launch4.jpg"];
        [imageNameAry addObject:@"launch5.jpg"];

    } else {
        //        4.0寸的启动图
        [imageNameAry addObject:@"launch1-568h.jpg"];
        [imageNameAry addObject:@"launch2-568h.jpg"];
        [imageNameAry addObject:@"launch3-568h.jpg"];
        [imageNameAry addObject:@"launch4-568h.jpg"];
        [imageNameAry addObject:@"launch5-568h.jpg"];

    }
    pageCount = [imageNameAry count];
}


+(void)addLaunchAnimationViewImages
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults boolForKey:@"LaunchAnimation"]) {
        return;
    }
    
    UIView * lpWindow = [UIApplication sharedApplication].keyWindow;
    LaunchAnimationView * lpView = [[LaunchAnimationView alloc] init];
    [lpWindow addSubview:lpView];
}


-(id)init
{
    if ((self = [super init])) {
        [self initData];
        [self addLaunchAnimationViews];
        [self addPageControl];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    float offset = scrollView.contentOffset.x;
    int p = (offset + width/2) / width;
    _pageControl.currentPage = p;
    if (currentPage == pageCount-1 && offset > width*(pageCount-1)) {
        [self scrollBeyondBoarder];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    float offset = scrollView.contentOffset.x;
    currentPage = (offset + width/2) / width;
}

-(void)addPageControl
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    CGFloat width = frame.size.width;
    CGFloat heith = frame.size.height;
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, heith-40, width, 20)];
    _pageControl.numberOfPages = pageCount;
    [self addSubview:_pageControl];
}

-(void)EnterBtnClick
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"LaunchAnimation"];
    [userDefaults synchronize];
    [UIView animateWithDuration:0.5 animations:^(void){
        _scrollView.alpha = 0.0;
        _pageControl.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        [_pageControl removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void)scrollBeyondBoarder
{
    [self EnterBtnClick];
}

-(void)addLaunchAnimationViews
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    CGFloat width = frame.size.width;
    CGFloat heith = frame.size.height;
    self.frame = CGRectMake(0, 0, width, heith);
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, heith)];
    _scrollView.contentSize = CGSizeMake(width*pageCount+1, heith);
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    NSMutableArray * imageViewAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < pageCount; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 0, width, heith)];
        imageView.userInteractionEnabled = YES;
        [imageView setImageWithFileName:imageNameAry[i]];
        [imageViewAry addObject:imageView];
        [_scrollView addSubview:imageView];
    }
    [self addSubview:_scrollView];

    
    
//    可以在此修改点击进入的按钮
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn3.backgroundColor = [UIColor grayColor];
    btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn3 setTitle:@"点击进入" forState:UIControlStateNormal];
    btn3.frame = CGRectMake(220, heith-80, 80, 40);
    [btn3 addTarget:self action:@selector(EnterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [[imageViewAry lastObject] addSubview:btn3];
}

@end
