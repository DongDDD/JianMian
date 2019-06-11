//
//  JMTaskGoodsDetailModel.h
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMTaskGoodsDetailModel : NSObject
@property (nonatomic, copy) NSString *task_id;

@property (nonatomic, copy) NSString *companyiId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *companyLogo_path;

@property (nonatomic, copy) NSString *video_file_id;
@property (nonatomic, copy) NSString *video_type;
@property (nonatomic, copy) NSString *video_cover;
@property (nonatomic, copy) NSString *video_file_path;
@property (nonatomic, copy) NSString *video_status;
@property (nonatomic, copy) NSString *video_denial_reason;


@property (nonatomic, copy) NSString *goodsTitle;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *goodsDescription;

@property (nonatomic, strong) NSArray *images;


@end

@interface JMImageModel : NSObject

@property (nonatomic, copy) NSString *file_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *file_path;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *denial_reason;


@end

NS_ASSUME_NONNULL_END
