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
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface SearchResultViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    self.title = SearchResult;
    self.resultTableView.tableFooterView = [UIView new];
    [self refreshAndLoadMorePage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.resultTableView reloadData];
}

- (void)setUpUserInterface {
    [self showBackButton];
    self.resultTableView.estimatedRowHeight = 91.0;
}

#pragma mark - Refresh and Load More

- (void)refreshAndLoadMorePage {
    if (self.totalPage == 0) {
        
    } else {
        [self.resultTableView addPullToRefreshWithActionHandler:^{
            if (self.type == HOME) {
                [self.resultTableView.infiniteScrollingView stopAnimating];
                return;
            }
            
            if (self.type == DISTRICT) {
                [self refreshDistrict];
            }
            
            if (self.type == CITY) {
                [self refreshCity];
            }
         }];
        
        [self.resultTableView addInfiniteScrollingWithActionHandler:^{
            if (self.type == HOME) {
                [self.resultTableView.infiniteScrollingView stopAnimating];
                return;
            }
            
            if (self.type == DISTRICT) {
                [self loadMoreDistrict];
            }
            
            if (self.type == CITY) {
                [self loadMoreCity];
            }
        }];
    }
}

- (void)refreshDistrict {
    [self searchHospitalWithCity:self.city hospitalDistrict:self.district page:1 loadMore:REFRESH];
}

- (void)refreshCity {
    [self searchHospitalWithCity:self.city page:1 loadMore:REFRESH];
}

- (void)loadMoreDistrict {
    if (self.currentPage < self.totalPage) {
        self.resultTableView.showsInfiniteScrolling = YES;
        [self searchHospitalWithCity:self.city hospitalDistrict:self.district page:self.currentPage + 1 loadMore:LOADMORE];
    } else {
        self.resultTableView.showsInfiniteScrolling = NO;
    }
}

- (void)loadMoreCity {
    if (self.currentPage < self.totalPage) {
        self.resultTableView.showsInfiniteScrolling = YES;
        [self searchHospitalWithCity:self.city page:self.currentPage+1 loadMore:LOADMORE];
    } else {
        self.resultTableView.showsInfiniteScrolling = NO;
    }
}

- (void)displayData:(NSMutableArray *)data currentPage:(NSInteger)page loadMore:(LoadMore)loadMore {
    if (loadMore == REFRESH) {
        self.currentPage = page;
        [self.hospitals removeAllObjects];
        self.hospitals = data;
        [self.resultTableView reloadData];
        [self.resultTableView.pullToRefreshView stopAnimating];
    }else {
        self.currentPage = page;
        [self.hospitals addObjectsFromArray:[data mutableCopy]];
        [self.resultTableView reloadData];
        [self.resultTableView.infiniteScrollingView stopAnimating];
    }
}

- (void)searchHospitalWithCity:(NSString *)hospitalCity page:(NSInteger)page loadMore:(LoadMore)loadMore {
    [self showHUD];
    [ApiRequest getHospitalWithHospitalCity:hospitalCity page:page completion:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        if (error) {
            [self showAlertWithTitle:@"Lỗi" message:error.localizedDescription];
        }else {
            NSMutableArray *hospitals = [NSMutableArray new];
            NSArray *hospitalArray = [response.data objectForKey:@"hospitals"];
            for (NSDictionary *hospitalData in hospitalArray) {
                Hospital *hospital = [Hospital initWithRespone:hospitalData];
                [hospitals addObject:hospital];
            }
            [self displayData:hospitals currentPage:page loadMore:loadMore];
        }
    }];
}

- (void)searchHospitalWithCity:(NSString *)hospitalCity hospitalDistrict:(NSString *)hostpitalDistrict page:(NSInteger)page loadMore:(LoadMore)loadMore {
    [self showHUD];
    [ApiRequest getHospitalWithHospitalCity:hospitalCity hospitalDistrict:hostpitalDistrict page:page completion:^(ApiResponse *response, NSError *error) {
        [self hideHUD];
        if (error) {
            [self showAlertWithTitle:@"Lỗi" message:error.localizedDescription];
        }else {
            NSMutableArray *hospitals = [NSMutableArray new];
            NSArray *hospitalArray = [response.data objectForKey:@"hospitals"];
            for (NSDictionary *hospitalData in hospitalArray) {
                Hospital *hospital = [Hospital initWithRespone:hospitalData];
                [hospitals addObject:hospital];
            }
            [self displayData:hospitals currentPage:page loadMore:loadMore];
        }
    }];
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
    Hospital *hospital = self.hospitals[indexPath.row];
    [cell setDataForCell:hospital];
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
