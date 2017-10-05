//
//  BaseTapBarController.m
//  BenhVien
//
//  Created by 507-3 on 7/24/17.
//  Copyright © 2017 AnhTien. All rights reserved.
//

#import "BaseTapBarController.h"
#import "MenuView.h"
#import <PureLayout/PureLayout.h>
#import "AppDelegate.h"
#import "UserDataManager.h"
#import "BaseViewController.h"

@interface BaseTapBarController ()

@property (strong, nonatomic) MenuView *menuView;
@property (strong, nonatomic) UIWindow *window;


@end

@implementation BaseTapBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMenuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupMenuView {
    [self.tabBar setHidden:YES];
    NSArray *menuItems = @[@{@"title":@"Tìm kiếm",  @"icon":@"search-menu-icon"},
                           @{@"title":@"Thông tin", @"icon":@"information-menu-icon"},
                           @{@"title":@"Đăng xuất", @"icon":@"logout-icon"}];
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"MenuView" owner:self options:nil];
    self.menuView = (MenuView *)[nibViews objectAtIndex:0];
    self.window = [[[UIApplication sharedApplication] delegate] window];
    [self.menuView setupMenuView];
    self.menuView.menuItems = menuItems;
    [self.window addSubview:self.menuView];
    
    __weak BaseTapBarController *Self = self;
    [self.menuView setOnDidSelectedItemIndex:^(NSInteger index) {
        [Self didSelectedMenuAtIndex:index];
    }];
    
    [self.menuView setOnDidSelectedButtonAccount:^{
        [Self didSelectedMenuAtIndex:0];
    }];
}

- (void)updateViewConstraints {
    [self.menuView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.window];
    [self.menuView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.window];
    [self.menuView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.window];
    [self.menuView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.window];
    [super updateViewConstraints];
}

- (void)animatedMenu:(BOOL)display {
    self.menuDisplayed = display;
    CGFloat duration = 0.3;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat positionX = (300.0/375.0) * screenWidth;
    CGRect frame = self.view.frame;
    if (display) {
        frame.origin.x = positionX;
    }else {
        frame.origin.x = 0.0;
    }
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}

- (void)didSelectedMenuAtIndex:(NSInteger)menuIndex {
    [self animatedMenu:!self.menuDisplayed];
    self.selectedIndex = menuIndex;
    if (menuIndex == 3) {
        [UIAlertController showAlertInViewController:self
                                           withTitle:@"Xác nhận"
                                             message:@"Bạn có chắc chắn muốn huỷ bỏ?"
                                   cancelButtonTitle:@"Cancel"
                              destructiveButtonTitle:@"YES"
                                   otherButtonTitles:nil
                                            tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                                if (buttonIndex == controller.cancelButtonIndex) {
                                                    
                                                } else if (buttonIndex == controller.destructiveButtonIndex) {
                                                    [self logOut];
                                                } else if (buttonIndex >= controller.firstOtherButtonIndex) {
                                                    
                                                }
                                            }];
    }
}

- (void)logOut {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[UserDataManager shareClient] clearUserData];
    [app setupFirstLoginScreen];
}


@end
