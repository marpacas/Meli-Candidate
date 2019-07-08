//
//  MLCItemsListParser.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCItemsListParser.h"
#import "MLCItemParser.h"
#import "MLCConstants.h"

@interface MLCItemsListParser  ()

@property (nonatomic, strong, nonnull) NSArray* JSONArray;

@end

@implementation MLCItemsListParser

#pragma mark - Initialization

-(instancetype)initWithJSONArray:(NSArray*)JSONArray {
    self = [super init];
    if (self) {
        // <#initializations#>
        self.JSONArray = JSONArray;
    }
    return self;
}

-(instancetype)init {
    self = [self initWithJSONArray:[NSArray new]];
    return self;
    
}

#pragma mark - Parsing

-(NSError*)getItemsListFromJSONArray {
    
    __block NSError* error;
    NSMutableArray* itemsToFill = [[NSMutableArray alloc] init];
    [self.JSONArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary* JSONDictionary = (NSDictionary*)obj;
        if (JSONDictionary) {
            MLCItemParser* itemParser = [[MLCItemParser alloc] initWithJSONDictionary:JSONDictionary];
            NSError* itemError =
            [itemParser getBasicInfoForItemFromJSONDictionary];
            if (itemError) {
                error = itemError;
                *stop = YES;
            }
            else {
                [itemsToFill addObject:itemParser.item];
            }
            
            
        }
        else {
            NSDictionary* userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(@"Invalid JSON for items list", nil)};
            error = [NSError errorWithDomain:kMLCDomain code:0 userInfo:userInfo];
        }
        
    }];
    if (!error) {
        self.itemsList = [NSArray arrayWithArray:itemsToFill];
    }
    return error;
    
}

@end
