//
//  SearchResultViewController.h
//  benhvien-app
//
//  Created by 507-3 on 7/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchResultViewController : BaseViewController

@property (strong, nonatomic) NSMutableArray *hospitals;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;

@end
