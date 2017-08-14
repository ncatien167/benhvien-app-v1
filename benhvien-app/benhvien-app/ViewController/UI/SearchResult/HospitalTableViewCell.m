//
//  HospitalTableViewCell.m
//  benhvien-app
//
//  Created by 507-3 on 7/31/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HospitalTableViewCell.h"

@implementation HospitalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setDataForCell:(id)data {
    Hospital *hospital = (Hospital *)data;
    if (hospital) {
        [self.hospitalImage sd_setImageWithURL:[NSURL URLWithString:hospital.avatar]];
        self.hospitalNameLable.text = hospital.name;
        if (hospital.phones[0]) {
            self.hospitalPhoneLable.text = [NSString stringWithFormat:@"Điện thoại: %@",hospital.phones[0]];
        }else {
            self.hospitalPhoneLable.text = [NSString stringWithFormat:@"Điện thoại: -"];
        }
        self.hospitalAddressLable.text = [NSString stringWithFormat:@"Địa chỉ: %@",hospital.street];
    }
}

@end
