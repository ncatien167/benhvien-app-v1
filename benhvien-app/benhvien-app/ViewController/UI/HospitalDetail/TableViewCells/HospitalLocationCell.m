//
//  HospitalLocationCell.m
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//


#import "ApiEndpoint.h"
#import "HospitalLocationCell.h"


@implementation HospitalLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(id)model {
    HospitalLocationModel *location = (HospitalLocationModel *)model;
    if (location) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setLocationHospitalWithLatitude:location.latitude longitude:location.longitude hospitalName:location.name];
        });
    }
}

- (void)setLocationHospitalWithLatitude:(double)latitude longitude:(double)longitude hospitalName:(NSString *)name {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:14];
    self.locationView.camera = camera;
    self.locationView.myLocationEnabled = YES;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.title = @"Benh Vien";
    marker.snippet = @"ABC";
    marker.map = self.locationView;
}

@end
