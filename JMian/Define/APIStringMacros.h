//
//  APIStringMacros.h
//  JMian
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 mac. All rights reserved.
//

#ifndef APIStringMacros_h
#define APIStringMacros_h

#ifdef DEBUG
//Debug状态下的测试API
#define API_BASE_URL_STRING     @"http://app.jmzhipin.com/"

#else
//Release状态下的线上API
#define API_BASE_URL_STRING     @"http://www.companydomain.com/api/"

#endif

#define Login_URL @"api/login"
#define User_info_URL @"api/user/info"
#define Update_info_URL @"api/user/update"
#define Position_label_URL @"labels"
//接口



#define GET_CONTENT_DETAIL      @"channel/getContentDetail" //获取内容详情(含上一个和下一个)

#define GET_COMMENT_LIST        @"comment/getCommentList"   //获取评论列表

#define COMMENT_LOGIN           @"comment/login"            //获取评论列表

#define COMMENT_PUBLISH         @"comment/publish"          //发布评论

#define COMMENT_DELETE          @"comment/delComment"       //删除评论

#define LOGINOUT                @"common/logout"            //登出


#endif /* APIStringMacros_h */
