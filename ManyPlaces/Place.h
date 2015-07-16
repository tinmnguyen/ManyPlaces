//
//  Place.h
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/15/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Place : NSObject

// Name of POI
@property(nonatomic,copy) NSString *name;

// User rating of POI
@property(nonatomic) float rating;

// Coordinates of POI
@property(nonatomic) float latitude;
@property(nonatomic) float longitude;

// Google Maps place ID
@property(nonatomic,copy) NSString *placeId;

// Computed location from coordinates
@property(nonatomic,readonly) CLLocation *location;

// Convenience init. Takes in individual results from GMS
- (instancetype)initWithJSON:(NSDictionary *)values;

@end

