//
//  PlaceDetails.h
//  ManyPlaces
//
//  Created by Tin Nguyen on 7/16/15.
//  Copyright (c) 2015 Tin Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceDetails : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *googleUrl;
@property (nonatomic,copy) NSString *website;
@property (nonatomic,copy) NSString *iconUrl;
@property (nonatomic,strong) NSMutableArray *reviews;

// Convenience init. Takes in JSON object from google
- (instancetype)initWithJSON:(NSDictionary *)values;

// Returns address with newline between street and city address
- (NSString *)getStreetAddress;

// Returns phone number as URL in form of tel://0000000000
- (NSURL *)getPhoneUrl;

@end
