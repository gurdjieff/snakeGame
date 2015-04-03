//
//  baseDataOperation.h
//  economicInfo
//
//  Created by gurdjieff on 12-10-23.
//
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@protocol downLoadDelegate <NSObject>
@optional
-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag;
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag;
-(void)FreshDataWithInfo:(NSString *)info with:(NSInteger)tag;

@end




@interface baseDataOperation : NSOperation
{
    id<downLoadDelegate>downInfoDelegate;
    ASIFormDataRequest * mpFormDataRequest;
    NSInteger miTag;
}

@property NSInteger tag;
@property(nonatomic, assign)id<downLoadDelegate>downInfoDelegate;

@end
