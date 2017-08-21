//
//  HospitalNameCell.h
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTableViewCell.h"

@interface HospitalNameCell : HLTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *NameLable;

- (void)configureCell:(id)model;

@end
