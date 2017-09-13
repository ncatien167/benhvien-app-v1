//
//  FirstLoginViewController.m
//  benhvien-app
//
//  Created by 507-3 on 9/6/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "FirstLoginViewController.h"
#import "LoginViewController.h"

@interface FirstLoginViewController ()

@end

@implementation FirstLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)emailButtonPressed:(id)sender {
    LoginViewController *loginViewController = (LoginViewController *)[LoginViewController instanceFromStoryboardName:@"Login"];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginViewController];
    [self presentViewController:nav animated:true completion:nil];
}

- (IBAction)facebookButtonPressed:(id)sender {
    
}

@end
