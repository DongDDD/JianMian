//
//  JMProductSpecicationConfigures.h
//  JMian
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMProductSpefiColorCollectionViewCell.h"
#import "JMProductColorData.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,  JMProductSpecicationSectionType){
    JMProductSpecicationSectionTypeColor = 0 ,
    JMProductSpecicationSectionTypeSize,
    JMProductSpecicationSectionTypeStock,
};
@interface JMProductSpecicationConfigures : NSObject
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat footerheight;

@property (assign, nonatomic) NSInteger rowsNum;
@property (assign, nonatomic) NSInteger section;
@property (copy, nonatomic) NSString *cellId;
@property (strong, nonatomic) NSArray *colorDataArr;



- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (UIView *)headerViewInSection:(NSInteger)section;

- (CGFloat)heightForRowsInSection:(NSInteger)section;

- (NSString *)cellIdForSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
