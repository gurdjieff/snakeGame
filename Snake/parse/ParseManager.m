//
//  ParseManager.m
//  parseCheck
//
//

#import "ParseManager.h"

@implementation ParseManager
-(void)initParse
{
    [Parse setApplicationId:@"ViGI2Dx85XfOeKeOyrUj4BtqZFdigXW6HY3gaH3q" clientKey:@"nc5hLGrfZwMtCrDtdfLZX7MqTzt7yBhn6Z81jb3k"];
}

-(void)storeToken:(NSString *)token
{    
    PFQuery *query = [PFQuery queryWithClassName:@"Token"]; //1
    [query whereKey:@"token_id" equalTo:token];//2
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
        if (!error) {
            NSLog(@"Successfully retrieved: %@", objects);
            if ([objects count] == 0) {
                PFObject *player = [PFObject objectWithClassName:@"Token"];//1
                [player setObject:token forKey:@"token_id"];
                [player save];
            }
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            NSLog(@"Error: %@", errorString);
        }  
    }];  
}

+(ParseManager *)shareParseCheck
{
    static ParseManager * instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[ParseManager alloc] init];
    });
    return instance;
}

-(id)init
{
    if ((self = [super init])) {
        [self initParse];
    }
    return self;
}
@end
