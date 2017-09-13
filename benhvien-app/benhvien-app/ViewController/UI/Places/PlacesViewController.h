//
//  PlacesViewController.h
//  benhvien-app
//
//  Created by AnhTien on 9/11/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "BaseViewController.h"
#import <HNKGooglePlacesAutocomplete/HNKGooglePlacesAutocomplete.h>

@interface PlacesViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (nonatomic, strong) NSString *(^GetPlaces)(void);

@end
