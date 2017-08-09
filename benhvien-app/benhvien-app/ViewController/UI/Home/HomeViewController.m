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
    NSString *hospitalName = self.searchTextField.text;
    [self validateHospitalName:hospitalName completion:^(BOOL isValidate, NSString *message){
        if (isValidate) {
            [self searchHospital:hospitalName];
        }else {
            [self showMessage:message];
        }
    }];
}

- (void)searchHospital:(NSString *)hostpitalName {
    [self showHUD];
    [ApiRequest searchHospitalByName:hostpitalName completionBlock:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
    }];
}

- (void)validateHospitalName:(NSString *)name completion:(void (^)(BOOL isValidate, NSString *message))completion {
    if (!name || name.length == 0) {
        completion(NO, @"Bạn phải nhập tên bệnh viện");
        return;
    }
    completion(YES, @"");
}

- (IBAction)advanceSearchButtonPressed:(id)sender {
    AdvanceSearchViewController *vc = (AdvanceSearchViewController *)[AdvanceSearchViewController instanceFromStoryboardName:@"Home"];
    [self.navigationController pushViewController:vc animated:true];
}

@end
