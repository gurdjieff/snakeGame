
//
//  sqliteDataManage.m
//  economicInfo
//
//  Created by daiyu zhang on 12-4-10.
//

#import "sqliteDataManage.h"
#import "NSString+CustomCategory.h"

static sqliteDataManage * instance = nil;
@implementation sqliteDataManage
#define DATABASE_NAME @"Data.sqlite3"
#pragma mark openData

-(NSString *)databasePath
{
    NSString * pathname = [NSString getAppPath];
    NSLog(@"path:%@", pathname);
    return [pathname stringByAppendingPathComponent:DATABASE_NAME];
}

-(BOOL)openDataBase
{
    sqlite3_config(SQLITE_CONFIG_SERIALIZED);
    const char * databasename = [[self databasePath] UTF8String];
    if (sqlite3_open(databasename, &database) != SQLITE_OK) {
        NSLog(@"sqlite3_open is error");
        database = NULL;
        return NO;
    }
    return YES;
}

-(id)init
{
    if ((self = [super init])) {
        [self openDataBase];
        [self createTable];
    }
    return self;
}

-(BOOL)closeSqlite
{
    //    if (sqlite3_close(database) != SQLITE_OK) {
    //        NSLog(@"sqlite3_close is error");
    //        return NO;
    //    }
    return YES;
}

-(BOOL)openSqlite
{
    return [self openDataBase];
}

+(id)sharedSqliteDataManage
{
    if (instance == nil) {
        instance = [[sqliteDataManage alloc] init];
    }
    return instance;
}

-(void)createTable
{
    NSString * creatSql = @"create table if not exists score_info "
    " (id integer primary key, score text, level text, model text, date text, token text)";
    [self executeSql:creatSql];
    
    creatSql = @"create table if not exists crash_info "
    " (id integer primary key, date text, content text, name text)";
    [self executeSql:creatSql];
//    [self testData];
}

-(void)testData
{
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO score_info (score,level,model, date,token) VALUES ('33','4','sweep','09/10/2014','2222222222')"];
    [self executeSql:sql];
    [self executeSql:sql];
    [self executeSql:sql];
    [self executeSql:sql];
}

-(BOOL)executeSql:(NSString *)sql
{
    char * meg;
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &meg) != SQLITE_OK) {
        NSLog(@"sqlite3_exec is error ");
        printf("meg: %s\n", meg);
        NSLog(@"sql:%@", sql);
        return NO;
    } else {
        return YES;
    }
}

-(sqlite3_stmt *) selectData:(NSString *)sql
{
    sqlite3_stmt * statement = nil;
    if (sqlite3_prepare(database, [sql UTF8String],
                        -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"sqlite3_prepare error");
        NSLog(@"sql:%@", sql);
    }
    return statement;
}


@end
