//
//  MLCSellerParser.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCSellerParser.h"
#import "MLCConstants.h"

@interface MLCSellerParser  ()

@property (nonatomic, strong, nonnull) NSDictionary* JSONDictionary;

@end

@implementation MLCSellerParser

#pragma mark - Initialization

-(instancetype)initWithJSONDictionary:(NSDictionary*)JSONDictionary {
    self = [super init];
    if (self) {
        // <#initializations#>
        self.JSONDictionary = JSONDictionary;
    }
    return self;
}

-(instancetype)init {
    self = [self initWithJSONDictionary:@{@"":@""}];
    return self;
    
}

#pragma mark - Parsing

-(NSError*)getBasicInfoForSellerFromJSONDictionary {
    NSError* parsingError;
    if ((!self.JSONDictionary[@"id"]) && (!self.JSONDictionary[@"power_seller_status"])) {
        parsingError = [self setErrorWithMessage:@"Invalid JSON for Seller"];
        
    }
    else {
        if (!self.JSONDictionary[@"id"]) {
            parsingError = [self setErrorWithMessage:@"Invalid id in JSON for Seller"];;
           
        }
        else {
            [self setUpSeller];
        }
    }
    
    return parsingError;
}

-(void)setUpSeller {
    self.seller = [MLCSeller new];
    
    self.seller.sellerIdentification = self.JSONDictionary[@"id"];
    self.seller.powerSellerStatus = self.JSONDictionary[@"power_seller_status"];
    

}

-(nonnull NSError*)setErrorWithMessage:(NSString*)errorMessage {
    NSDictionary* userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(errorMessage, nil)};
    return ([NSError errorWithDomain:kMLCDomain code:300 userInfo:userInfo]);
    
}


@end
