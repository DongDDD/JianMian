//
//  Demo3ViewController.h
//  照片选择器
//
//  Created by 洪欣 on 17/2/17.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JMCompanyInfoModel.h"

typedef enum : NSUInteger {
    Demo3ViewCompanyInfoEdit,
    Demo3ViewPartTimeResumeEdit,
    Demo3ViewPartTimeResumeAdd,
    Demo3ViewPostGoodsPositionAdd,
    Demo3ViewPostGoodsPositionEdit
} Demo3ViewType;


@protocol Demo3ViewControllerDelegate <NSObject>

-(void)sendArray_addImageUrls:(NSMutableArray *)addImageUrls;
-(void)deletePartTimeJobResumeImageWithIndex:(NSInteger)index;
-(void)deleteSalePositionImageWithIndex:(NSInteger)index;
-(void)deleteCompanyImageWithIndex:(NSInteger)index;
-(void)sendAddImgs:(NSMutableArray *)Imgs;
@end

@interface Demo3ViewController : BaseViewController;

@property (nonatomic, strong) NSMutableArray *image_paths;//根据图片数组布局
@property (nonatomic, strong) NSMutableArray *filesModelArray;//用来提取图片的数组
@property (nonatomic, strong)JMFilesModel *filesModel;
@property (nonatomic, weak)id<Demo3ViewControllerDelegate>delegate;
@property (nonatomic, assign)Demo3ViewType viewType;

@property (nonatomic, copy)NSString *company_id;//任务主键
@property (nonatomic, copy)NSString *ability_id;//兼职简历主键
@property (nonatomic, copy)NSString *task_id;//任务主键

@end
