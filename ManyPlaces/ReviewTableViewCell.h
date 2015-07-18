//
//  ReviewTableViewCell.h
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/17/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewTableViewCell : UITableViewCell

+ (CGFloat)heightOfCellFor:(NSString *)text withWidth:(CGFloat)width;

- (void)setData:(NSDictionary *)jsonData;

@end
