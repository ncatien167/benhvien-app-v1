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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    [self showBackButton];
    self.title = self.hospital.name;
}

@end
