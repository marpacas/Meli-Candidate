//
//  SellerTests.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLCSeller.h"

@interface SellerTests : XCTestCase

@property(nonatomic, strong) NSString* identification;
@property(nonatomic, strong) NSString* identification1;
@property(nonatomic, strong) NSString* nickName;
@property(nonatomic, strong) NSString* nickName1;
@property(nonatomic, strong) MLCSeller* seller;

@end

@implementation SellerTests

- (void)setUp {
    [super setUp];
    self.identification = @"Seller id";
    self.identification1 = @"Seller id 1";
    self.nickName = @"Nick";
    self.nickName1 = @"Nick 1";
    self.seller = [[MLCSeller alloc] initWithIdentification:self.identification nickName:self.nickName];

}

- (void)tearDown {
    [super tearDown];
    self.seller = nil;
}

- (void)testEqualityWhenEqualSellers {
    MLCSeller* otherSeller = [[MLCSeller alloc] initWithIdentification:self.identification nickName:self.nickName];
    
    BOOL equality = [self.seller isEqualToSeller:otherSeller];
    
    XCTAssertTrue(equality, @"Couldn't recognize equal sellers");
    
}

- (void)testEqualityWhenDifferentSellers {
    MLCSeller* otherSeller = [[MLCSeller alloc] initWithIdentification:self.identification1 nickName:self.nickName1];
    
    BOOL equality = [self.seller isEqualToSeller:otherSeller];
    
    XCTAssertFalse(equality, @"Couldn't recognize different sellers");
    
}

- (void)testEqualityWhenOtherIsNil {
    MLCSeller* otherSeller = nil;
    
    BOOL equality = [self.seller isEqualToSeller:otherSeller];
    
    XCTAssertFalse(equality, @"Couldn't recognize not equal to nil");
    
}


@end
