//
//  SearchItemsTests.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLCSearchItemsService.h"
#import "MLCConstants.h"

@interface MLCSearchItemsService ()

@property(nonatomic,strong,nonnull)NSURLSessionDataTask* getItemsListTask;

@end

@interface SearchItemsTests : XCTestCase

@property(nonatomic, strong) NSString* textToSearch;
@property(nonatomic, strong) NSString* validEndPoint;
@property(nonatomic, strong) NSString* invalidEndPoint;

@property(nonatomic, strong)MLCSearchItemsService* searchItemsService;

@end

@implementation SearchItemsTests

- (void)setUp {
    [super setUp];
    self.textToSearch = @"Disco externo";
    self.validEndPoint = @"/sites/MLA/search";
    self.invalidEndPoint = @"/site/MLA/search";
    self.searchItemsService = [[MLCSearchItemsService alloc] init];
}

- (void)tearDown {
    [super tearDown];
    self.searchItemsService = nil;
}

- (void)testSearchItemsWhenEverythingIsAllRight {
    [self.searchItemsService.getItemsListTask cancel];

    NSString* endpoint = [kBaseURL stringByAppendingString:self.validEndPoint];
    NSURLComponents* URLComponents =[NSURLComponents componentsWithString:endpoint];
    URLComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"q" value:self.textToSearch]];
    NSString *description = [NSString stringWithFormat:@"GET %@", endpoint];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    if (!self.searchItemsService.session) {
        self.searchItemsService.session = [NSURLSession sharedSession];
    }
    self.searchItemsService.getItemsListTask = [self.searchItemsService.session dataTaskWithURL:URLComponents.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(data, "Data should not be nil in Search Items Service");
        XCTAssertNil(error, "Error should be nil in Search Items Service");
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200 in Search Items");
            XCTAssertEqualObjects(httpResponse.URL.absoluteString, URLComponents.URL.absoluteString, @"HTTP response URL should be equal to original URL in Search Items Service");
            XCTAssertEqualObjects(httpResponse.MIMEType, @"application/json", @"HTTP response content type should be application/json in Search Items Service");
        }
        else {
            XCTFail(@"Response was not NSHTTPURLResponse in Search Items Service");
        }
        
        [expectation fulfill];

    }];
    [self.searchItemsService.getItemsListTask resume];
    
    [self waitForExpectationsWithTimeout:self.searchItemsService.getItemsListTask.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [self.searchItemsService.getItemsListTask cancel];
    }];
    

}

-(void)testSearchItemsWhenBadRequest {
    [self.searchItemsService.getItemsListTask cancel];
    
    NSString* endpoint = [kBaseURL stringByAppendingString:self.invalidEndPoint];
    NSURLComponents* URLComponents =[NSURLComponents componentsWithString:endpoint];
    URLComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"q" value:self.textToSearch]];
    NSString *description = [NSString stringWithFormat:@"GET %@", endpoint];
    XCTestExpectation *expectation = [self expectationWithDescription:description];
    if (!self.searchItemsService.session) {
        self.searchItemsService.session = [NSURLSession sharedSession];
    }
    self.searchItemsService.getItemsListTask = [self.searchItemsService.session dataTaskWithURL:URLComponents.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        XCTAssertNotNil(data, "Data should not be nil in Search Items Service when bad request");
        XCTAssertNil(error, "Error should not nil in Search Items Service when bad request");
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            XCTAssertNotEqual(httpResponse.statusCode, 200, @"HTTP response status code should not be 200 in Search Items");
            XCTAssertEqualObjects(httpResponse.URL.absoluteString, URLComponents.URL.absoluteString, @"HTTP response URL should be equal to original URL in Search Items Service");
            XCTAssertEqualObjects(httpResponse.MIMEType, @"application/json", @"HTTP response content type should be application/json in Search Items Service");

        }
        else {
            XCTFail(@"Response was not NSHTTPURLResponse in Search Items Service");
        }
        
        [expectation fulfill];
        
    }];
    [self.searchItemsService.getItemsListTask resume];
    
    [self waitForExpectationsWithTimeout:self.searchItemsService.getItemsListTask.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [self.searchItemsService.getItemsListTask cancel];
    }];

    
}


@end
