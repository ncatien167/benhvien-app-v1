//
//  SlideShowCell.m
//  benhvien-app
//
//  Created by 507-3 on 8/18/17.
//  Copyright © 2017 anhtien167. All rights reserved.
//

#import "SlideShowCell.h"
#import "HospitalSlideShowModel.h"

@interface SlideShowCell()<KASlideShowDataSource, KASlideShowDelegate>
{
    NSMutableArray * _datasource;
}

@end

@implementation SlideShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(id)model {
    HospitalSlideShowModel *thumbModel = (HospitalSlideShowModel *)model;
    if (thumbModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupSlideShow:thumbModel.images];
        });
    }
}

- (void)setupSlideShow:(NSArray *)images {
    _datasource = [NSMutableArray new];
    for (NSString *url in images) {
        [_datasource addObject:[NSURL URLWithString:url]];
    }
    _slideshow.datasource = self;
    _slideshow.delegate = self;
    [_slideshow setDelay:2];
    [_slideshow setTransitionDuration:0.5];
    [_slideshow setTransitionType:KASlideShowTransitionSlideHorizontal];
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill];
    [_slideshow addGesture:KASlideShowGestureTap];
    [_slideshow start];
}

#pragma mark - KASlideShow datasource

- (NSObject *)slideShow:(KASlideShow *)slideShow objectAtIndex:(NSUInteger)index
{
    return _datasource[index];
}

- (NSUInteger)slideShowImagesNumber:(KASlideShow *)slideShow
{
    return _datasource.count;
}

@end
