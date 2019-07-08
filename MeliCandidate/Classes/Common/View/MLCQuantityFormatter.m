//
//  MLCQuantityFormatter.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/7/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCQuantityFormatter.h"

@implementation MLCQuantityFormatter

+(instancetype)sharedQuantityFormatter {
    static MLCQuantityFormatter* quantityFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        quantityFormatter = [MLCQuantityFormatter new];
        NSLocale *locale  = NSLocale.currentLocale;
        
        quantityFormatter.locale = locale;
        quantityFormatter.currencyGroupingSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
    });
    return quantityFormatter;
    
}

@end
