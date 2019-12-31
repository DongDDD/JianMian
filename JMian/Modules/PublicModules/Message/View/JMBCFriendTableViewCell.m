//
//  JMBCFriendTableViewCell.m
//  JMian
//
//  Created by mac on 2019/12/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBCFriendTableViewCell.h"
#import "DimensMacros.h"
@interface JMBCFriendTableViewCell ()
@property(nonatomic,strong)JMFriendListData *myData;
@property(nonatomic,assign)BOOL isSelected;


@end
@implementation JMBCFriendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedAction)];
    [self addGestureRecognizer:tap];

}

-(void)setData:(JMFriendListData *)data{
    if (_viewType2 == JMFriendTableViewCellFriendList) {
        [self.selectedImageView setHidden:YES];
    }else if (_viewType2 == JMFriendTableViewCellCreateGroup) {
        [self.selectedImageView setHidden:NO];
    }
    _myData = data;
    if (_viewType == JMBFriendTableViewCell) {
        [self.headerImg sd_setImageWithURL:[NSURL URLWithString:data.friend_agency_logo_path] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        self.nameLab.text =data.friend_agency_company_name;
    }else if (_viewType == JMCFriendTableViewCell) {
        [self.headerImg sd_setImageWithURL:[NSURL URLWithString:data.friend_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        self.nameLab.text =data.friend_nickname;
        
    }

    
}

-(void)selectedAction{
    if (_viewType2 == JMFriendTableViewCellCreateGroup) {
        _isSelected = !_isSelected;
        if (_isSelected) {
            
            self.selectedImageView.image = [UIImage imageNamed:@"icon-Checklist"];
            if (_delegate && [_delegate respondsToSelector:@selector(didSelectedFriendWithModel:)]) {
                if (_viewType == JMBFriendTableViewCell) {
                    _myData.type = B_Type_UESR;
                }else if (_viewType == JMCFriendTableViewCell){
                    _myData.type = C_Type_USER;
                    
                }
                [_delegate didSelectedFriendWithModel:_myData];
            }
            
        }else{
            self.selectedImageView.image = [UIImage imageNamed:@"椭圆 3"];
            if (_delegate && [_delegate respondsToSelector:@selector(didCancelFriendWithModel:)]) {
                if (_viewType == JMBFriendTableViewCell) {
                    _myData.type = B_Type_UESR;
                }else if (_viewType == JMCFriendTableViewCell){
                    _myData.type = C_Type_USER;
                    
                }
                [_delegate didCancelFriendWithModel:_myData];
            }
        }
    }
   

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (_isSelected == NO) {
//        _isSelected = YES;
//        self.selectedImageView.image = [UIImage imageNamed:@"椭圆 3"];
////        self.selectedImageView.image = [UIImage imageNamed:@"椭圆 3"];
//
//    }else{
//        self.selectedImageView.image = [UIImage imageNamed:@"dingwei"];
//        _isSelected = NO;
////        self.selectedImageView.image = [UIImage imageNamed:@"组 54"];
//
//
//
//
//    }
//    if (!selected) {
////          if (_delegate && [_delegate respondsToSelector:@selector(didSelectedFriendWithModel:)]) {
////              if (_viewType == JMBFriendTableViewCell) {
////                  _data.type = B_Type_UESR;
////              }else if (_viewType == JMCFriendTableViewCell){
////                  _data.type = C_Type_USER;
////
////              }
////              [_delegate didSelectedFriendWithModel:_myData];
////          }
//          NSLog(@"被选");
//      }
//    else{
//        self.selectedImageView.image = [UIImage imageNamed:@"组 54"];
//
//          NSLog(@"没被选");
//
//      }
    // Configure the view for the selected state
}

@end
