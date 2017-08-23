//
//  HospitalDetailViewController.m
//  benhvien-app
//
//  Created by 507-3 on 7/31/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HospitalDetailViewController.h"
#import "SlideShowCell.h"
#import "HospitalNameCell.h"
#import "HospitalPhoneCell.h"
#import "HospitalAddressCell.h"
#import "HospitalLocationCell.h"
#import "HospitalDescriptionCell.h"
#import "HospitalNameModel.h"
#import "HospitalPhoneModel.h"
#import "HospitalAddressModel.h"
#import "HospitalLocationModel.h"
#import "HospitalSlideShowModel.h"
#import "HospitalDescriptionModel.h"

@interface HospitalDetailViewController ()

@end

@implementation HospitalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHospitalInfoWithId:self.hospital.hospitalId];
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUserInterface {
    [self showBackButton];
    self.title = self.hospital.name;
    self.tableView.estimatedRowHeight = 140.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerCell:[SlideShowCell class] forModel:[HospitalSlideShowModel class]];
    [self.tableView registerCell:[HospitalNameCell class] forModel:[HospitalNameModel class]];
    [self.tableView registerCell:[HospitalPhoneCell class] forModel:[HospitalPhoneModel class]];
    [self.tableView registerCell:[HospitalAddressCell class] forModel:[HospitalAddressModel class]];
    [self.tableView registerCell:[HospitalDescriptionCell class] forModel:[HospitalDescriptionModel class]];
    [self.tableView registerCell:[HospitalLocationCell class] forModel:[HospitalLocationModel class]];
}

- (void)setupCellData:(Hospital *)hospital {
    NSMutableArray *objArray = [NSMutableArray new];
    HospitalSlideShowModel *slideShow = [HospitalSlideShowModel new];
    slideShow.images = hospital.images;
    [objArray addObject:slideShow];
    
    HospitalNameModel *name = [HospitalNameModel new];
    name.name = hospital.name;
    [objArray addObject:name];
    
    HospitalPhoneModel *phone = [HospitalPhoneModel new];
    phone.phone = hospital.phones;
    [objArray addObject:phone];
    
    HospitalAddressModel *address = [HospitalAddressModel new];
    address.address = hospital.street;
    [objArray addObject:address];
    
    HospitalDescriptionModel *descriptionModel = [HospitalDescriptionModel new];
    descriptionModel.descriptionModel = hospital.hospitalDescription;
    [objArray addObject:descriptionModel];
    
    HospitalLocationModel *location = [HospitalLocationModel new];
    [objArray addObject:location];
    [self.tableView addItems:objArray];
}

- (void)getHospitalInfoWithId:(NSString *)_id {
    [ApiRequest getHospitalInfoWithId:_id completion:^(ApiResponse *response, NSError *error) {
        if (error) {
            [self showAlertWithTitle:@"Loi" message:error.localizedDescription];
        }else {
            NSDictionary *hospitalData = [response.data objectForKey:@"hospitalInfo"];
            Hospital *hospital = [Hospital initWithRespone:hospitalData];
            [self setupCellData:hospital];
        }
    }];
}

@end
