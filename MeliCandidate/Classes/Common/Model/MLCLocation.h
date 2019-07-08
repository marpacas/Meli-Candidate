//
//  MLCLocation.h
//  MeliCandidate
//  Created by Martha Patricia Castillo Fuentes on 7/7/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 A MLCLocation object stores the location of an item or seller
 */

@interface MLCLocation : NSObject <NSCoding>

@property (nonatomic,strong,nonnull) NSString* address;
@property (nonatomic,strong,nullable) NSString* neighborhood;
@property (nonatomic,strong,nonnull) NSString* city;
@property (nonatomic,strong,nullable) NSString* state;
@property (nonatomic,strong,nullable) NSString* country;
@property (nonatomic,strong,nullable) NSString* zipCode;
@property (nonatomic,strong,nullable) CLLocation* locationCoordinates;


-(nullable instancetype)initWithAddress:(nonnull NSString*)address city:(nonnull NSString*)city;


-(BOOL)isEqualToLocation:(nullable MLCLocation*)otherLocation;

@end
