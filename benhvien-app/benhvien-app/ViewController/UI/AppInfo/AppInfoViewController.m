//
//  AppInfoViewController.m
//  benhvien-app
//
//  Created by 507-3 on 8/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "AppInfoViewController.h"

@interface AppInfoViewController ()

@end

@implementation AppInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AppInfo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    [self showMenuButton];
}

- (void)showMenuButton {
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonPressed:)];
    self.navigationItem.leftBarButtonItem = menuButton;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BaseTapBarController *tab = (BaseTapBarController *)self.tabBarController;
    if (tab.menuDisplayed) {
        [tab animatedMenu:!tab.menuDisplayed];
    }
}

- (IBAction)menuButtonPressed:(id)sender {
    BaseTapBarController *tab = (BaseTapBarController *)self.tabBarController;
    [tab animatedMenu:!tab.menuDisplayed];
}

@end
