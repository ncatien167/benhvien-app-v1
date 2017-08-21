//
//  HospitalNameCell.m
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HospitalNameCell.h"
#import "HospitalNameModel.h"

@implementation HospitalNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(id)model {
    HospitalNameModel *hospital = (HospitalNameModel *)model;
    if (hospital) {
        self.NameLable.text = hospital.name;
    }
}

@end
