//
//  CALayer+UIColor.m
//  JMian
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CALayer+UIColor.h"
#import <UIKit/UIKit.h>


@implementation CALayer (UIColor)


-(void)setBorderColorFromUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
    
}

@end
