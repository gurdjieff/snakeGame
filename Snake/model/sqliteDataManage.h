//
//  sqliteDataManage.h
//  economicInfo
//
//  Created by daiyu zhang on 12-4-10.
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
-(BOOL)executeSql:(NSString *)sql;


@end
