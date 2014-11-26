//
//  sqliteDataManage.h
//  economicInfo
//
//  Created by daiyu zhang on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface sqliteDataManage : NSObject {
    @public
    sqlite3 * database;
}

+(id)sharedSqliteDataManage;
-(void)createTable;


-(BOOL)openSqlite;
-(BOOL)closeSqlite;
-(sqlite3_stmt *) selectData:(NSString *)sql;
-(BOOL)executeUpdate:(NSString *)Sql;


@end
