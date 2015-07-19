//
//  ReviewTableViewCell.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/17/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "ReviewTableViewCell.h"
#import <HCSStarRatingView/HCSStarRatingView.h>
#import <Motis/Motis.h>

@interface ReviewTableViewCell ()

@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UILabel *reviewLabel;
@property (nonatomic,weak) IBOutlet HCSStarRatingView *ratingsView;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *review;
@property (nonatomic) float rating;

@end

@implementation ReviewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)heightOfCellFor:(NSString *)text withWidth:(CGFloat)width
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(width - 16.0, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0]}
                                     context:nil].size;
    
    return size.height + 40.0;
}

- (void)setData:(NSDictionary *)jsonData
{
    [self mts_setValuesForKeysWithDictionary:jsonData];
    
    self.nameLabel.text     = self.name;
    self.reviewLabel.text   = self.review;
    self.ratingsView.value  = self.rating;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSDictionary *)mts_mapping
{
    return @{
             @"author_name":mts_key(name),
             @"rating":mts_key(rating),
             @"text":mts_key(review)
             };
}

@end
