//
//  JMProductManagerTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMProductManagerTableViewCell.h"
#import "DimensMacros.h"
#import "APIStringMacros.h"
NSString *const JMProductManagerTableViewCellIdentifier = @"JMProductManagerTableViewCellIdentifier";
@interface JMProductManagerTableViewCell ()

@property (nonatomic,strong) JMGoodsData *myData;


@end
@implementation JMProductManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(JMGoodsData *)data{
    _myData = data;
    if (data.images.count > 0) {
        JMGoodsImageData *imageData = data.images[0];
        NSString *url = [NSString stringWithFormat:@"%@%@",IMG_BASE_URL_STRING,imageData.file_path];
        [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    }
    self.titleLab.text = data.title;
    self.priceLab.text =  [NSString stringWithFormat:@"¥  %@", data.price];
    if ([data.status isEqualToString:@"1"]) {
        [self.bottomBtn1 setHidden:NO];
        [self.bottomBtn2 setHidden:NO];
        [self.bottomBtn3 setHidden:YES];
    }else if ([data.status isEqualToString:@"0"]) {
        [self.bottomBtn1 setHidden:NO];
        [self.bottomBtn2 setHidden:YES];
        [self.bottomBtn3 setHidden:NO];
    }
    
    

    
}

- (IBAction)btnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedBtnWithTitle:data:)]) {
        [_delegate didSelectedBtnWithTitle:sender.titleLabel.text data:_myData];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
