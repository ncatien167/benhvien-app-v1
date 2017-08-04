//
//  HomeViewController.m
//  benhvien-app
//
//  Created by 507-3 on 7/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HomeViewController.h"
#import "AdvanceSearchViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tim kiem";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setUpUserInterface {
    //setup search text field
    self.searchTextField.layer.cornerRadius = 4.0;
    self.searchTextField.layer.borderWidth = 0.5;
    self.searchTextField.layer.borderColor = [UIColor colorWithHex:0xC8C7CC].CGColor;
    //setup search button
    self.searchButton.layer.cornerRadius = 4.0;
    //setup advance search button
    self.advanceSearchButton.layer.cornerRadius = 4.0;
    [self showMenuButton];
}

- (IBAction)searchButtonPressed:(id)sender {
    [self showHUD];
    [ApiRequest loginWithEmail:@"haole@gmail.com" password:@"111111" completionBlock:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
    }];
}

- (IBAction)advanceSearchButtonPressed:(id)sender {
    AdvanceSearchViewController *vc = (AdvanceSearchViewController *)[AdvanceSearchViewController instanceFromStoryboardName:@"Home"];
    [self.navigationController pushViewController:vc animated:true];
}

@end
