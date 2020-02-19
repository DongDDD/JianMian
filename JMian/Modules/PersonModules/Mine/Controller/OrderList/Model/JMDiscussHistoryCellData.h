//
//  JMDiscussHistoryCellData.h
//  JMian
//
//  Created by mac on 2020/2/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMDiscussHistoryCellData : NSObject

@property (nonatomic, copy) NSString *boss_id;
@property (nonatomic, copy) NSString *record_id;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *sender_id;
@property (nonatomic, copy) NSArray *files;
@end
  

@interface JMDiscussHistoryFilesModel:  NSObject
@property (nonatomic, copy) NSString *file_path;

@end
NS_ASSUME_NONNULL_END
