//
//  SearchResultViewController.h
//  benhvien-app
//
//  Created by 507-3 on 7/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchResultViewController : BaseViewController

@property (nonatomic) SearchType type;
@property (nonatomic) NSInteger totalPage;
@property (nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *district;

@property (strong, nonatomic) NSMutableArray *hospitals;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@end
