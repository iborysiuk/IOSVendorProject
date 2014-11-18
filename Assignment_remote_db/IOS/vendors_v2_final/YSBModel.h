//
//  YSBModel.h
//  vendors_v1
//
//  Created by macadmin on 2014-10-15.
//  Copyright (c) 2014 com.example. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelProtocol <NSObject>

-(void)itemsDownloaded:(NSArray *)items;

@end

@interface YSBModel : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<ModelProtocol> delegate;

-(void)downloadItems;

@end
