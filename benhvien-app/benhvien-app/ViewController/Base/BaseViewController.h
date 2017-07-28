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

@interface BaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *searchTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *advanceSearchButton;

- (void)showMenuButton;
- (void)showBackButton;
@end
