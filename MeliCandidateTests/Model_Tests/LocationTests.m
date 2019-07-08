//
//  LocationTests.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLCLocation.h"


@interface LocationTests : XCTestCase

@property(nonatomic, strong) NSString* address;
@property(nonatomic, strong) NSString* address1;
@property(nonatomic, strong) NSString* city;
@property(nonatomic, strong) NSString* city1;
@property(nonatomic, strong) MLCLocation* location;

@end

@implementation LocationTests

- (void)setUp {
    [super setUp];
    self.address = @"Location id";
    self.address1 = @"Location id 1";
    self.city = @"Nick";
    self.city1 = @"Nick 1";
    self.location = [[MLCLocation alloc] initWithAddress:self.address city:self.city];
    
}

- (void)tearDown {
    [super tearDown];
    self.location = nil;
}

- (void)testEqualityWhenEqualLocations {
    MLCLocation* otherLocation = [[MLCLocation alloc] initWithAddress:self.address city:self.city];
    
    BOOL equality = [self.location isEqualToLocation:otherLocation];
    
    XCTAssertTrue(equality, @"Couldn't recognize equal locations");
    
}

- (void)testEqualityWhenDifferentLocations {
    MLCLocation* otherLocation = [[MLCLocation alloc] initWithAddress:self.address1 city:self.city1];
    
    BOOL equality = [self.location isEqualToLocation:otherLocation];
    
    XCTAssertFalse(equality, @"Couldn't recognize different locations");
    
}

- (void)testEqualityWhenOtherIsNil {
    MLCLocation* otherLocation = nil;
    
    BOOL equality = [self.location isEqualToLocation:otherLocation];
    
    XCTAssertFalse(equality, @"Couldn't recognize not equal to nil");
    
}

@end
