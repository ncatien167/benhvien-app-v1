//
//  SearchResultViewController.m
//  benhvien-app
//
//  Created by 507-3 on 7/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "SearchResultViewController.h"
#import "HospitalDetailViewController.h"
#import "Hospital.h"
#import "HospitalTableViewCell.h"

@interface SearchResultViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Kết quả";
    self.hospitals = [NSMutableArray new];
    Hospital *hospital1 = [Hospital new];
    hospital1.hospitalName = @"Bệnh viện chấn thương chỉnh hình Tp Hồ Chí minh";
    hospital1.address = @"629 Trần hưng đạo phường 1";
    hospital1.phoneNumber = @"08-30251642";
    
    [self.hospitals addObject:hospital1];
    [self.hospitals addObject:hospital1];
    [self.hospitals addObject:hospital1];
    [self.hospitals addObject:hospital1];
    [self.hospitals addObject:hospital1];
    [self.hospitals addObject:hospital1];
    [self.hospitals addObject:hospital1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    [self showBackButton];
    self.resultTableView.estimatedRowHeight = 91.0;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hospitals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    HospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if(cell == nil){
        cell = [[HospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    Hospital *hos = self.hospitals[indexPath.row];
    cell.hospitalNameLable.text = hos.hospitalName;
    cell.hospitalAddressLable.text = hos.address;
    cell.hospitalPhoneLable.text = hos.phoneNumber;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    Hospital *hospital = self.hospitals[indexPath.row];
    [self gotoHospitalDetailsSrceen:hospital];
}

- (void)gotoHospitalDetailsSrceen:(Hospital *)hospital {
    HospitalDetailViewController *vc = (HospitalDetailViewController *)[HospitalDetailViewController instanceFromStoryboardName:@"Home"];
    vc.hospital = hospital;
    [self.navigationController pushViewController:vc animated:true];
}

@end
