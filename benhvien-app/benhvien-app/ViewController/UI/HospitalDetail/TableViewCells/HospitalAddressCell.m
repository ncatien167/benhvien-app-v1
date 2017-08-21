//
//  HospitalAddressCell.m
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HospitalAddressCell.h"
#import "HospitalAddressModel.h"

@implementation HospitalAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(id)model {
    HospitalAddressModel *hospital = (HospitalAddressModel *)model;
    if (hospital) {
        self.AddressLable.text = hospital.address;
    }
}

@end
