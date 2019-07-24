//
//  SearchView.m
//  JMian
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SearchView.h"
#import "DimensMacros.h"

@implementation SearchView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆角矩形 5"]];
//        image.frame = CGRectMake(10, 0, 15, 15);
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(20);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
       self.searchTextField=[[UITextField alloc]initWithFrame:CGRectMake(40, 0, self.bounds.size.width-30, self.frame.size.height)];
        
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:240/255.0 blue:245/255.0 alpha:1.0];

        self.layer.cornerRadius = 16.5;
        self.searchTextField.clearButtonMode=UITextFieldViewModeAlways;
        self.searchTextField.textColor = [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1.0];
        self.searchTextField.font = [UIFont systemFontOfSize:13];
        self.searchTextField.returnKeyType = UIReturnKeySearch;
//        self.searchTextField.placeholder = @"🔍   搜索";
        [self addSubview: self.searchTextField];
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 
 UITextField *searchBar=[[UITextField alloc]init];
 self.backgroundColor = [UIColor redColor];
 self.layer.cornerRadius = 16.5;
 [self addSubview: searchBar];
 
 }
 */

@end
