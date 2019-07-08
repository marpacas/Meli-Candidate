//
//  MLCSeller.m
//  MeliCandidate
//  Created by Martha Patricia Castillo Fuentes on 7/7/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCSeller.h"

@implementation MLCSeller

#pragma mark - Initialization

-(nullable instancetype)initWithIdentification:(nonnull NSString*)sellerIdentification nickName:(nonnull NSString*)nickName {
    self = [super init];
    if (self) {
        // <#initializations#>
        self.sellerIdentification = sellerIdentification;
        self.nickName = nickName;
        MLCLocation* location = [MLCLocation new];
        location.city = @"";
        self.location = location;

    }
    return self;

    
}

-(nullable instancetype)init {
    self = [self initWithIdentification:@"" nickName:@""];
    return self;
    
}

#pragma mark - Equality

-(BOOL)isEqualToSeller:(MLCSeller*)otherSeller {
    return ((([self.nickName isEqualToString:otherSeller.nickName]) && ([self.sellerIdentification isEqualToString:otherSeller.sellerIdentification])));
}

- (BOOL)isEqual:(id)otherSeller {
    BOOL isEqual = NO;
    if (otherSeller == self) {
        isEqual = YES;
    }
    else {
        if (![otherSeller isKindOfClass:[self class]]) {
            
            isEqual = NO;
        }
        else {
            isEqual = [self isEqualToSeller:(MLCSeller*)otherSeller];
            
        }
        
    }
    return isEqual;
}


- (NSUInteger) hash {
    return ([self.nickName hash] ^  [self.sellerIdentification hash]);
}


#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.sellerIdentification = [decoder decodeObjectForKey:NSStringFromSelector(@selector(sellerIdentification))];
        self.nickName = [decoder decodeObjectForKey:NSStringFromSelector(@selector(nickName))];
        self.powerSellerStatus = [decoder decodeObjectForKey:NSStringFromSelector(@selector(powerSellerStatus))];
        self.location = [decoder decodeObjectForKey:NSStringFromSelector(@selector(location))];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.sellerIdentification forKey:NSStringFromSelector(@selector(sellerIdentification))];
    [encoder encodeObject:self.nickName forKey:NSStringFromSelector(@selector(nickName))];
    [encoder encodeObject:self.powerSellerStatus forKey:NSStringFromSelector(@selector(powerSellerStatus))];
    [encoder encodeObject:self.location forKey:NSStringFromSelector(@selector(location))];
    
}

@end
