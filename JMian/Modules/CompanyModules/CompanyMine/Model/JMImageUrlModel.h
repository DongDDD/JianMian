//
//  JMImageUrlModel.h
//  JMian
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
NS_ASSUME_NONNULL_BEGIN

@interface JMImageUrlModel : NSObject
@property (nonatomic, copy) NSString *file_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *file_path;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *denial_reason;
@property (nonatomic, assign) int index;
@property (nonatomic, retain) UIImage *myImage;

@end

NS_ASSUME_NONNULL_END
