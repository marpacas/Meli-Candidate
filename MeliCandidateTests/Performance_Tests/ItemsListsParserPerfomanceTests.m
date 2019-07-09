//
//  ItemsListsParserPerfomanceTests.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/9/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLCItemsListParser.h"


@interface ItemsListsParserPerfomanceTests : XCTestCase

@property(nonatomic, strong) NSData* JSONData;
@property(nonatomic, strong) MLCItemsListParser* itemsListParser;

@end

@implementation ItemsListsParserPerfomanceTests

- (void)setUp {
    [super setUp];
    NSBundle* testBundle = [NSBundle bundleForClass:[self class]];
    NSURL* validJSONURL = [testBundle URLForResource:@"ValidJSONData" withExtension:@"json"];
    if (validJSONURL) {
        self.JSONData = [NSData dataWithContentsOfURL:validJSONURL];
        NSError* JSONError;
        id JSONObject = [NSJSONSerialization JSONObjectWithData:self.JSONData options:NSJSONReadingAllowFragments error:&JSONError];
        if (([JSONObject isKindOfClass:[NSDictionary class]]) && (!JSONError)) {
            NSArray* JSONArray = JSONObject[@"results"];
            if (JSONArray) {
                self.itemsListParser = [[MLCItemsListParser alloc] initWithJSONArray:JSONArray];
            }
            else {
                XCTFail(@"Invalid JSON in file: ValidJSONData.json");
            }

        }
        else {
            XCTFail(@"Invalid JSON in file: ValidJSONData.json");

        }
        
    }
    else {
        XCTFail(@"Missing file: ValidJSONData.json");
    }
   


    
}

- (void)tearDown {
    [super tearDown];
    self.itemsListParser = nil;

}


- (void)testItemsListParserPerformance {
    [self measureBlock:^{
        NSError* error;
        error = [self.itemsListParser getItemsListFromJSONArray];
    }];
}

@end
