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
<NetworkConnection, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * mpAry;
    UITableView * mpTableView;
}

@end

@implementation SearchViewController

-(void)receivedRespondFromBroadCast:(NSDictionary *)info
{
    for (int i = 0; i < [mpAry count]; i++) {
        if ([mpAry[i][@"host"] isEqualToString:info[@"host"]]) {
            return;
        }
    }
    [mpAry addObject:info];
    [mpTableView reloadData];
    NSLog(@"------%@", mpAry);
}

-(void)addTalbleView
{
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+20, 320, screenHeight-44-20) style:UITableViewStylePlain];
    mpTableView.backgroundColor = [UIColor clearColor];
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:mpTableView];
    
}

-(void)initData
{
    mpAry = [[NSMutableArray alloc] init];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self addImageView];
    [self addTalbleView];
    [self addLeftButton];
    NetWorkingConnetion * instance = [NetWorkingConnetion shareNetWorkingConnnetion];
    [instance sendInitalData];
    instance.networkDelegate = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mpAry count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString * host = [NSString stringWithString:mpAry[indexPath.row][@"host"]];
    if ([host hasPrefix:@"::ffff"]) {
        host = [host substringFromIndex:7];
    }
    
    NSString * name = mpAry[indexPath.row][@"name"];

    cell.detailTextLabel.text = [NSString stringWithFormat:@"host:%@", host];
    cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    cell.detailTextLabel.textColor = [UIColor colorWithRed:255/255.0 green:166/255.0 blue:50/255.0 alpha:1.0];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:14];
    
    cell.textLabel.text = [NSString stringWithFormat:@"name:%@", name];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:166/255.0 blue:50/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.contentView.layer.borderWidth = 1.0;
    cell.contentView.layer.borderColor = [UIColor yellowColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSError * error = nil;
    NSString * str = [UIDevice currentDevice].name;
    NSMutableDictionary * dicInfo = [[NSMutableDictionary alloc] init];
    [dicInfo setObject:@"invitation" forKey:@"type"];
    [dicInfo setObject:str forKey:@"name"];
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dicInfo options:NSJSONWritingPrettyPrinted error:&error];
    [[NetWorkingConnetion shareNetWorkingConnnetion] creatClientSocket];
    AsyncUdpSocket * clientSocket = [NetWorkingConnetion shareNetWorkingConnnetion].clientSocket;
    NSString * host = mpAry[indexPath.row][@"host"];
    [clientSocket sendData:jsonData toHost:host port:PORT withTimeout:-1 tag:0];
    [clientSocket closeAfterSending];
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
