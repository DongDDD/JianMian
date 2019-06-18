//
//  JMBDetailModel.h
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMBDetailModel : NSObject
@property(nonatomic, copy)NSString *share_url;
@property(nonatomic, copy)NSString *images;

@property(nonatomic, copy)NSString *user_nickname;
@property(nonatomic, copy)NSString *user_avatar;


@property(nonatomic, copy)NSString *type_label_name;
@property(nonatomic, copy)NSString *type_label_label_id;

@end
@interface JMBDetailImageModel : NSObject

@property(nonatomic, copy)NSString *file_path;

@end
NS_ASSUME_NONNULL_END
