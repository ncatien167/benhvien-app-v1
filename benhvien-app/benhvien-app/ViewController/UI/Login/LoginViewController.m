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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    self.title = SignIn;
    [self showCancelButton];
    
    NSDictionary *buttonAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Xong" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed:)];
    [doneButton setTitleTextAttributes:buttonAtt forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = doneButton;
}

#pragma mark - Register

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

    if (password.length < 6) {
        completion(NO, @"Mật khẩu có ít nhất 6 kí tự");
        return;
    }
    
    if (!city || city.length == 0) {
        completion(NO, @"Bạn phải nhập thành phố");
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
        if (error || !response.sucsess) {
            [self showAlertWithTitle:@"lỗi" message:response.message];
        } else {
            [[UserDataManager shareClient] setUserData:response.data];
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app setupHomeScreen];
        }
    }];
}

- (void)registerAccountWithUserName:(NSString *)name email:(NSString *)email password:(NSString *)password city:(NSString *)city {
    [self validateRegisterUserName:name email:email password:password city:city completion:^(BOOL isValidate, NSString *message) {
        if (isValidate) {
            [self registerAccountWithEmail:name password:password city:city fullname:name];
        } else {
            [self showAlertWithTitle:@"Lỗi" message:message];
        }
    }];
}

#pragma mark - Login

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

- (void)signInWithEmail:(NSString *)email password:(NSString *)password {
    [self showHUD];
    [ApiRequest loginWithEmail:email password:password completionBlock:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        if (error || !response.sucsess) {
            [self showAlertWithTitle:@"lỗi" message:response.message];
        } else {
            [[UserDataManager shareClient] setUserData:response.data];
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app setupHomeScreen];
        }
    }];
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password {
    [self validateSignInWithEmail:email password:password completion:^(BOOL isValidate, NSString *message) {
        if (isValidate) {
            [self signInWithEmail:email password:password];
        } else {
            [self showAlertWithTitle:@"Lỗi" message:message];
        }
    }];
}

- (IBAction)doneButtonPressed:(id)sender {
    NSString *email = self.enterUsernameTextField.text;
    NSString *password = self.enterPasswordTextField.text;
    NSString *userName = self.usernameTextField.text;
    NSString *city = self.cityTextField.text;
    NSString *registerPassword = self.passwordTextField.text;
    NSString *registerEmail = self.emailTextField.text;
    if (self.signInUpSegment.selectedSegmentIndex == 0) {
        [self registerAccountWithEmail:registerEmail password:registerPassword city:city fullname:userName];
    } else {
        [self loginWithEmail:email password:password];
    }
}

#pragma mark - Action Login View Controller

- (IBAction)segmentPressed:(UISegmentedControl *)sender {
    if (self.signInUpSegment.selectedSegmentIndex == 0) {
        self.title = SignIn;
        self.signUpContentView.hidden = false;
        self.signInContentView.hidden = true;
    } else {
        self.title = RegisterView;
        self.signInContentView.hidden = false;
        self.signUpContentView.hidden = true;
    }
}

- (IBAction)goToForgetPasswordScreen:(id)sender {
    ForgetPasswordViewController *forgetPasswordVc = (ForgetPasswordViewController *)[ForgetPasswordViewController instanceFromStoryboardName:@"Login"];
    BaseNavigationController *forgetNva = [[BaseNavigationController alloc] initWithRootViewController:forgetPasswordVc];
    [self presentViewController:forgetNva animated:true completion:nil];
}

- (IBAction)goToPlacesViewController:(id)sender {
    PlacesViewController *placesViewController = (PlacesViewController *)[PlacesViewController instanceFromStoryboardName:@"Login"];
    [placesViewController setOnGetPlacesCity:^(NSString *city, UIViewController *viewController) {
        [viewController dismissViewControllerAnimated:true completion:nil];
        self.cityTextField.text = city;
    }];
    BaseNavigationController *placesNav = [[BaseNavigationController alloc] initWithRootViewController:placesViewController];
    [self presentViewController:placesNav animated:true completion:nil];
}

@end
