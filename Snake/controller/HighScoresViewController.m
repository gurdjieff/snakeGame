//
//  HighScoresViewController.m
//  Snake
//
//  Created by daiyuzhang on 23/01/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "HighScoresViewController.h"
#import "common.h"
#import "ParseManager.h"

@interface HighScoresViewController ()
<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * mpTableView;
    NSMutableArray * mpScores;
}
@end

@implementation HighScoresViewController

-(void)addTalbleView
{
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+20, 320, screenHeight-44-20) style:UITableViewStylePlain];
    mpTableView.backgroundColor = [UIColor clearColor];
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:mpTableView];
    
}

-(void)getDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"Scores"]; //1
    [query orderByDescending:@"score"];
    query.limit = 9;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
        if (!error) {
            
            if ([objects count] > 0) {
                [mpScores setArray:objects];
                [mpTableView reloadData];

            }
            
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }  
    }];
}

-(void)saveScorsesToParse
{
    NSString *deviceName = [[UIDevice currentDevice] name];
    for (int i = 0; i < 10; i++) {
        PFObject *player = [PFObject objectWithClassName:@"Scores"];//1
        [player setObject:@"99" forKey:@"score"];
        [player setObject:deviceName forKey:@"name"];
        [player save];
    }
}

-(void)initData
{
    mpScores = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self addImageView];
    [self addLeftButton];
//    [self saveScorsesToParse];
    [self addTalbleView];
    [self getDataFromParse];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mpScores count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString * name = mpScores[indexPath.row][@"name"];
    NSString * score = mpScores[indexPath.row][@"score"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ score:%@", name, score];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:166/255.0 blue:50/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];


    cell.backgroundColor = [UIColor clearColor];

    return cell;
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
