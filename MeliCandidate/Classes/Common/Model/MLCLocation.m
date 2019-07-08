//
//  MLCLocation.m
//  MeliCandidate
//  Created by Martha Patricia Castillo Fuentes on 7/7/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCLocation.h"


@implementation MLCLocation


#pragma mark - Initialization

-(nullable instancetype)initWithAddress:(nonnull NSString*)address city:(NSString*)city {
    self = [super init];
    if (self) {
        // <#initializations#>
        self.address = address;
        self.city = city;
    }
    return self;

    
}


-(nullable instancetype)init {
    self = [self initWithAddress:@"" city:@""];
    return self;
    
}


#pragma mark - Equality

-(BOOL)isEqualToLocation:(MLCLocation*)otherLocation {
    return ((([self.address isEqualToString:otherLocation.address]) && ([self.city isEqualToString:otherLocation.city])));
}

- (BOOL)isEqual:(id)otherLocation {
    BOOL isEqual = NO;
    if (otherLocation == self) {
        isEqual = YES;
    }
    else {
        if (![otherLocation isKindOfClass:[self class]]) {
            
            isEqual = NO;
        }
        else {
            isEqual = [self isEqualToLocation:(MLCLocation*)otherLocation];
            
        }
        
    }
    return isEqual;
}


- (NSUInteger) hash {
    return ([self.address hash] ^  [self.city hash]);
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.address = [decoder decodeObjectForKey:NSStringFromSelector(@selector(address))];
        self.neighborhood = [decoder decodeObjectForKey:NSStringFromSelector(@selector(neighborhood))];
        self.city = [decoder decodeObjectForKey:NSStringFromSelector(@selector(city))];
        self.state = [decoder decodeObjectForKey:NSStringFromSelector(@selector(state))];
        self.country = [decoder decodeObjectForKey:NSStringFromSelector(@selector(country))];
        self.zipCode = [decoder decodeObjectForKey:NSStringFromSelector(@selector(zipCode))];
        self.locationCoordinates = [decoder decodeObjectForKey:NSStringFromSelector(@selector(locationCoordinates))];

    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.address forKey:NSStringFromSelector(@selector(address))];
    [encoder encodeObject:self.neighborhood forKey:NSStringFromSelector(@selector(neighborhood))];
    [encoder encodeObject:self.city forKey:NSStringFromSelector(@selector(city))];
    [encoder encodeObject:self.state forKey:NSStringFromSelector(@selector(state))];
    [encoder encodeObject:self.country forKey:NSStringFromSelector(@selector(country))];
    [encoder encodeObject:self.zipCode forKey:NSStringFromSelector(@selector(zipCode))];
    [encoder encodeObject:self.locationCoordinates forKey:NSStringFromSelector(@selector(locationCoordinates))];

}

@end
