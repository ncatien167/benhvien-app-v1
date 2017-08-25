//
//  HospitalDirectionViewController.h
//  benhvien-app
//
//  Created by AnhTien on 8/24/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "BaseViewController.h"
#import "Hospital.h"
#import <GoogleMaps/GoogleMaps.h>

@interface HospitalDirectionViewController : BaseViewController
    
@property (strong, nonatomic) Hospital *hospital;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end
