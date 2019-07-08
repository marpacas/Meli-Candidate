//
//  SellerParserTests.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLCSellerParser.h"

@interface SellerParserTests : XCTestCase

@property(nonatomic,strong) NSDictionary* invalidJSONDictionary;
@property(nonatomic,strong) NSDictionary* validJSONDictionary;
@property(nonatomic,strong) MLCSellerParser* sellerParser;

@end

@implementation SellerParserTests

- (void)setUp {
    [super setUp];
    NSBundle* testBundle = [NSBundle bundleForClass:[self class]];
    NSURL* invalidJSONURL = [testBundle URLForResource:@"InvalidItem" withExtension:@"plist"];
    if (invalidJSONURL) {
        self.invalidJSONDictionary = [NSDictionary dictionaryWithContentsOfURL:invalidJSONURL];

    }
    NSURL* validJSONURL = [testBundle URLForResource:@"ValidItem" withExtension:@"plist"];
    if (validJSONURL) {
        self.validJSONDictionary = [NSDictionary dictionaryWithContentsOfURL:validJSONURL];
        
    }
   
}

- (void)tearDown {
   [super tearDown];
   self.validJSONDictionary = nil;
   self.validJSONDictionary = nil;
   self.sellerParser = nil;

}

- (void)testParsingWhenInvalidJSON {
    if (self.invalidJSONDictionary) {
        self.sellerParser = [[MLCSellerParser alloc] initWithJSONDictionary:self.invalidJSONDictionary];
        
        NSError* error = [self.sellerParser getBasicInfoForSellerFromJSONDictionary];
        
        XCTAssertNotNil(error, @"Seller Parser doesn't throw an error parsing JSON with unexpected values");
        XCTAssertNil(self.sellerParser.seller, @"Seller Parser could parse JSON with unexpected values");
        }
    else {
        XCTFail(@"Missing file: InvalidItem.plist");
    }

 }


- (void)testParsingWhenValidJSON {
    if (self.validJSONDictionary) {
        self.sellerParser = [[MLCSellerParser alloc] initWithJSONDictionary:self.validJSONDictionary];
        
        NSError* error = [self.sellerParser getBasicInfoForSellerFromJSONDictionary];
        
        XCTAssertNotNil(self.sellerParser.seller, @"Valid JSON was not parsed successfully by Seller Parser");
        XCTAssertNil(error, @"Seller Parser  throws  an error parsing valid JSON");
    }
    else {
        XCTFail(@"Missing file: ValidItem.plist");
    }
    
}

@end
