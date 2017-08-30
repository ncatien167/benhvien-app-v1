//
//  MenuView.m
//  benhvien-app
//
//  Created by 507-3 on 8/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "MenuView.h"
#import "MenuViewCell.h"


@interface MenuView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MenuView

- (void)setupMenuView {
    self.menuTableView.scrollEnabled = false;
    self.menuItems = [NSArray new];
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    self.menuTableView.estimatedRowHeight = 60.0;
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuViewCell" bundle:nil] forCellReuseIdentifier:@"MenuViewCell"];
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.onDidSelectedItemIndex) {
        self.onDidSelectedItemIndex(indexPath.row);
    }
}

@end
