//
//  AdvanceSearchViewController.m
//  benhvien-app
//
//  Created by 507-3 on 7/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "AdvanceSearchViewController.h"
#import "SearchResultViewController.h"
@interface AdvanceSearchViewController ()

@end

@implementation AdvanceSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tìm kiếm nâng cao";
}

- (void)setUpUserInterface{
    [self showBackButton];
    self.cityContainerView.layer.cornerRadius = 4.0;
    self.cityContainerView.layer.borderWidth = 0.5;
    self.cityContainerView.layer.borderColor = [UIColor colorWithHex:0xC8C7CC].CGColor;
    
    self.districtContainerView.layer.cornerRadius = 4.0;
    self.districtContainerView.layer.borderWidth = 0.5;
    self.districtContainerView.layer.borderColor = [UIColor colorWithHex:0xC8C7CC].CGColor;
    
    self.searchButton.layer.cornerRadius = 4.0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)searchPressed:(id)sender {
    SearchResultViewController *vc = (SearchResultViewController *)[SearchResultViewController instanceFromStoryboardName:@"Home"];
    [self.navigationController pushViewController:vc animated:true];
}
@end
