//
//  HospitalSlideShowModel.h
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HospitalSlideShowModel : NSObject

+ (instancetype)initWithData:(NSDictionary*)hospital;
- (void)parseData:(NSDictionary*)data;

@end
