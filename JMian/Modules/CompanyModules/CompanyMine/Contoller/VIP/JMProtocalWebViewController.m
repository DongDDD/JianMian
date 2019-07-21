//
//  JMProtocalWebViewController.m
//  JMian
//
//  Created by mac on 2019/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMProtocalWebViewController.h"
#import "JMHTTPManager+FectchProtocalInfo.h"

@interface JMProtocalWebViewController ()

@end

@implementation JMProtocalWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHTMLPath:@"SecondModulesHTML/B/Cost.html"];

    // Do any additional setup after loading the view from its nib.
    if (_viewType == JMProtocalWebDidPay) {
        [self getData];
    } 
}


-(void)getData{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    [[JMHTTPManager sharedInstance]fectchProtocalInfo_user_id:userModel.user_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSDictionary *dic = responsObject[@"data"];
            if (dic) {
                [self ocToJs_dicData:dic];
                
            }
            
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}


- (void)ocToJs_dicData:(NSDictionary *)dicData{
    //OC调用JS
    NSString *json;
    if (dicData) {
        json = [self dicToJSONWithDic:dicData];
    }
    
    NSString *showInfoFromJava = [NSString stringWithFormat:@"showInfoFromJava('%@')",json];
    [self.webView evaluateJavaScript:showInfoFromJava completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        //显示对话框
        
        //延迟
        NSLog(@"OC调用JS方法 showInfoFromJava ");
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
