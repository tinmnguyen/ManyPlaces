//
//  Place.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/15/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "Place.h"
#import <Motis/Motis.h>

@implementation Place

- (instancetype)initWithJSON:(NSDictionary *)values {
    
    if (self = [super init]) {
        [self mts_setValuesForKeysWithDictionary:values];
    }
    
    return self;
}

- (CLLocationCoordinate2D)location {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

// For Motis JSON to NSObject mapping
+ (NSDictionary *)mts_mapping {
    
    return @{
        @"name": mts_key(name),
        @"place_id": mts_key(placeId),
        @"rating": mts_key(rating),
        @"geometry.location.lat": mts_key(latitude),
        @"geometry.location.lng": mts_key(longitude),
        @"icon": mts_key(iconUrl)
        };
}

@end
