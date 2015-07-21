//
//  DetailCollectionViewCell.h
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/20/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceDetailViewController;

@interface DetailCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) PlaceDetailViewController *detailViewController;

@end
