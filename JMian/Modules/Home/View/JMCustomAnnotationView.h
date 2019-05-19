//
//  JMCustomAnnotationView.h
//  JMian
//
//  Created by mac on 2019/5/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimensMacros.h"
NS_ASSUME_NONNULL_BEGIN

@interface JMCustomAnnotationView : UIView
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *adressName;

@end

NS_ASSUME_NONNULL_END
