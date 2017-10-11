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
#import "MenuView.h"

@interface HomeViewController ()
{
    BaseTapBarController *tab;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SearchByNameView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelAfterLogin) name:@"isClosing" object:nil];
}

- (void)handelAfterLogin{
    self.overrideView.hidden = true;
    self.homeView.hidden = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setUpUserInterface {
    tab = (BaseTapBarController *)self.tabBarController;
    self.overrideView.hidden = true;
    self.searchTextField.layer.cornerRadius = 4.0;
    self.searchTextField.layer.borderWidth = 0.5;
    self.searchTextField.layer.borderColor = [UIColor colorWithHex:0xC8C7CC].CGColor;
    self.searchButton.layer.cornerRadius = 4.0;
    self.advanceSearchButton.layer.cornerRadius = 4.0;
    [self showMenuButton];
}

- (void)closeMenu {
    if (tab.menuDisplayed) {
        self.overrideView.hidden = false;
        self.homeView.hidden = true;
    } else {
        self.overrideView.hidden = true;
        self.homeView.hidden = false;
    }
}

- (IBAction)menuButtonPressed:(id)sender {
    [tab animatedMenu:!tab.menuDisplayed];
    [self closeMenu];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (tab.menuDisplayed) {
        [tab animatedMenu:!tab.menuDisplayed];
        self.overrideView.hidden = true;
        self.homeView.hidden = false;
    }
}

#pragma mark - Search Hospital

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
