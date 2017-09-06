//
//  AppDelegate.m
//  benhvien-app
//
//  Created by 507-3 on 7/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "FirstLoginViewController.h"
#import "UIViewController+Storyboard.h"
#import "AppInfoViewController.h"
#import "BaseNavigationController.h"
#import "BaseTapBarController.h"
#import <OCGoogleDirectionsAPI/OCGoogleDirectionsAPI.h>
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupApplicationTheme];
    [self setupFirstLoginScreen];
    [GMSServices provideAPIKey:GoogleApiKey];
    [OCDirectionsAPIClient provideAPIKey:GoogleApiKey];
    return YES;
}

- (void)setupFirstLoginScreen {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    FirstLoginViewController *firstLoginViewController = (FirstLoginViewController *)[FirstLoginViewController instanceFromStoryboardName:@"Login"];
    self.window.rootViewController = firstLoginViewController;
    [self.window makeKeyAndVisible];
}

- (void)setupHomeScreen {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HomeViewController *homeViewController = (HomeViewController *)[HomeViewController instanceFromStoryboardName:@"Home"];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:homeViewController];
    
    AppInfoViewController *appInfoViewController = (AppInfoViewController *)[AppInfoViewController instanceFromStoryboardName:@"Home"];
    BaseNavigationController *appInfoNav = [[BaseNavigationController alloc] initWithRootViewController:appInfoViewController];
    
    BaseTapBarController *tab = [BaseTapBarController new];
    tab.viewControllers = @[homeNav, appInfoNav];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
}

- (void)setupApplicationTheme {
    [UINavigationBar appearance].barTintColor = [UIColor colorWithHex:0xd2232a];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    NSDictionary *titleAttr = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [UINavigationBar appearance].titleTextAttributes = titleAttr;
}

@end
