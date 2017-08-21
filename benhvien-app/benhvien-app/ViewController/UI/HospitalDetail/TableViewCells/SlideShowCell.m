//
//  SlideShowCell.m
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "SlideShowCell.h"
#import "HospitalSlideShowModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SlideShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(id)model {
    HospitalSlideShowModel *hospital = (HospitalSlideShowModel *)model;
    if (hospital) {
        [self.ImageSlideShow sd_setImageWithURL:[NSURL URLWithString:hospital.image[0]]];
    }
}

@end
