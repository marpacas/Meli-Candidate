//
//  ItemTests.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLCItem.h"

@interface ItemTests : XCTestCase

@property(nonatomic, strong) NSString* identification;
@property(nonatomic, strong) NSString* identification1;
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* title1;
@property(nonatomic, strong) NSString* condition;
@property(nonatomic, strong) NSString* condition1;
@property(nonatomic, strong) MLCSeller* seller;
@property(nonatomic, strong) MLCItem* item;

@end

@implementation ItemTests

- (void)setUp {
    [super setUp];
    self.identification = @"MLID";
    self.identification1 = @"MLID1";
    self.title = @"Title";
    self.title1 = @"Title 1";
    self.condition = @"Condition";
    self.condition1 = @"Condition 1";
    self.seller = [[MLCSeller alloc] initWithIdentification:@"ID Seller" nickName:@"Nick Seller"];
    self.item = [[MLCItem alloc] initWithIdentification:self.identification title:self.title condition:self.condition seller:self.seller];

}

- (void)tearDown {
    [super tearDown];
    self.item = nil;
}

- (void)testEqualityWhenEqualItems {
    MLCItem* otherItem = [[MLCItem alloc] initWithIdentification:self.identification title:self.title condition:self.condition seller:self.seller];
    
    BOOL equality = [self.item isEqualToItem:otherItem];
    
    XCTAssertTrue(equality, @"Couldn't recognize equal items");
    
}

- (void)testEqualityWhenDifferentItems {
    MLCItem* otherItem = [[MLCItem alloc] initWithIdentification:self.identification1 title:self.title1 condition:self.condition1 seller:self.seller];
    
    BOOL equality = [self.item isEqualToItem:otherItem];
    
    XCTAssertFalse(equality, @"Couldn't recognize different items");
    
}

- (void)testEqualityWhenOtherIsNil {
    MLCItem* otherItem = nil;
    
    BOOL equality = [self.item isEqualToItem:otherItem];
    
    XCTAssertFalse(equality, @"Couldn't recognize not equal to nil");
    
}


@end
