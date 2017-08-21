//
//  HospitalDescriptionCell.m
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HospitalDescriptionCell.h"
#import "HospitalDescriptionModel.h"

@implementation HospitalDescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(id)model {
    HospitalDescriptionModel *hospital = (HospitalDescriptionModel *)model;
    if (hospital) {
        self.imformationLable.text = hospital.description;
    }
}

@end
