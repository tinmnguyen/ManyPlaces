//
//  PlaceTableViewCell.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/17/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "PlaceTableViewCell.h"
#import <HCSStarRatingView/HCSStarRatingView.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface PlaceTableViewCell ()

@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet HCSStarRatingView *ratingView;
@property (nonatomic,weak) IBOutlet UIImageView *icon;
@property (nonatomic,strong) Place *currentPlace;

@end

@implementation PlaceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setPlace:(Place *)place
{
    self.currentPlace = place;
    
    self.nameLabel.text = self.currentPlace.name;
    self.ratingView.value = self.currentPlace.rating;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.currentPlace.iconUrl] placeholderImage:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
