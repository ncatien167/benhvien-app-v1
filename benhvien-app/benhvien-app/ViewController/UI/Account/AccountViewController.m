//
//  AccountViewController.m
//  benhvien-app
//
//  Created by AnhTien on 9/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "AccountViewController.h"
#import "UserDataManager.h"
#import "ChangePasswordViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    self.title = Account;
    [self showMenuButton];
    self.fullNameLable.text = [UserDataManager shareClient].fullname;
    self.emailLable.text = [UserDataManager shareClient].email;
    self.cityLable.text = [UserDataManager shareClient].city;
}

- (IBAction)changePasswordPressed:(id)sender {
    ChangePasswordViewController *changePasswordViewController = (ChangePasswordViewController *)[ChangePasswordViewController instanceFromStoryboardName:@"Login"];
    BaseNavigationController *changePasswordNav = [[BaseNavigationController alloc] initWithRootViewController:changePasswordViewController];
    [self presentViewController:changePasswordNav animated:true completion:nil];
}

@end
