//
//  HomeViewController.h
//  benhvien-app
//
//  Created by 507-3 on 7/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *advanceSearchButton;
@property (strong, nonatomic) NSMutableArray *hospitalDatas;


@end
