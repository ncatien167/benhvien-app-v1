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
    self.title = @"Tìm kiếm nâng cao";
}

- (void)setUpUserInterface{
    [self showBackButton];
    //setup city container view
    self.cityContainerView.layer.cornerRadius = 4.0;
    self.cityContainerView.layer.borderWidth = 0.5;
    self.cityContainerView.layer.borderColor = [UIColor colorWithHex:0xC8C7CC].CGColor;
    //setup district container view
    self.districtContainerView.layer.cornerRadius = 4.0;
    self.districtContainerView.layer.borderWidth = 0.5;
    self.districtContainerView.layer.borderColor = [UIColor colorWithHex:0xC8C7CC].CGColor;
    //setup search button
    self.searchButton.layer.cornerRadius = 4.0;
    self.districtTextField.delegate = self;
    self.cityTextField.delegate = self;
    //load data
    citiesArray = [self readCitiesFromFile];
    [self setupDistrictDropDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)readCitiesFromFile {
    NSMutableArray *cities = [NSMutableArray new];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
    NSString *myJson = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [myJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *cityArray = [jsonDict objectForKey:@"cities"];
    for (NSDictionary *cityData in cityArray) {
        City *city = [City initWithData:cityData];
        [cities addObject:city];
    }
    return cities;
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

- (IBAction)searchPressed:(id)sender {
    SearchResultViewController *vc = (SearchResultViewController *)[SearchResultViewController instanceFromStoryboardName:@"Home"];
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

@end
