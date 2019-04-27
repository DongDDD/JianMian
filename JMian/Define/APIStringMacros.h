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
//身份切换
#define User_Change @"api/user/change"

//C端接口
#define Login_URL @"api/login"
//发送验证码
#define Login_Captcha_URL @"sms/captcha"

#define User_info_URL @"api/user/info"
#define Update_info_URL @"api/user/update"
#define Position_label_URL @"labels"

//上传图片
#define Uploads_Image_URL @"file/uploads"
//身份证识别
#define Ocr_idcard_URL @"api/tools/ocr/idcard"


//个人简历
#define Create_Vita_URL @"api/vita/create"
#define Update_Vita_URL @"api/vita/update"

//简历分页
#define Paginate_Vita_URL @"api/vita/paginate"

//简历详情
#define Info_Vita_URL @"api/vita/info"

//岗位
#define Update_job_URL @"api/user/job/update"

//工作经历
#define Create_Experience_URL @"api/user/experience/create"
#define Update_Experience_URL @"api/user/experience/update"
#define Delete_Experience_URL @"api/user/experience/delete"

//教育经历
#define Create_EducationExperience_URL @"api/education/create"
#define Update_EducationExperience_URL @"api/education/update"
#define Delete_EducationExperience_URL @"api/education/delete"

#define Paginate_Work_URL @"api/work/paginate"
#define Create_Work_URL @"api/work/create"
#define Info_Work_URL @"api/work/info"


//B端接口
#define Create_Company_URL @"api/company/create"
#define Fectch_CompanyInfo_URL @"api/company/info"
#define Paginate_Vita_URL @"api/vita/paginate"
#define List_Interview_URL @"api/work/interview/lists"





//接口


#define GET_CONTENT_DETAIL      @"channel/getContentDetail" //获取内容详情(含上一个和下一个)

#define GET_COMMENT_LIST        @"comment/getCommentList"   //获取评论列表

#define COMMENT_LOGIN           @"comment/login"            //获取评论列表

#define COMMENT_PUBLISH         @"comment/publish"          //发布评论

#define COMMENT_DELETE          @"comment/delComment"       //删除评论

#define LOGINOUT                @"common/logout"            //登出


#endif /* APIStringMacros_h */
