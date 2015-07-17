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

- (instancetype)initWithJSON:(NSDictionary *)values;

@end
