//
//  JMGradeView.m
//  JMian
//
//  Created by mac on 2019/6/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMGradeView.h"
@interface JMGradeView ()

@property(nonatomic,copy)NSString *imgName;

@end
@implementation JMGradeView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
//    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
    return self;
}



-(void)setGradeStr:(NSString *)gradeStr{
    //判断是哪种段位
    int grade = [gradeStr intValue];
    
    if (grade >= 4 && grade <=250) {
        //心
        _imgName = @"xin";
       
    }else if (grade >= 250  && grade <= 10000) {
        //钻石
        _imgName = @"zhuanshi";
        
    }else if (grade >= 10001  && grade <= 500000) {
        //蓝冠
        _imgName = @"languan";
        
    }else if (grade >= 500001) {
        //黄冠
        _imgName = @"huangguan";
        
    }else{
        _imgName = @"";
    }
    
    [self judeGradeImgCountWithGrade:grade];
}

//判断图标数量
-(void)judeGradeImgCountWithGrade:(int)grade{
    int imgCount = 0;
    //心
    if (grade>=4 && grade<=10) {
        imgCount = 1;
    }else if (grade >= 11 && grade <= 40) {
        imgCount = 2;

    }else if (grade >= 41 && grade <= 90) {
        imgCount = 3;
        
    }else if (grade >= 91 && grade <= 150) {
        imgCount = 4;
        
    }else if (grade >= 151 && grade <= 250) {
        imgCount = 5;
        
    }

    //钻石
    if (grade>=251 && grade<=500) {
        imgCount = 1;
    }else if (grade >= 501 && grade <= 1000) {
        imgCount = 2;

    }else if (grade >= 1001 && grade <= 2000) {
        imgCount = 3;

    }else if (grade >= 2001 && grade <= 5000) {
        imgCount = 4;

    }else if (grade >= 5001 && grade <= 10000) {
        imgCount = 5;

    }

    //蓝冠
    if (grade>=10001 && grade<=20000) {
        imgCount = 1;
    }else if (grade >= 20001 && grade <= 50000) {
        imgCount = 2;

    }else if (grade >= 50001 && grade <= 100000) {
        imgCount = 3;

    }else if (grade >= 100001 && grade <= 200000) {
        imgCount = 4;

    }else if (grade >= 200001 && grade <= 500000) {
        imgCount = 5;

    }

    //黄冠
    if (grade>=500001 && grade<=1000000) {
        imgCount = 1;
    }else if (grade >= 1000001 && grade <= 2000000) {
        imgCount = 2;

    }else if (grade >= 2000001 && grade <= 5000000) {
        imgCount = 3;

    }else if (grade >= 5000001 && grade <= 10000000) {
        imgCount = 4;

    }else if (grade >= 10000001) {
        imgCount = 5;

    }
    
    [self setGradeImageWithMyCount:imgCount];


}




-(void)setGradeImageWithMyCount:(int)myCount{
    CGFloat w = 0.0;
    for (int i = 0; i < myCount; i++) {
        UIImageView *gradeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(w*i+5, 0, 15, 13)];
        gradeImageView.image = [UIImage imageNamed:_imgName];
        w = 18;
        [self addSubview:gradeImageView];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
