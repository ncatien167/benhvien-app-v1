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
    self.menuItems = [NSArray new];
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    self.menuTableView.estimatedRowHeight = 60.0;
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuViewCell" bundle:nil] forCellReuseIdentifier:@"MenuViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuViewCell *cell = (MenuViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuViewCell"];
    if (!cell) {
        cell = [[MenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuViewCell"];
    }
    return cell;
}

@end
