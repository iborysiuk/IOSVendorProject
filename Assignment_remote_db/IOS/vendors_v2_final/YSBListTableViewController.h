//
//  YSBListTableViewController.h
//  vendors_v1
//
//  Created by macadmin on 2014-10-15.
//  Copyright (c) 2014 com.example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSBModel.h"
@interface YSBListTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, ModelProtocol>

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

- (IBAction)addV:(id)sender;

@end
