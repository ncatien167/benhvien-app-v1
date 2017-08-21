//
//  HospitalPhoneCell.m
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HospitalPhoneCell.h"
#import "HospitalPhoneModel.h"

@implementation HospitalPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(id)model {
    HospitalPhoneModel *hospital = (HospitalPhoneModel *)model;
    if (hospital) {
        self.phoneLable.text = hospital.phone[0];
    }
}

@end
