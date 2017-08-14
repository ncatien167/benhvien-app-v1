//
//  BaseViewController.h
//  BenhVien
//
//  Created by 507-3 on 7/24/17.
//  Copyright © 2017 AnhTien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Storyboard.h"
#import "UIColor+Hex.h"
#import "UIAlertController+Blocks.h"
#import "ApiRequest.h"
#import "Hospital.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BaseViewController : UIViewController

- (void)showMenuButton;
- (void)showBackButton;
- (void)showHUD;
- (void)hideHUD;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
