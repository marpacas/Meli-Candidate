//
//  MCLItem.m
//  MeliCandidate
//  Created by Martha Patricia Castillo Fuentes on 7/7/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCItem.h"

@implementation MLCItem


#pragma mark - Initialization

-(nullable instancetype)initWithIdentification:(NSString *)itemIdentification title:(NSString *)title condition:(NSString *)condition seller:(MLCSeller *)seller {
    self = [super init];
    if (self) {
        // <#initializations#>
        self.itemIdentification = itemIdentification;
        self.title = title;
        self.condition = condition;
        self.seller = seller;
        MLCLocation* location = [MLCLocation new];
        location.city = @"";
        self.location = location;
        
    }
    return self;
    
    
}

-(nullable instancetype)init {
    self = [self initWithIdentification:@"" title:@"" condition:@"" seller:[MLCSeller new]];
    return self;
    
}


#pragma mark - Equality

-(BOOL)isEqualToItem:(nullable MLCItem*)otherItem {
    return ((([self.itemIdentification isEqualToString:otherItem.itemIdentification]) && ([self.title isEqualToString:otherItem.title])));
}

- (BOOL)isEqual:(id)otherItem {
    BOOL isEqual = NO;
    if (otherItem == self) {
        isEqual = YES;
    }
    else {
        if (![otherItem isKindOfClass:[self class]]) {
            
            isEqual = NO;
        }
        else {
            isEqual = [self isEqualToItem:(MLCItem*)otherItem];
            
        }
        
    }
    return isEqual;
}


- (NSUInteger) hash {
    return ([self.itemIdentification hash] ^  [self.title hash]);
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.itemIdentification = [decoder decodeObjectForKey:NSStringFromSelector(@selector(itemIdentification))];
        self.title = [decoder decodeObjectForKey:NSStringFromSelector(@selector(title))];
        self.condition = [decoder decodeObjectForKey:NSStringFromSelector(@selector(condition))];
        self.price = [decoder decodeInt64ForKey:NSStringFromSelector(@selector(price))];
        self.soldQuantity = [decoder decodeInt64ForKey:NSStringFromSelector(@selector(soldQuantity))];
        self.availableQuantity = [decoder decodeInt64ForKey:NSStringFromSelector(@selector(availableQuantity))];
        self.thumbnailURL = [decoder decodeObjectForKey:NSStringFromSelector(@selector(thumbnailURL))];
        self.picturesURL = [decoder decodeObjectForKey:NSStringFromSelector(@selector(picturesURL))];
        self.location = [decoder decodeObjectForKey:NSStringFromSelector(@selector(location))];
        self.seller = [decoder decodeObjectForKey:NSStringFromSelector(@selector(seller))];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.itemIdentification forKey:NSStringFromSelector(@selector(itemIdentification))];
    [encoder encodeObject:self.title forKey:NSStringFromSelector(@selector(title))];
    [encoder encodeObject:self.condition forKey:NSStringFromSelector(@selector(condition))];
    [encoder encodeInt64:self.price forKey:NSStringFromSelector(@selector(price))];
    [encoder encodeInt64:self.soldQuantity forKey:NSStringFromSelector(@selector(soldQuantity))];
    [encoder encodeInt64:self.availableQuantity forKey:NSStringFromSelector(@selector(availableQuantity))];
    [encoder encodeObject:self.thumbnailURL forKey:NSStringFromSelector(@selector(thumbnailURL))];
    [encoder encodeObject:self.picturesURL forKey:NSStringFromSelector(@selector(picturesURL))];
    [encoder encodeObject:self.location forKey:NSStringFromSelector(@selector(location))];
    [encoder encodeObject:self.seller forKey:NSStringFromSelector(@selector(seller))];
    
}


@end
