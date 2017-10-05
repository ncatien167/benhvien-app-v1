//
//  ForgetPasswordViewController.m
//  benhvien-app
//
//  Created by AnhTien on 9/11/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ChangePasswordViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    self.sendCodeButton.layer.cornerRadius = 4.0;
    self.title = ForGetPassword;
    [self showCancelButton];
    
    NSDictionary *buttonAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Xong" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed:)];
    [doneButton setTitleTextAttributes:buttonAtt forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (IBAction)doneButtonPressed:(id)sender {
    ChangePasswordViewController *changePasswordViewController = (ChangePasswordViewController *)[ChangePasswordViewController instanceFromStoryboardName:@"Login"];
    BaseNavigationController *changePasswordNav = [[BaseNavigationController alloc] initWithRootViewController:changePasswordViewController];
    [self presentViewController:changePasswordNav animated:true completion:nil];
}

- (IBAction)changePasswordPressed:(id)sender {
    ChangePasswordViewController *changePasswordViewController = (ChangePasswordViewController *)[ChangePasswordViewController instanceFromStoryboardName:@"Login"];
    BaseNavigationController *changePasswordNav = [[BaseNavigationController alloc] initWithRootViewController:changePasswordViewController];
    [self presentViewController:changePasswordNav animated:true completion:nil];
}

@end
