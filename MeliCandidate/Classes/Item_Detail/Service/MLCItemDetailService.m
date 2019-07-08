//
//  MLCItemDetailService.m
//  MeliCandidate
//
//  Created by Martha Patricia Castillo Fuentes on 7/8/19.
//  Copyright © 2019 Martha Castillo. All rights reserved.
//

#import "MLCItemDetailService.h"
#import "MLCItemDetailParser.h"
#import "MLCConstants.h"

@interface MLCItemDetailService ()

@property(nonatomic,strong,nonnull)NSURLSessionDataTask* getItemDetailTask;
@property(nonatomic,strong,nullable)MLCItemDetailParser* itemDetailParser;
@property(nonatomic,strong,nullable)NSData* JSONData;

@end

@implementation MLCItemDetailService

-(void)getItemDetailWithCompletionBlock:(nullable void(^)( NSError* _Nullable error))completionBlock {
    //Cancel the data task if it already exists
    [self.getItemDetailTask cancel];
    NSURLComponents* URLComponents = [self setUpURLComponents];
    if (URLComponents.URL) {
        NSURLSession* session = [NSURLSession sharedSession];
        self.getItemDetailTask = [session dataTaskWithURL:URLComponents.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            if ((httpResponse) && (httpResponse.statusCode == ok)) {
                self.JSONData = data;
                //Parse the JSON data to get item detail
                NSError* parsingDetailError = [self  getItemDetailFromJSONData];
                if (parsingDetailError) {
                    completionBlock(parsingDetailError);
                    
                }
                else {
                    completionBlock(nil);
                }
            }
            else {
                if ((httpResponse) && (httpResponse.statusCode != ok)) {
                    NSError* badRequestError = [self setErrorWithMessage:@"Error in item detail service - Bad Request"];
                    completionBlock(badRequestError);
                    
                    
                }
                else {
                    NSError* APIError = [self setErrorWithMessage:@"API Error in item detail service"];
                    completionBlock(APIError);
                }
            }
        }];
    }
    else {
        NSError* endpointError = [self setErrorWithMessage:@"Error in item detail service - Invalid endpoint"];
        completionBlock(endpointError);
    }
    
    [self.getItemDetailTask resume];
    
}

-(nonnull NSURLComponents*)setUpURLComponents {
    NSString* endpoint = [NSString stringWithFormat:@"%@%@%@",kBaseURL,@"/items/",self.item.itemIdentification];
    NSURLComponents* URLComponents =[NSURLComponents componentsWithString:endpoint];
    return URLComponents;
    
}

-(nullable NSError*)getItemDetailFromJSONData {
    //Create an object from JSON data
    NSError* JSONError;
    NSError* error;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:self.JSONData options:NSJSONReadingAllowFragments error:&JSONError];
    //Parse JSON
    if (([JSONObject isKindOfClass:[NSDictionary class]]) && (!JSONError)) {
        NSDictionary* JSONDictionary = (NSDictionary*) JSONObject;
         self.itemDetailParser = [[MLCItemDetailParser alloc] initWithJSONDictionary:JSONDictionary ];
        error = [self.itemDetailParser getDetailFromJSONDictionaryForItem:self.item];
            
    }
    else {
        if (JSONError) {
            error = [self setErrorWithMessage:[NSLocalizedString(@"Error in item detail service - Invalid JSON ", nil) stringByAppendingString:[JSONError localizedDescription]]];
        }
        else {
            error = [self setErrorWithMessage:@"Invalid JSON in item detail service"];
            
        }
        
    }
    return error;
    
}


-(nonnull NSError*)setErrorWithMessage:(NSString*)errorMessage {
    NSDictionary* userInfo = @{NSLocalizedDescriptionKey:NSLocalizedString(errorMessage, nil)};
    return ([NSError errorWithDomain:kMLCDomain code:20 userInfo:userInfo]);
    
}

@end
