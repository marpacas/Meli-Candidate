//
//  MLCItemDetailParser.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCItemDetailParser.h"
#import "MLCConstants.h"

@interface MLCItemDetailParser  ()

@property (nonatomic, strong, nonnull) NSDictionary* JSONDictionary;

@end

@implementation MLCItemDetailParser

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

-(NSError*)getDetailFromJSONDictionaryForItem:(MLCItem*)item {
    NSError* parsingError;
    if ((!self.JSONDictionary[@"id"]) && (!self.JSONDictionary[@"title"])&& (!self.JSONDictionary[@"condition"]) && (!self.JSONDictionary[@"address"])) {
        NSDictionary* userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(@"Invalid JSON for Item Detail", nil)};
        parsingError = [NSError errorWithDomain:kMLCDomain code:0 userInfo:userInfo];
        
    }
    else {
        if (!self.JSONDictionary[@"id"]) {
            NSDictionary* userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(@"Invalid id in JSON for Item Detail", nil)};
            parsingError = [NSError errorWithDomain:kMLCDomain code:0 userInfo:userInfo];
            
        }
        else {
            [self setUpDetailForItem:item];
        }
    }
    
    return parsingError;
}

-(void)setUpDetailForItem:(MLCItem*)item {
    item.title = self.JSONDictionary[@"title"];
    item.condition = self.JSONDictionary[@"condition"];
    item.price = [self.JSONDictionary[@"price"] longLongValue];
    item.soldQuantity = [self.JSONDictionary[@"sold_quantity"] longLongValue];
    item.availableQuantity = [self.JSONDictionary[@"available_quantity"] longLongValue];
    
    //Parse the seller address , if any
    NSDictionary* addressDictionary = self.JSONDictionary[@"seller_address"];
    item.seller.location = [MLCLocation new];
    if (addressDictionary) {
        MLCLocation* sellerLocation = [self getSellerLocationFromAddressDictionary:addressDictionary];
        if (sellerLocation) {
            item.seller.location = sellerLocation;
            
        }
    }
    //Parse the pictures , if any
    NSArray* picturesArray = self.JSONDictionary[@"pictures"];
    item.picturesURL = [NSArray new];
    if (picturesArray) {
        NSArray* picturesURL = [self getPicturesURLFromPicturesArray:picturesArray];
        if (picturesURL) {
            item.picturesURL = picturesURL;
        }
    }
    
}

-(MLCLocation*)getSellerLocationFromAddressDictionary:(NSDictionary*)addressDictionary {
    MLCLocation* sellerLocation;
    NSDictionary* cityDictionary = addressDictionary[@"city"];
    if (cityDictionary) {
        sellerLocation = [MLCLocation new];
        sellerLocation.city = cityDictionary[@"name"];
        NSDictionary* stateDictionary = addressDictionary[@"state"];
        sellerLocation.state = stateDictionary[@"name"];
        NSDictionary* countryDictionary = addressDictionary[@"country"];
        sellerLocation.country = countryDictionary[@"name"];
        CLLocation* locationCoordinates = [[CLLocation alloc] initWithLatitude:[addressDictionary[@"latitude"] doubleValue] longitude:[addressDictionary[@"longitude"] doubleValue]];
        sellerLocation.locationCoordinates = locationCoordinates;
        
    }
    return sellerLocation;
    
}

-(NSArray*)getPicturesURLFromPicturesArray:(NSArray*)picturesArray {
    NSArray* picturesURL;
    NSMutableArray* picturesToFill = [NSMutableArray new];
    [picturesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary* pictureDictionary = (NSDictionary*)obj;
        NSString* secureURL = pictureDictionary[@"secure_url"];
        if (secureURL) {
            [picturesToFill addObject:secureURL];
        }
    }];
    if (picturesToFill.count) {
        picturesURL = [NSArray arrayWithArray:picturesToFill];
    }
    return picturesURL;
    
}

@end
