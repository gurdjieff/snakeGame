//
//  LevelViewController.m
//  Snake
//
//  Created by daiyuzhang on 25/02/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "LevelViewController.h"
#import "common.h"
#import "SecondControllerViewController.h"


@interface LevelViewController ()
<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * mpTableView;
    NSMutableArray * mpLevels;
}
@end

@implementation LevelViewController
-(void)addTalbleView
{
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+20, 320, screenHeight-44-20) style:UITableViewStylePlain];
    mpTableView.backgroundColor = [UIColor clearColor];
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.bounces = NO;
    [self.view addSubview:mpTableView];
    
}

-(void)initData
{
    mpLevels = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++) {
        NSString * level = [NSString stringWithFormat:@"Level %d", i+1];
        [mpLevels addObject:level];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageView];
    [self addLeftButton];
    [self initData];
    [self addTalbleView];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mpLevels count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = mpLevels[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor yellowColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];

    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SecondControllerViewController * sc = [[SecondControllerViewController alloc] init];
    [common shareCommon].level = indexPath.row;
    [self.navigationController pushViewController:sc animated:YES];
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


//
//  HighScoresViewController.m
//  Snake
//
//  Created by daiyuzhang on 23/01/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

@end
