//
//  HospitalDirectionViewController.m
//  benhvien-app
//
//  Created by AnhTien on 8/24/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "HospitalDirectionViewController.h"
#import <OCGoogleDirectionsAPI/OCGoogleDirectionsAPI.h>

@interface HospitalDirectionViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentLocation;
}

@end

@implementation HospitalDirectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.hospital.name);
}
    
- (void)viewWillAppear:(BOOL)animated {
    [self getCurrentLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
- (void)setUpUserInterface {
    self.title = self.hospital.name;
    [self showBackButton];
}

- (void)getCurrentLocation {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager .desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}
    
- (void)drawDirectionWithOriginLocation:(CLLocation *)origin destinationLocation:(CLLocation *)destination {
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:origin andDestinationLocation:destination];
    OCDirectionsAPIClient *client = [OCDirectionsAPIClient new];
    [client directions:request response:^(OCDirectionsResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                return;
            }
            if (response.status != OCDirectionsResponseStatusOK) {
                return;
            }
            NSArray *routesArray = response.routes;
            GMSPolyline *polyline = nil;
            if (routesArray.count > 0) {
                OCDirectionsRoute *route = [response route];
                OCDirectionsPolyline *overViewPolyline = route.overviewPolyline;
                NSString *points = overViewPolyline.points;
                GMSPath *path = [GMSPath pathFromEncodedPath:points];
                polyline = [GMSPolyline polylineWithPath:path];
            }
            if (polyline) {
                polyline.map = self.mapView;
                
                GMSMarker *marker1 = [[GMSMarker alloc] init];
                marker1.position = CLLocationCoordinate2DMake(self.hospital.latitude, self.hospital.longitude);
                marker1.title = @"My location";
                marker1.appearAnimation = kGMSMarkerAnimationPop;
                marker1.map = self.mapView;
            }
        });
    }];
}
    
#pragma mark - CLLocationManagerDelegate
    
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    currentLocation = locations.lastObject.coordinate;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentLocation zoom:17];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = true;
    self.mapView.settings.myLocationButton = true;
    
    GMSMarker *marker = [GMSMarker markerWithPosition:currentLocation];
    marker.title = @"My location";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = self.mapView;
    
    marker.map=_mapView;
    [locationManager stopUpdatingLocation];
    [self drawDirectionWithOriginLocation:[[CLLocation alloc] initWithLatitude:currentLocation.latitude longitude:currentLocation.longitude] destinationLocation:[[CLLocation alloc] initWithLatitude:self.hospital.latitude longitude:self.hospital.longitude]];
}
    
@end
