//
//  HospitalTableViewCell.h
//  benhvien-app
//
//  Created by 507-3 on 7/31/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Hospital.h"
@interface HospitalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *hospitalNameLable;
@property (weak, nonatomic) IBOutlet UILabel *hospitalAddressLable;
@property (weak, nonatomic) IBOutlet UILabel *hospitalPhoneLable;
@property (weak, nonatomic) IBOutlet UIImageView *hospitalImage;

-(void)setDataForCell:(id)data;

@end
