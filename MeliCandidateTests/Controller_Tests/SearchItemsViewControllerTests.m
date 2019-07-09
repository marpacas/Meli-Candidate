//
//  SearchItemsViewControllerTests.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/9/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLCSearchItemsViewController.h"
#import "MLCSearchItemsService.h"
#import "UIViewController+MLCCategory.h"

@interface MLCSearchItemsServiceMock : MLCSearchItemsService

@end

@implementation MLCSearchItemsServiceMock

@end

@interface MLCSearchItemsServiceMockError : MLCSearchItemsService

@end

@implementation MLCSearchItemsServiceMockError

@end

@interface SearchItemsViewControllerTests : XCTestCase

@property(nonatomic,strong) MLCSearchItemsViewController* searchItemsViewController;
@property(nonatomic,strong) MLCSearchItemsServiceMock* searchItemsServiceMock;
@property(nonatomic,strong) MLCSearchItemsServiceMockError* searchItemsServiceMockError;


@end

@implementation SearchItemsViewControllerTests

- (void)setUp {
    [super setUp];
    self.searchItemsViewController = (MLCSearchItemsViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    UIWindow* window = [UIWindow new];
    window.rootViewController = self.searchItemsViewController;
    [window makeKeyAndVisible];
}

- (void)tearDown {
    [super tearDown];
    self.searchItemsServiceMock = nil;
    self.searchItemsServiceMockError = nil;
    self.searchItemsViewController = nil;
}

- (void)testPresentAlertWhenError {
    [self.searchItemsViewController showErrorWithTitle:@"Title" message:@"Error Message"];
    
    XCTAssertNotNil(self.searchItemsViewController.presentedViewController,@"Search Items View Controller should present alert");
    XCTAssertTrue([self.searchItemsViewController.presentedViewController isKindOfClass:[UIAlertController class]]);

}

@end
