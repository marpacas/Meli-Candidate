//
//  MLCItemParser.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCItemParser.h"
#import "MLCSellerParser.h"
#import "MLCConstants.h"

@interface MLCItemParser  ()

@property (nonatomic, strong, nonnull) NSDictionary* JSONDictionary;

@end

@implementation MLCItemParser

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

-(NSError*)getBasicInfoForItemFromJSONDictionary {
    NSError* parsingError;
    if ((!self.JSONDictionary[@"id"]) && (!self.JSONDictionary[@"title"])&& (!self.JSONDictionary[@"condition"]) && (!self.JSONDictionary[@"address"])) {
        parsingError = [self setErrorWithMessage:@"Invalid JSON for Item"];
        
    }
    else {
        if (!self.JSONDictionary[@"id"]) {
            parsingError = [self setErrorWithMessage:@"Invalid id in JSON for Item"];
            
        }
        else {
            [self setUpItem];
        }
    }
    
    return parsingError;
}

-(void)setUpItem {
    self.item = [MLCItem new];
    
    self.item.itemIdentification = self.JSONDictionary[@"id"];
    self.item.title = self.JSONDictionary[@"title"];
    self.item.condition = self.JSONDictionary[@"condition"];
    self.item.price = [self.JSONDictionary[@"price"] longLongValue];
    self.item.soldQuantity = [self.JSONDictionary[@"sold_quantity"] longLongValue];
    self.item.availableQuantity = [self.JSONDictionary[@"available_quantity"] longLongValue];
    self.item.thumbnailURL = self.JSONDictionary[@"thumbnail"];

    //Parse the item address , if any
    NSDictionary* addressDictionary = self.JSONDictionary[@"address"];
    self.item.location = [MLCLocation new];
    if (addressDictionary) {
        MLCLocation* itemLocation = [self getItemLocationFromAddressDictionary:addressDictionary];
        if (itemLocation) {
            self.item.location = itemLocation;
            
        }
     }
    
    //Parse the item seller , if any
    NSDictionary* sellerDictionary = self.JSONDictionary[@"seller"];
    self.item.seller = [MLCSeller new];
    if (sellerDictionary) {
        MLCSellerParser* sellerParser = [[MLCSellerParser alloc] initWithJSONDictionary:sellerDictionary];
        NSError* sellerError = [sellerParser getBasicInfoForSellerFromJSONDictionary];
        if (!sellerError) {
            self.item.seller = sellerParser.seller;
        }

    }
    
}

-(MLCLocation*)getItemLocationFromAddressDictionary:(NSDictionary*)addressDictionary {
    MLCLocation* itemLocation;
    if (addressDictionary[@"city_name"]) {
        itemLocation = [MLCLocation new];
        itemLocation.city = addressDictionary[@"city_name"];
        itemLocation.state = addressDictionary[@"state_name"];
        
    }
    return itemLocation;
    
}

-(nonnull NSError*)setErrorWithMessage:(NSString*)errorMessage {
    NSDictionary* userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(errorMessage, nil)};
    return ([NSError errorWithDomain:kMLCDomain code:100 userInfo:userInfo]);

}

@end
