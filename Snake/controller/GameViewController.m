//
//  GameViewController.m
//  Snake
//
//  Created by daiyuzhang on 14-12-2.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

-(void)addImageView
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    UIImageView * backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, frame.size.height)];
    backGround.image = [UIImage imageNamed:@"background.jpg"];
    [self.view addSubview:backGround];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageView];
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
