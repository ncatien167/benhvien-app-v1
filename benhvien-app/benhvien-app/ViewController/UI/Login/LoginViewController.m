//
//  LoginViewController.m
//  benhvien-app
//
//  Created by 507-3 on 9/6/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    self.title = @"Đăng nhập";
    NSDictionary *buttonAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Xong" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed:)];
    [doneButton setTitleTextAttributes:buttonAtt forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Huỷ bỏ" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonPressed:)];
    [cancelButton setTitleTextAttributes:buttonAtt forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)validateRegisterUserName:(NSString *)username
                           email:(NSString *)email
                        password:(NSString *)password
                            city:(NSString *)city
                      completion:(void (^)(BOOL isValidate, NSString *message))completion {
    if ((!username || username.length == 0) && (!email || email.length == 0) &&
        (!password || password.length == 0) && (!city || city.length == 0)) {
        completion(NO, @"Bạn phải nhập đầy đủ thông tin");
    }
    completion(YES, @"");
}

- (void)registerAccountWithUserName:(NSString *)username
                              email:(NSString *)email
                           password:(NSString *)password
                               city:(NSString *)city {
    [self showHUD];
    [ApiRequest registerUser:email password:password city:city fullName:username completion:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        
    }];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender {
    if (self.signInUpSegment.selectedSegmentIndex == 0) {
        self.signUpContentView.hidden = true;
    }else {
        self.signInContentView.hidden = true;
        [self validateRegisterUserName:self.usernameTextField.text email:self.emailTextField.text password:self.passwordTextField.text city:self.cityTextField.text completion:^(BOOL isValidate, NSString *message) {
            if (isValidate) {
                [self registerAccountWithUserName:self.usernameTextField.text email:self.emailTextField.text password:self.passwordTextField.text city:self.cityTextField.text];
            }else {
                [self showAlertWithTitle:@"Lỗi" message:message];
            }
        }];
    }
}

- (IBAction)segmentPressed:(UISegmentedControl *)sender {
    if (self.signInUpSegment.selectedSegmentIndex == 0) {
        self.title = @"Đăng nhập";
    }else {
        self.title = @"Đăng kí";
    }
}
@end
