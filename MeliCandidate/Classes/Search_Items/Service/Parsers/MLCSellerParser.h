//
//  MLCSellerParser.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCSeller.h"

/**
 A MLCSellerParser receive a JSON Dictionary , parse it  and on success vends an seller instance with basic information, otherwise returns an error
 */

@interface MLCSellerParser : NSObject

@property(nonatomic,strong,nullable) MLCSeller* seller;


-(nullable instancetype)initWithJSONDictionary:(nonnull NSDictionary*)JSONDictionary NS_DESIGNATED_INITIALIZER;


-(nullable NSError*)getBasicInfoForSellerFromJSONDictionary;

@end
