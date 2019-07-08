//
//  MLCItemParser.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCItem.h"

@interface MLCItemParser : NSObject

@property(nonatomic,strong,nullable) MLCItem* item;


-(nullable instancetype)initWithJSONDictionary:(nonnull NSDictionary*)JSONDictionary NS_DESIGNATED_INITIALIZER;


-(nullable NSError*)getBasicInfoForItemFromJSONDictionary;

@end
