//
//  HomeViewController.m
//  benhvien-app
//
//  Created by 507-3 on 7/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HomeViewController.h"
#import "AdvanceSearchViewController.h"
#import "SearchResultViewController.h"
#import "BaseTapBarController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SearchByNameView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setUpUserInterface {
    self.searchTextField.layer.cornerRadius = 4.0;
    self.searchTextField.layer.borderWidth = 0.5;
    self.searchTextField.layer.borderColor = [UIColor colorWithHex:0xC8C7CC].CGColor;
    self.searchButton.layer.cornerRadius = 4.0;
    self.advanceSearchButton.layer.cornerRadius = 4.0;
    [self showMenuButton];
}

- (void)searchHospital:(NSString *)hostpitalName {
    [self showHUD];
    [ApiRequest searchHospitalByName:hostpitalName completionBlock:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        if (error) {
            [self showAlertWithTitle:@"Lỗi" message:error.description];
        } else {
            NSArray *hospitals = [response.data objectForKey:@"hospitals"];
            if (hospitals.count <= 0) {
                [self showAlertWithTitle:@"Thông báo" message:@"Không tìm thấy biện viện nào"];
            }else {
                self.hospitalDatas = [NSMutableArray new];
                for (NSDictionary *hospitalData in hospitals) {
                    Hospital *hos = [Hospital initWithRespone:hospitalData];
                    [self.hospitalDatas addObject:hos];
                }
                [self gotoSearchResultViewControllerWith:self.hospitalDatas pages:0];
            }
        }
    }];
}

- (void)gotoSearchResultViewControllerWith:(NSMutableArray *)hospitals pages:(NSInteger)page {
    SearchResultViewController *searchResultViewController = (SearchResultViewController *)[SearchResultViewController instanceFromStoryboardName:@"Home"];
    searchResultViewController.hospitals = self.hospitalDatas;
    searchResultViewController.type = HOME;
    searchResultViewController.totalPage = page;
    [self.navigationController pushViewController:searchResultViewController animated:true];
}

- (void)validateHospitalName:(NSString *)name completion:(void (^)(BOOL isValidate, NSString *message))completion {
    if (!name || name.length == 0) {
        completion(NO, @"Bạn phải nhập tên bệnh viện");
        return;
    }
    completion(YES, @"");
}

- (void)menuButtonPressed:(id)sender {
    [self.searchTextField endEditing:NO];
    [self.searchTextField setUserInteractionEnabled:NO];
    [super menuButtonPressed:self];
}

- (IBAction)advanceSearchButtonPressed:(id)sender {
    AdvanceSearchViewController *vc = (AdvanceSearchViewController *)[AdvanceSearchViewController instanceFromStoryboardName:@"Home"];
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)searchButtonPressed:(id)sender {
    NSString *hospitalName = self.searchTextField.text;
    [self validateHospitalName:hospitalName completion:^(BOOL isValidate, NSString *message){
        if (isValidate) {
            [self searchHospital:hospitalName];
        }else {
            [self showAlertWithTitle:@"Lỗi" message:message];
        }
    }];
}

@end
