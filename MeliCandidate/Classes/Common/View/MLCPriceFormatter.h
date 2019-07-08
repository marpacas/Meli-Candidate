//
//  MLCPriceFormatter.h
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/7/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A class that formats a number with the currency and grouping separator encapsulated for the current locale
 */

@interface MLCPriceFormatter : NSNumberFormatter

+(instancetype)sharedPriceFormatter;

@end
