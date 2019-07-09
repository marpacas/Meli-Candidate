//
//  ItemsListParserTests.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLCItemsListParser.h"

@interface MLCItemsListParser  ()

@property (nonatomic, strong, nonnull) NSArray* JSONArray;

@end

@interface ItemsListParserTests : XCTestCase

@property(nonatomic,strong) NSArray* zeroJSONArry;
@property(nonatomic, strong) MLCItemsListParser* itemsListParser;

@end

@implementation ItemsListParserTests

- (void)setUp {
    [super setUp];
    self.zeroJSONArry = @[];
    self.itemsListParser = [MLCItemsListParser new];
    
}

- (void)tearDown {
    [super tearDown];
    self.itemsListParser = nil;
}

- (void)testItemsListParserWhenZeroItems {
    self.itemsListParser.JSONArray = self.zeroJSONArry;
    NSError* error = [self.itemsListParser getItemsListFromJSONArray];
    
    XCTAssertEqual(self.itemsListParser.itemsList.count, 0,@"Items list should be 0 items");
    XCTAssertNil(error,@"Error should be nil in Items List Parser");
}


@end
