//
//  BaseTapBarController.m
//  BenhVien
//
//  Created by 507-3 on 7/24/17.
//  Copyright © 2017 AnhTien. All rights reserved.
//

#import "BaseTapBarController.h"
#import "MenuView.h"

@interface BaseTapBarController ()

@property (strong, nonatomic) MenuView *menuView;

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
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"MenuView" owner:self options:nil];
    self.menuView = (MenuView *)[nibViews objectAtIndex:0];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.menuView];
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

@end
