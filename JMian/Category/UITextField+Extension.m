//
//  UITextField+Extension.m
//  JMian
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)


+(UITextField *)searchBarWithTextField
 {
       UIView *view = [[UIView alloc] init];
       view.frame = CGRectMake(20,64,335,33);
       view.backgroundColor = [UIColor colorWithRed:241/255.0 green:240/255.0 blue:245/255.0 alpha:1.0];
       view.layer.cornerRadius = 16.5;
     
     
     //添加搜索框
        UITextField *searchBar=[[UITextField alloc]init];
     searchBar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
     searchBar.placeholder = @"搜索职位";
 //     attributedPlaceholder
         //设置搜索框的宽度和高度属性改为由外界进行设置
     //    searchBar.width=300;
     //    searchBar.height=35;
     
     
     //垂直居中
     
       searchBar.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
      searchBar.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
       //设置搜索框的背景颜色为提供的图片
       searchBar.layer.cornerRadius = 16.5;
//       searchBar.background = [UIImage imageNamed:@""];
       searchBar.backgroundColor = [UIColor colorWithRed:241/255.0 green:240/255.0 blue:245/255.0 alpha:1.0];
         //    searchBar.background=[UIImage imageWithName:@"searchbar_textfield_background"];
    
         //添加放大镜
         UIImageView *leftView = [[UIImageView alloc]init];
         leftView.image = [UIImage imageNamed:@"圆角矩形"];
         leftView.backgroundColor = [UIColor whiteColor];
     
        //设置放大镜距离两边的间隔
//         leftView.width=leftView.image.size.width+10;
//         leftView.height=leftView.width;
//
         //设置放大镜居中
         leftView.contentMode=UIViewContentModeCenter;
         searchBar.leftView=leftView;
         //设置左边永远显示
         searchBar.leftViewMode=UITextFieldViewModeAlways;
    
         //设置全部清除按钮，永远显示
         searchBar.clearButtonMode=UITextFieldViewModeAlways;
         return searchBar;
     }

@end
