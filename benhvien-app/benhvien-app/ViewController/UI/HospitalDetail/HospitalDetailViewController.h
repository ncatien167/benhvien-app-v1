//
//  HospitalDetailViewController.h
//  benhvien-app
//
//  Created by 507-3 on 7/31/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "BaseViewController.h"
#import "Hospital.h"
#import "HLTableView.h"

@interface HospitalDetailViewController : BaseViewController

@property (strong, nonatomic) NSMutableArray *hostpitalArray;
@property (strong, nonatomic) Hospital *hospital;
@property(strong, nonatomic) IBOutlet HLTableView *tableView;

@end
