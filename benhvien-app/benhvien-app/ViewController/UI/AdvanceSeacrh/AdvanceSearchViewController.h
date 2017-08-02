//
//  AdvanceSearchViewController.h
//  benhvien-app
//
//  Created by 507-3 on 7/28/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "BaseViewController.h"
#import "IQDropDownTextField.h"

@interface AdvanceSearchViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *cityContainerView;
@property (weak, nonatomic) IBOutlet UIView *districtContainerView;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *cityTextField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *districtTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end
