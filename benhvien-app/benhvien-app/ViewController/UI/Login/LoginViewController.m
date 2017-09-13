//
//  LoginViewController.m
//  benhvien-app
//
//  Created by 507-3 on 9/6/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "AppInfoViewController.h"
#import "AppDelegate.h"
#import "ForgetPasswordViewController.h"
#import "PlacesViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"places: %@",self.places);
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
    if (!username || username.length == 0) {
        completion(NO, @"Bạn phải nhập họ tên");
        return;
    }
    
    if (!email || email.length == 0) {
        completion(NO, @"Bạn phải nhập email");
        return;
    }
    
    if (!password || password.length == 0) {
        completion(NO, @"Bạn phải nhập mật khẩu");
        return;
    }
    
    if (!city || city.length == 0) {
        completion(NO, @"Bạn phải nhập thành phố/thủ đô");
        return;
    }
    
    if (password.length <= 6) {
        completion(NO, @"Mật khẩu có ít nhất 6 kí tự");
        return;
    }
    completion(YES, @"");
}

- (void)validateSignInWithEmail:(NSString *)email
                        password:(NSString *)password
                      completion:(void (^)(BOOL isValidate, NSString *message))completion {
    if (!email || email.length == 0) {
        completion(NO, @"Bạn phải nhập email");
        return;
    }
    
    if (!password || password.length == 0) {
        completion(NO, @"Bạn phải nhập mật khẩu");
        return;
    }
    
    if (!password || password.length < 6) {
        completion(NO, @"Mật khẩu phải có it nhất 7 kí tự");
        return;
    }
    completion(YES, @"");
}

- (void)registerAccountWithEmail:(NSString *)email
                              password:(NSString *)password
                           city:(NSString *)city
                               fullname:(NSString *)fullname {
    [self showHUD];
    [ApiRequest registerUser:email password:password city:city fullName:fullname completion:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
    }];
}

- (void)signInWithEmail:(NSString *)email password:(NSString *)password {
    [self showHUD];
    [ApiRequest loginWithEmail:email password:password completionBlock:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        if (error || !response.sucsess) {
            [self showAlertWithTitle:@"lỗi" message:response.message];
        } else {
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app setupHomeScreen];
        }
    }];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [UIAlertController showAlertInViewController:self
                                       withTitle:@"Xác nhận"
                                         message:@"Bạn có chắc chắn muốn huỷ bỏ?"
                               cancelButtonTitle:@"Cancel"
                          destructiveButtonTitle:@"YES"
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                            if (buttonIndex == controller.cancelButtonIndex) {
                                                
                                            } else if (buttonIndex == controller.destructiveButtonIndex) {
                                                [self.navigationController dismissViewControllerAnimated:true completion:nil];
                                            } else if (buttonIndex >= controller.firstOtherButtonIndex) {
                                                
                                            }
                                        }];
}

- (IBAction)doneButtonPressed:(id)sender {
    if (self.signInUpSegment.selectedSegmentIndex == 0) {
        [self validateSignInWithEmail:self.enterUsernameTextField.text password:self.enterPasswordTextField.text completion:^(BOOL isValidate, NSString *message) {
            if (isValidate) {
                [self signInWithEmail:self.enterUsernameTextField.text password:self.enterPasswordTextField.text];
            } else {
                [self showAlertWithTitle:@"Lỗi" message:message];
            }
        }];
    } else {
        [self validateRegisterUserName:self.usernameTextField.text email:self.emailTextField.text password:self.passwordTextField.text city:self.cityTextField.text completion:^(BOOL isValidate, NSString *message) {
            if (isValidate) {
                [self registerAccountWithEmail:self.emailTextField.text password:self.passwordTextField.text city:self.cityTextField.text fullname:self.usernameTextField.text];
            } else {
                [self showAlertWithTitle:@"Lỗi" message:message];
            }
        }];
    }
}

- (IBAction)segmentPressed:(UISegmentedControl *)sender {
    if (self.signInUpSegment.selectedSegmentIndex == 0) {
        self.title = @"Đăng nhập";
        self.signUpContentView.hidden = true;
        self.signInContentView.hidden = false;
    } else {
        self.title = @"Đăng kí";
        self.signInContentView.hidden = true;
        self.signUpContentView.hidden = false;
    }
}

- (IBAction)goToForgetPasswordScreen:(id)sender {
    ForgetPasswordViewController *forgetPasswordVc = (ForgetPasswordViewController *)[ForgetPasswordViewController instanceFromStoryboardName:@"Login"];
    BaseNavigationController *forgetNva = [[BaseNavigationController alloc] initWithRootViewController:forgetPasswordVc];
    [self presentViewController:forgetNva animated:true completion:nil];
}

- (IBAction)goToPlacesViewController:(id)sender {
    PlacesViewController *placesViewController = (PlacesViewController *)[PlacesViewController instanceFromStoryboardName:@"Login"];
    BaseNavigationController *placesNav = [[BaseNavigationController alloc] initWithRootViewController:placesViewController];
    [self presentViewController:placesNav animated:true completion:nil];
}

@end
