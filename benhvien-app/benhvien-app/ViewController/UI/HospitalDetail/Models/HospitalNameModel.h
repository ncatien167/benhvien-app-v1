//
//  HospitalNameModel.h
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hospital.h"

@interface HospitalNameModel : NSObject

@property (strong, nonatomic) NSString *name;
-(void)setDataForCell:(NSString *)name;

@end
