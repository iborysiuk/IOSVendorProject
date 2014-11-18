//
//  YSBAddViewController.h
//  vendors_v1
//
//  Created by macadmin on 2014-10-21.
//  Copyright (c) 2014 com.example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSBAddViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *addName;
@property (weak, nonatomic) IBOutlet UITextField *addEmail;
@property (weak, nonatomic) IBOutlet UITextField *addPhNum;
@property (weak, nonatomic) IBOutlet UITextField *addCountry;
@property (weak, nonatomic) IBOutlet UITextField *addCity;
@property (weak, nonatomic) IBOutlet UITextField *addAddress;
@property (weak, nonatomic) IBOutlet UITextField *addPostalCode;
@property (weak, nonatomic) IBOutlet UITextField *addImgLink;
- (IBAction)addVendor:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end
