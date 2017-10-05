//
//  AdvanceSearchViewController.m
//  benhvien-app
//
//  Created by 507-3 on 7/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "AdvanceSearchViewController.h"
#import "SearchResultViewController.h"
#import "City.h"

@interface AdvanceSearchViewController ()<IQDropDownTextFieldDelegate>
{
    NSMutableArray *citiesArray;
}
@end

@implementation AdvanceSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AdvanceSearch;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    self.districtTextField.delegate = self;
    self.cityTextField.delegate = self;

    [self getHospitalFromServer];
}

- (void)getHospitalFromServer {
    [self showHUD];
    [ApiRequest getHospitalWithCompletion:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        if (error) {
            [self showAlertWithTitle:@"Lỗi" message:error.localizedDescription];
        }else {
            NSMutableArray *cities = [NSMutableArray new];
            NSArray *cityArray = [response.data objectForKey:@"cities"];
            for (NSDictionary *cityData in cityArray) {
                City *city = [City initWithData:cityData];
                [cities addObject:city];
            }
            citiesArray = cities;
            [self setupDistrictDropDown];
        }
    }];
}

- (NSArray *)getCityNames {
    NSMutableArray *districtNames = [NSMutableArray new];
    for (City *city in citiesArray) {
        [districtNames addObject:city.name];
    }
    return [districtNames mutableCopy];
}

- (NSArray *)getDistrictNamesFromCity:(City *)city {
    NSMutableArray *districtNames = [NSMutableArray new];
    [districtNames addObjectsFromArray:city.district];
    [districtNames insertObject:@"Tất cả Quận/Huyện" atIndex:0];
    return [districtNames mutableCopy];
}

- (void)setupDistrictDropDown {
    self.cityTextField.isOptionalDropDown = NO;
    [self.cityTextField setItemList:[self getCityNames]];
    City *selectedCity = (City *)citiesArray[0];
    self.districtTextField.isOptionalDropDown = NO;
    [self.districtTextField setItemList:[self getDistrictNamesFromCity:selectedCity]];
    [self.districtTextField setSelectedRow:0];
}

- (void)searchHospitalWithCity:(NSString *)hospitalCity {
    [self showHUD];
    [ApiRequest getHospitalWithHospitalCity:hospitalCity page:1 completion:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        if (error) {
            [self showAlertWithTitle:@"Lỗi" message:error.localizedDescription];
        }else {
            NSMutableArray *hospitals = [NSMutableArray new];
            NSInteger pages = [[response.data valueForKey:@"pages"] integerValue];
            NSArray *hospitalArray = [response.data objectForKey:@"hospitals"];
            for (NSDictionary *hospitalData in hospitalArray) {
                Hospital *hospital = [Hospital initWithRespone:hospitalData];
                [hospitals addObject:hospital];
            }
            self.hospitalCitiesArray = hospitals;
            [self goToSearchResultViewController:CITY city:hospitalCity district:nil pages:pages];
        }
    }];
}

- (void)searchHospitalWithCity:(NSString *)hospitalCity hospitalDistrict:(NSString *)hostpitalDistrict {
    [self showHUD];
    [ApiRequest getHospitalWithHospitalCity:hospitalCity hospitalDistrict:hostpitalDistrict page:1 completion:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        if (error) {
            [self showAlertWithTitle:@"Lỗi" message:error.localizedDescription];
        }else {
            NSMutableArray *hospitals = [NSMutableArray new];
            NSInteger pages = [[response.data valueForKey:@"pages"] integerValue];
            NSArray *hospitalArray = [response.data objectForKey:@"hospitals"];
            for (NSDictionary *hospitalData in hospitalArray) {
                Hospital *hospital = [Hospital initWithRespone:hospitalData];
                [hospitals addObject:hospital];
            }
            self.hospitalCitiesArray = hospitals;
            [self goToSearchResultViewController:DISTRICT city:hospitalCity district:hostpitalDistrict pages:pages];
        }
    }];
}

- (void)goToSearchResultViewController:(SearchType)type city:(NSString *)city district:(NSString *)district pages:(NSInteger)pages {
    SearchResultViewController *vc = (SearchResultViewController *)[SearchResultViewController instanceFromStoryboardName:@"Home"];
    vc.hospitals = self.hospitalCitiesArray;
    vc.type = type;
    vc.city = city;
    vc.district = district;
    vc.totalPage = pages;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)textField:(IQDropDownTextField *)textField didSelectItem:(NSString *)item {
    NSInteger selectedIndex = textField.selectedRow;
    if(textField == self.cityTextField) {
        City *city = citiesArray[selectedIndex];
        [self.districtTextField setItemList:[self getDistrictNamesFromCity:city]];
        [self.districtTextField setSelectedRow:0];
    }
}

- (IBAction)searchPressed:(id)sender {
    NSString *hospitalCity = self.cityTextField.selectedItem;
    NSString *hospitalDistrict = self.districtTextField.selectedItem;
    if ([hospitalDistrict isEqualToString:@"Tất cả Quận/Huyện"]) {
        [self searchHospitalWithCity:hospitalCity];
    }else {
        [self searchHospitalWithCity:hospitalCity hospitalDistrict:hospitalDistrict];
    }
}

@end
