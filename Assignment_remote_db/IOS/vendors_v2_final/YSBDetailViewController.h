//
//  YSBDetailViewController.h
//  vendors_v1
//
//  Created by macadmin on 2014-10-15.
//  Copyright (c) 2014 com.example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSBVendorLocation.h"
#import <MapKit/MapKit.h>

@interface YSBDetailViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) YSBVendorLocation *selectedLocation;
@property (weak, nonatomic) IBOutlet UILabel *vendorName;
@property (weak, nonatomic) IBOutlet UILabel *vendorAddress;
@property (weak, nonatomic) IBOutlet UILabel *vendorPhone;
@property (weak, nonatomic) IBOutlet UILabel *vendorEmail;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
- (IBAction)cancel:(id)sender;

@end
