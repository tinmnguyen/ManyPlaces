//
//  DetailCollectionViewCell.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/20/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "DetailCollectionViewCell.h"
#import "PlaceDetailViewController.h"

@implementation DetailCollectionViewCell

- (void)setDetailViewController:(PlaceDetailViewController *)detailViewController
{
    [_detailViewController.view removeFromSuperview];
    
    _detailViewController = detailViewController;
    
    detailViewController.view.frame = self.contentView.frame;
    [self.contentView addSubview:detailViewController.view];
}

@end
