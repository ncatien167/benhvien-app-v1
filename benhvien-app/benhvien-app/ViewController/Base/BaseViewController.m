//
//  BaseViewController.m
//  BenhVien
//
//  Created by 507-3 on 7/24/17.
//  Copyright © 2017 AnhTien. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUserInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showMenuButton {
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.leftBarButtonItem = menuButton;
}

- (void)showBackButton {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (IBAction)menuButtonPressed:(id)sender {
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)showHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:true];
         });
}

- (void)hideHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:true];
    });
}

@end
