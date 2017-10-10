//
//  MenuView.h
//  benhvien-app
//
//  Created by 507-3 on 8/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView

@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (strong, nonatomic) NSArray *menuItems;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property void (^onDidSelectedItemIndex)(NSInteger index);
@property void (^onDidSelectedButtonAccount)();

- (void)setupMenuView;

@end
