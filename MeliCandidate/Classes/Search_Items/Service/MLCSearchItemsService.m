//
//  MLCSearchItemsService.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCSearchItemsService.h"
#import "MLCItemsListParser.h"
#import "MLCConstants.h"

@interface MLCSearchItemsService ()

@property(nonatomic,strong,nonnull)NSURLSessionDataTask* getItemsListTask;
@property(nonatomic,strong,nullable)MLCItemsListParser* itemsListParser;
@property(nonatomic,strong,nullable)NSData* JSONData;
@property(nonatomic,copy, nonnull) NSString* textToSearch;

@end


@implementation MLCSearchItemsService

-(void)searchItemsThatContainText:(NSString*)textToSearch  completionBlock:(void(^)(NSArray <MLCItem*> * itemsList, NSError* error))completionBlock {
    //Cancel the data task if it already exists
    [self.getItemsListTask cancel];
    self.textToSearch = textToSearch;
    NSURLComponents* URLComponents = [self setUpURLComponents];
    if (URLComponents.URL) {
        NSURLSession* session = [NSURLSession sharedSession];
        self.getItemsListTask = [session dataTaskWithURL:URLComponents.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            if ((httpResponse) && (httpResponse.statusCode == ok)) {
                self.JSONData = data;
                //Parse the JSON data to get items list
                NSError* parsingListError = [self  getItemsListFromJSONData];
                if (parsingListError) {
                    completionBlock(nil, parsingListError);
                    
                }
                else {
                    completionBlock(self.itemsListParser.itemsList,nil);
                }
            }
            else {
                if ((httpResponse) && (httpResponse.statusCode != ok)) {
                    NSError* badRequestError = [self setErrorWithMessage:@"Error in search items service - Bad Request"];
                    completionBlock(nil,badRequestError);
                    
                    
                }
                else {
                    NSError* APIError = [self setErrorWithMessage:@"API Error in search items service"];
                    completionBlock(nil,APIError);
                }
            }
        }];
    }
    else {
        NSError* endpointError = [self setErrorWithMessage:@"Error in search items service - Invalid endpoint"];
        completionBlock(nil,endpointError);
    }
    
    [self.getItemsListTask resume];
 
}

-(nonnull NSURLComponents*)setUpURLComponents {
    NSString* endpoint = [kBaseURL stringByAppendingString:@"/sites/MLA/search"];
    NSURLComponents* URLComponents =[NSURLComponents componentsWithString:endpoint];
    URLComponents.queryItems = [self setUpQueryItems];
    return URLComponents;
    
}

-(nonnull NSArray<NSURLQueryItem*>*)setUpQueryItems {
    NSURLQueryItem* textToSearchQueryItem = [NSURLQueryItem queryItemWithName:@"q" value:self.textToSearch];
    return [NSArray arrayWithObject:textToSearchQueryItem];
}

-(nullable NSError*)getItemsListFromJSONData {
    //Create an object from JSON data
    NSError* JSONError;
    NSError* error;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:self.JSONData options:NSJSONReadingAllowFragments error:&JSONError];
    //Parse JSON
    if (([JSONObject isKindOfClass:[NSDictionary class]]) && (!JSONError)) {
        NSArray* JSONArray = JSONObject[@"results"];
        if (JSONArray) {
            self.itemsListParser = [[MLCItemsListParser alloc] initWithJSONArray:JSONArray];
            error = [self.itemsListParser getItemsListFromJSONArray];

        }
        else {
            error = [self setErrorWithMessage:@"Invalid JSON in search items service - No results key"];
           
        }

    }
    else {
        if (JSONError) {
            error = [self setErrorWithMessage:[NSLocalizedString(@"Error in search items service - Invalid JSON ", nil) stringByAppendingString:[JSONError localizedDescription]]];
        }
        else {
            error = [self setErrorWithMessage:@"Invalid JSON in search items service"];
            
        }
        
    }
    return error;
    
}

-(nonnull NSError*)setErrorWithMessage:(NSString*)errorMessage {
    NSDictionary* userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(errorMessage, nil)};
    return ([NSError errorWithDomain:kMLCDomain code:10 userInfo:userInfo]);
    
}

@end
