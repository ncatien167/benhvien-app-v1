//
//  HospitalDetailViewController.m
//  benhvien-app
//
//  Created by 507-3 on 7/31/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HospitalDetailViewController.h"
#import "HospitalDirectionViewController.h"
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

- (void)showDirectionButton {
    UIBarButtonItem *goToDirection = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"direction-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(goToHospitalDirection)];
    self.navigationItem.rightBarButtonItem = goToDirection;
}

- (void)goToHospitalDirection {
    HospitalDirectionViewController *direction = (HospitalDirectionViewController *)[HospitalDirectionViewController instanceFromStoryboardName:@"Home"];
    direction.hospital = self.hospital;
    [self.navigationController pushViewController:direction animated:true];
}

- (void)setUpUserInterface {
    [self showBackButton];
    self.title = self.hospital.name;
    self.tableView.estimatedRowHeight = 140.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerCell:[SlideShowCell class] forModel:[HospitalSlideShowModel class]];
    [self.tableView registerCell:[HospitalNameCell class] forModel:[HospitalNameModel class]];
    [self.tableView registerCell:[HospitalAddressCell class] forModel:[HospitalAddressModel class]];
    [self.tableView registerCell:[HospitalPhoneCell class] forModel:[HospitalPhoneModel class]];
    [self.tableView registerCell:[HospitalDescriptionCell class] forModel:[HospitalDescriptionModel class]];
    [self.tableView registerCell:[HospitalLocationCell class] forModel:[HospitalLocationModel class]];
    self.tableView.hidden = true;
    [self showDirectionButton];
}

- (void)setupCellData:(Hospital *)hospital {
    NSMutableArray *objArray = [NSMutableArray new];
    HospitalSlideShowModel *slideShow = [HospitalSlideShowModel new];
    slideShow.images = hospital.images;
    [objArray addObject:slideShow];
    
    HospitalNameModel *name = [HospitalNameModel new];
    name.name = hospital.name;
    [objArray addObject:name];
    
    HospitalAddressModel *address = [HospitalAddressModel new];
    address.address = hospital.street;
    [objArray addObject:address];
    
    HospitalPhoneModel *phone = [HospitalPhoneModel new];
    phone.phone = hospital.phones;
    [objArray addObject:phone];
    
    HospitalDescriptionModel *descriptionModel = [HospitalDescriptionModel new];
    descriptionModel.descriptionModel = hospital.hospitalDescription;
    [objArray addObject:descriptionModel];
    
    HospitalLocationModel *location = [HospitalLocationModel new];
    location.latitude = hospital.latitude;
    location.longitude = hospital.longitude;
    location.name = hospital.name;
    [objArray addObject:location];
    
    [self.tableView addItems:objArray];
}

- (void)getHospitalInfoWithId:(NSString *)_id {
    self.tableView.hidden = false;
    [ApiRequest getHospitalInfoWithId:_id completion:^(ApiResponse *response, NSError *error) {
        if (error) {
            [self showAlertWithTitle:@"Loi" message:error.localizedDescription];
        }else {
            NSDictionary *hospitalData = [response.data objectForKey:@"hospitalInfo"];
            self.hospital = [Hospital initWithRespone:hospitalData];
            [self setupCellData:self.hospital];
        }
    }];
}

@end
