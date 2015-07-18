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

- (NSString *)getStreetAddress
{
    NSArray *strings    = [self.address componentsSeparatedByString:@","];
    NSRange range       = [self.address rangeOfString:@", "];
    NSRange newRange    = NSMakeRange(range.location + 2, (self.address.length - range.location) - 2);
    
    // Check case where there is no city or country
    if (range.location > self.address.length) {
        return strings[0];
    }
    
    return [NSString stringWithFormat:@"%@\n%@",strings[0],[self.address substringWithRange:newRange]];
}

- (NSURL *)getPhoneUrl {
    
    NSString *phoneString = [[self.phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        
    return [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneString]];
}

+ (NSDictionary *)mts_mapping
{
    return @{
             @"name":mts_key(name),
             @"formatted_address":mts_key(address),
             @"formatted_phone_number":mts_key(phoneNumber),
             @"url":mts_key(googleUrl),
             @"website":mts_key(website),
             @"icon":mts_key(iconUrl),
             @"reviews":mts_key(reviews)
             };
}

@end
