//
//  JMWXShareAction.m
//  JMian
//
//  Created by mac on 2020/2/19.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMWXShareAction.h"
#import "WXApi.h"
@implementation JMWXShareAction

#pragma mark -- 微信分享的是链接
+ (void)wxShare:(int)n title:(NSString *)title desc:(NSString *)desc imageUrl:(NSString *)ImageUrl shareUrl:(NSString *)shareUrl
{   //检测是否安装微信
    
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = title;
    urlMessage.description = desc;
    UIImage *image = [self handleImageWithURLStr:ImageUrl];
    NSData *thumbData = UIImageJPEGRepresentation(image, 0.1);
    [urlMessage setThumbData:thumbData];
    //分享实例
    WXWebpageObject *webObj = [WXWebpageObject object];
 
    webObj.webpageUrl = shareUrl;
    
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    //发送分享
    [WXApi sendReq:sendReq];
    
}

+ (UIImage *)handleImageWithURLStr:(NSString *)imageURLStr {
    NSURL *url = [NSURL URLWithString:imageURLStr];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    NSData *newImageData = imageData;
    // 压缩图片data大小
    newImageData = UIImageJPEGRepresentation([UIImage imageWithData:newImageData scale:0.1], 0.1f);
    UIImage *image = [UIImage imageWithData:newImageData];
    
    // 压缩图片分辨率(因为data压缩到一定程度后，如果图片分辨率不缩小的话还是不行)
    CGSize newSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,(NSInteger)newSize.width, (NSInteger)newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
