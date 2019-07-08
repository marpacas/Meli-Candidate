//
//  MLCItemDetailParser.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCItem.h"

@interface MLCItemDetailParser : NSObject


-(nullable instancetype)initWithJSONDictionary:(nonnull NSDictionary*)JSONDictionary NS_DESIGNATED_INITIALIZER;


-(nullable NSError*)getDetailFromJSONDictionaryForItem:(nonnull MLCItem*)item;

@end
