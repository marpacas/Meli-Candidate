//
//  FormatterTests.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLCQuantityFormatter.h"
#import "MLCPriceFormatter.h"


@interface QuantityFormatterTests : XCTestCase

@property(nonatomic, strong) MLCQuantityFormatter* quantityFormatter;

@end

@implementation QuantityFormatterTests

- (void)setUp {
    [super setUp];
    self.quantityFormatter = [[MLCQuantityFormatter alloc] init];
}

- (void)tearDown {
    [super tearDown];
    self.quantityFormatter = nil;
}



- (void)testFormatterPerformanceWhenQuantityZero {
    NSNumber*  quantity = [NSNumber numberWithLongLong:0];
    [self measureBlock:^{
        [self.quantityFormatter stringFromNumber:quantity];
    }];
}

- (void)testFormatterPerformanceWhenSmallQuantity {
    NSNumber*  quantity = [NSNumber numberWithLongLong:20];
    [self measureBlock:^{
        [self.quantityFormatter stringFromNumber:quantity];
    }];
}

- (void)testFormatterPerformanceWhenRegularQuantity {
    NSNumber*  quantity = [NSNumber numberWithLongLong:300];
    [self measureBlock:^{
        [self.quantityFormatter stringFromNumber:quantity];
    }];
}

- (void)testFormatterPerformanceWhenLargePrice {
    NSNumber*  quantity = [NSNumber numberWithLongLong:50000000];
    [self measureBlock:^{
        [self.quantityFormatter stringFromNumber:quantity];
    }];
}

@end


@interface PriceFormatterTests : XCTestCase

@property(nonatomic, strong) MLCPriceFormatter* priceFormatter;

@end

@implementation PriceFormatterTests

- (void)setUp {
    [super setUp];
    self.priceFormatter = [[MLCPriceFormatter alloc] init];
}

- (void)tearDown {
    [super tearDown];
    self.priceFormatter = nil;
}

- (void)testFormatterPerformanceWhenPriceZero {
    NSNumber*  price = [NSNumber numberWithLongLong:0];
    [self measureBlock:^{
        [self.priceFormatter stringFromNumber:price];
    }];
}

- (void)testFormatterPerformanceWhenSmallPrice {
    NSNumber*  price = [NSNumber numberWithLongLong:150];
    [self measureBlock:^{
        [self.priceFormatter stringFromNumber:price];
    }];
}

- (void)testFormatterPerformanceWhenRegularPrice {
    NSNumber*  price = [NSNumber numberWithLongLong:3000];
    [self measureBlock:^{
        [self.priceFormatter stringFromNumber:price];
    }];
}

- (void)testFormatterPerformanceWhenLargePrice {
    NSNumber*  price = [NSNumber numberWithLongLong:50000000];
    [self measureBlock:^{
        [self.priceFormatter stringFromNumber:price];
    }];
}


@end


