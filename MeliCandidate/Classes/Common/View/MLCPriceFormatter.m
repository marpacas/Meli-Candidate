//
//  MLCPriceFormatter.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/7/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCPriceFormatter.h"

@implementation MLCPriceFormatter

+(instancetype)sharedPriceFormatter {
    static MLCPriceFormatter* priceFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        priceFormatter = [MLCPriceFormatter new];
        NSLocale *locale  = NSLocale.currentLocale;
        
        priceFormatter.locale = locale;
        priceFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        priceFormatter.decimalSeparator = [locale objectForKey:NSLocaleDecimalSeparator];
        priceFormatter.currencyGroupingSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
        });
        return priceFormatter;

}

@end
