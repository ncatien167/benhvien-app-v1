//
//  MenuView.h
//  benhvien-app
//
//  Created by 507-3 on 8/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView

@property (strong, nonatomic) NSArray *menuItems;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property void (^onDidSelectedItemIndex)(NSInteger index);

- (void)setupMenuView;

@end
