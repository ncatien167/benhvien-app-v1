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
{
    BaseTapBarController *tab;
}

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelAfterLogin) name:@"isClosing" object:nil];
}

- (void)handelAfterLogin{
    self.overrideView.hidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    self.title = Account;
    self.overrideView.hidden = true;
    tab = (BaseTapBarController *)self.tabBarController;
    [self showMenuButton];
    
    self.fullNameLable.text = [UserDataManager shareClient].fullname;
    self.emailLable.text    = [UserDataManager shareClient].email;
    self.cityLable.text     = [UserDataManager shareClient].city;
}

- (void)closeMenu {
    if (tab.menuDisplayed) {
        self.overrideView.hidden = false;
    } else {
        self.overrideView.hidden = true;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BaseTapBarController *tab = (BaseTapBarController *)self.tabBarController;
    if (tab.menuDisplayed) {
        [tab animatedMenu:!tab.menuDisplayed];
        self.overrideView.hidden = true;
    }
}

- (IBAction)menuButtonPressed:(id)sender {
    BaseTapBarController *tab = (BaseTapBarController *)self.tabBarController;
    [tab animatedMenu:!tab.menuDisplayed];
    [self closeMenu];
}

- (IBAction)changePasswordPressed:(id)sender {
    ChangePasswordViewController *changePasswordViewController = (ChangePasswordViewController *)[ChangePasswordViewController instanceFromStoryboardName:@"Login"];
    BaseNavigationController *changePasswordNav = [[BaseNavigationController alloc] initWithRootViewController:changePasswordViewController];
    [self presentViewController:changePasswordNav animated:true completion:nil];
}

@end
