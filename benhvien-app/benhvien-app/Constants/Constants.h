//
//  Constants.h
//  benhvien-app
//
//  Created by AnhTien on 9/15/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define SearchByNameView                        @"Tìm kiếm"
#define AdvanceSearch                           @"Tìm kiếm nâng cao"
#define AppInfo                                 @"Thông tin"
#define SearchResult                            @"Kết quả"
#define Account                                 @"Tài khoản"
#define SignIn                                  @"Đăng nhập"
#define RegisterView                            @"Đăng ký"
#define ForGetPassword                          @"Quên mật khẩu"
#define ChangePasswordView                      @"Đổi mật khẩu"

#define UserToken                               @"UserToken"
#define UserId                                  @"UserId"
#define UserEmai                                @"UserEmail"
#define UserRole                                @"UserRole"
#define UserCity                                @"UserCity"
#define UserFullName                            @"UserFullName"

#define MenuIsClose                             @"MenuIsClose"

typedef enum {
    DISTRICT,
    CITY,
    HOME
}SearchType;

typedef enum {
    REFRESH,
    LOADMORE
}LoadMore;

#endif /* Constants_h */
