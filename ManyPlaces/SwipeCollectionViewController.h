//
//  SwipeCollectionViewController.h
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/20/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeCollectionViewController : UICollectionViewController

@property (nonatomic) NSInteger index;
@property (nonatomic,strong) NSArray *results;

@end
