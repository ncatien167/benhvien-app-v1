//
//  HospitalDetailViewController.m
//  benhvien-app
//
//  Created by 507-3 on 7/31/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HospitalDetailViewController.h"

@interface HospitalDetailViewController ()

@end

@implementation HospitalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHospitalInfoWithId:self.hospital.hospitalId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    [self showBackButton];
    self.title = self.hospital.name;
}

- (void)getHospitalInfoWithId:(NSString *)_id {
    [ApiRequest getHospitalInfoWithId:_id completion:^(ApiResponse *response, NSError *error) {
        if (error) {
            [self showAlertWithTitle:@"Loi" message:error.localizedDescription];
        }else {
            NSLog(@"%@",response.originalResponse);
            NSArray *hospitalInfo = [response.data objectForKey:@"hospitalInfo"];
        }
    }];
}

@end
