//
//  HospitalLocationCell.h
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTableViewCell.h"
#import "HospitalLocationModel.h"
#import <GoogleMaps/GoogleMaps.h>

@interface HospitalLocationCell : HLTableViewCell

@property (weak, nonatomic) IBOutlet GMSMapView *locationView;

@end
