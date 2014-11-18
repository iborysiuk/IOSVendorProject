//
//  YSBModel.m
//  vendors_v1
//
//  Created by macadmin on 2014-10-15.
//  Copyright (c) 2014 com.example. All rights reserved.
//

#import "YSBModel.h"
#import "YSBVendorLocation.h"

@interface YSBModel(){
    
    NSMutableData *_downloadedData;
    
}

@end


@implementation YSBModel

-(void)downloadItems {
    
    NSString *post =[[NSString alloc] initWithFormat:@"tag=%@",@"vendor"];
    
    NSURL *url=[NSURL URLWithString:@"http://vendors.t15.org/main.php"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    
    //Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    //Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    //Append the newly downloaded data
    [_downloadedData appendData:data];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    //Create an array to store the locations
    NSMutableArray *_locations = [[NSMutableArray alloc] init];
    
    //Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through JSON objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++) {
        
        NSDictionary *jsonElement = jsonArray[i];
        
        //Create a new location object and set its props to JSONElement properties
        YSBVendorLocation *newLocation = [[YSBVendorLocation alloc] init];
        newLocation.name = jsonElement[@"name"];
        newLocation.email = jsonElement[@"email"];
        newLocation.phonenumber = jsonElement[@"phonenumber"];
        newLocation.country = jsonElement[@"country"];
        newLocation.city = jsonElement[@"city"];
        newLocation.address = jsonElement[@"address"];
        newLocation.postalcode = jsonElement[@"postalcode"];
        newLocation.imgLink = jsonElement[@"imgLink"];
        
        //Add this question to location array
        [_locations addObject:newLocation];
        
    }
    
    //Ready to notify delegate that data is ready and pass back items
    if (self.delegate) {
        
        [self.delegate itemsDownloaded:_locations];
    }
}


@end
