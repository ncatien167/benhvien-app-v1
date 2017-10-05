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
#import <HNKGooglePlacesAutocomplete/HNKGooglePlacesAutocomplete.h>
#import "UserDataManager.h"
#import "AccountViewController.h"
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupApplicationTheme];
    [self setupApplicationData];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if ([UserDataManager shareClient].accessToken &&
        [UserDataManager shareClient].accessToken.length > 0) {
        [self setupHomeScreen];
    } else {
        [self setupFirstLoginScreen];
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupApplicationData {
    [GMSServices provideAPIKey:GoogleApiKey];
    [OCDirectionsAPIClient provideAPIKey:GoogleApiKey];
    [HNKGooglePlacesAutocompleteQuery setupSharedQueryWithAPIKey:GoogleApiKey];
}

- (void)setupFirstLoginScreen {
    [self removeAllSubViews];
    FirstLoginViewController *firstLoginViewController = (FirstLoginViewController *)[FirstLoginViewController instanceFromStoryboardName:@"Login"];
    self.window.rootViewController = firstLoginViewController;
}

- (void)setupHomeScreen {
    [self removeAllSubViews];
    HomeViewController *homeViewController = (HomeViewController *)[HomeViewController instanceFromStoryboardName:@"Home"];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:homeViewController];
    
    AppInfoViewController *appInfoViewController = (AppInfoViewController *)[AppInfoViewController instanceFromStoryboardName:@"Home"];
    BaseNavigationController *appInfoNav = [[BaseNavigationController alloc] initWithRootViewController:appInfoViewController];
    
    AccountViewController *accountViewController = (AccountViewController *)[AccountViewController instanceFromStoryboardName:@"Login"];
    BaseNavigationController *accountNav = [[BaseNavigationController alloc] initWithRootViewController:accountViewController];
    
    BaseTapBarController *tab = [BaseTapBarController new];
    tab.viewControllers = @[accountNav ,homeNav, appInfoNav];
    tab.selectedIndex = 1;
    self.window.rootViewController = tab;
}

- (void)setupApplicationTheme {
    [UINavigationBar appearance].barTintColor = [UIColor colorWithHex:0xd2232a];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    NSDictionary *titleAttr = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [UINavigationBar appearance].titleTextAttributes = titleAttr;
}

- (void)removeAllSubViews {
    NSArray *subViewArray = self.window.subviews;
    for (id view in subViewArray) {
        [view removeFromSuperview];
    }
}

@end
