//
//  JMBDetailWebViewController.m
//  JMian
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBDetailWebViewController.h"
#import "JMHTTPManager+FectchAbilityInfo.h"
@interface JMBDetailWebViewController ()

@end

@implementation JMBDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兼职人才详情";
    [self setHTMLPath:@"SecondModulesHTML/B/Bdetail.html"];
    // Do any additional setup after loading the view from its nib.
}

-(void)getData{
    [[JMHTTPManager sharedInstance]fectchAbilityDetailInfo_Id:self.ability_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSDictionary *dic = responsObject[@"data"];
            [self ocToJs_dicData:dic];
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

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self getData];
    //    [self ocToJs];
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
