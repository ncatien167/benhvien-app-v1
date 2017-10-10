//
//  MenuView.m
//  benhvien-app
//
//  Created by 507-3 on 8/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "MenuView.h"
#import "MenuViewCell.h"
#import "UserDataManager.h"
#import "AccountViewController.h"
#import "ButtonBackgroundColor-Swift.h"

@interface MenuView() <UITableViewDelegate, UITableViewDataSource>
{
    BOOL *_isSelected;
}
@end

@implementation MenuView

- (void)setupMenuView {
    self.menuTableView.backgroundColor = [UIColor clearColor];
    self.menuTableView.scrollEnabled = false;
    self.menuItems = [NSArray new];
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    self.menuTableView.estimatedRowHeight = 60.0;
    self.menuTableView.rowHeight = UITableViewAutomaticDimension;
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuViewCell" bundle:nil] forCellReuseIdentifier:@"MenuViewCell"];
    self.menuTableView.tableFooterView = [UIView new];
    self.userNameLable.text = [UserDataManager shareClient].fullname;
    [self.accountButton bbc_backgroundColorNormal:[UIColor clearColor]
                       backgroundColorHighlighted:[UIColor colorWithRed:(232/255.0) green:(67/255.0) blue:(70/255.0) alpha:1]];
}

- (void)setMenuItems:(NSArray *)menuItems {
    _menuItems = menuItems;
    [self.menuTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuViewCell *cell = (MenuViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuViewCell"];
    if (!cell) {
        cell = [[MenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuViewCell"];
    }
    NSDictionary *item = self.menuItems[indexPath.row];
    NSString *imageName = [item objectForKey:@"icon"];
    NSString *title = [item objectForKey:@"title"];
    cell.imageViewIcon.image = [UIImage imageNamed:imageName];
    cell.titleLable.text = title;
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectionColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuViewCell *cell = (MenuViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor colorWithRed:(232/255.0) green:(67/255.0) blue:(70/255.0) alpha:1] ForCell:cell];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuViewCell *cell = (MenuViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor clearColor] ForCell:cell];
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.onDidSelectedItemIndex) {
        self.onDidSelectedItemIndex(indexPath.row + 1);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
    }
    
}

- (IBAction)goToAccountViewController:(id)sender {
    if (self.onDidSelectedButtonAccount) {
        self.onDidSelectedButtonAccount();
    }
}

@end
