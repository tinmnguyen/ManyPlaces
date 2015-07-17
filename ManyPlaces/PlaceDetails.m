//
//  PlaceDetails.m
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/16/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import "PlaceDetails.h"
#import <Motis/Motis.h>

@implementation PlaceDetails

- (instancetype)initWithJSON:(NSDictionary *)values {
    
    if (self = [super init]) {
        [self mts_setValuesForKeysWithDictionary:values];
    }
    
    return self;
}

+ (NSDictionary *)mts_mapping
{
    return @{
             @"name":mts_key(name),
             @"formatted_address":mts_key(address),
             @"formatted_phone_number":mts_key(phoneNumber),
             @"url":mts_key(googleUrl),
             @"website":mts_key(website),
             @"icon":mts_key(iconUrl)
             };
}

@end
