//
//  PlaceTableViewCell.h
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/17/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface PlaceTableViewCell : UITableViewCell

@property (nonatomic,strong) Place *place;

- (void)setPlace:(Place *)place;

@end
