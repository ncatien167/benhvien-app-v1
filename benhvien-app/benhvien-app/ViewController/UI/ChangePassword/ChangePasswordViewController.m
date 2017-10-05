//
//  ChangePasswordViewController.m
//  benhvien-app
//
//  Created by AnhTien on 9/11/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ForgetPasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    self.title = ChangePasswordView;
    [self showCancelButton];
    
    NSDictionary *buttonAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Xong"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(doneButtonPressed:)];
    [doneButton setTitleTextAttributes:buttonAtt forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = doneButton;
    
}

- (void)validateOldPassword:(NSString *)oldPassword
                newPassword:(NSString *)newPassword
            confrimPassword:(NSString *)confrimPassword
                 completion:(void (^)(BOOL isValidate, NSString *message))completion {
    if (!oldPassword || oldPassword.length == 0) {
        completion(NO, @"Bạn phải nhập mật khẩu củ");
        return;
    }
    
    if (!newPassword || newPassword.length == 0) {
        completion(NO, @"Bạn phải nhập mật khẩu mới");
        return;
    }
    
    if (!confrimPassword || confrimPassword.length == 0) {
        completion(NO, @"Bạn phải xác nhận mật khẩu");
        return;
    }
    
    if (newPassword.length < 6) {
        completion(NO, @"Mật khẩu có ít nhất 6 kí tự");
        return;
    }
    
    completion(YES, @"");
}

- (void)changePasswordWithUserId:(NSString *)userId oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword {
    [self showHUD];
    [ApiRequest changePasswordWithUserId:userId
                             oldPassword:oldPassword
                             newPassword:newPassword
                              completion:^(ApiResponse *response, NSError *error) {
                                  [self hideHUD];
                                  if (error) {
                                      [self showAlertWithTitle:@"lỗi" message:response.message];
                                  } else {
                                      [self.navigationController dismissViewControllerAnimated:true completion:nil];
                                  }
    }];
}

- (IBAction)doneButtonPressed:(id)sender {
    NSString *oldPassword = self.oldPasswordTextField.text;
    NSString *newPassword = self.nnewPasswordTextField.text;
    NSString *comfirmPassword = self.comfirmPasswordTextField.text;
    [self validateOldPassword:oldPassword
                  newPassword:newPassword
              confrimPassword:comfirmPassword
                   completion:^(BOOL isValidate, NSString *message) {
        if (isValidate) {
            [self changePasswordWithUserId:[UserDataManager shareClient].userId
                               oldPassword:oldPassword
                               newPassword:newPassword];
        } else {
            [self showAlertWithTitle:@"Lỗi" message:message];
        }
    }];
}

@end
