//
//  YSBDetailViewController.m
//  vendors_v1
//
//  Created by macadmin on 2014-10-15.
//  Copyright (c) 2014 com.example. All rights reserved.
//

#import "YSBDetailViewController.h"

@interface YSBDetailViewController ()
{
    NSString *geocodeAddressStr;
}
@end

@implementation YSBDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    geocodeAddressStr = [[NSString alloc] initWithFormat:@"%@, %@, %@, %@",self.selectedLocation.address,self.selectedLocation.city,self.selectedLocation.postalcode,self.selectedLocation.country];
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.layer.borderWidth = 2.0f;
    
    NSURL *url = [NSURL URLWithString:self.selectedLocation.imgLink];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    _imgLogo.image = image;
    _imgLogo.layer.borderWidth = 2.0f;
    
    self.mapView.delegate = self;
    _vendorName.text = self.selectedLocation.name;
    _vendorAddress.text = geocodeAddressStr;
    _vendorPhone.text = self.selectedLocation.phonenumber;
    _vendorEmail.text = self.selectedLocation.email;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString: geocodeAddressStr completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        MKCoordinateRegion region;
        region.center.latitude = placemark.region.center.latitude;
        region.center.longitude = placemark.region.center.longitude;
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(region.center, 1750, 1750);
        [self.mapView setRegion:viewRegion animated:YES];
        
        MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
        pin.coordinate = region.center;
        pin.title = self.selectedLocation.name;
        [_mapView addAnnotation:pin];
        
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logout:(id)sender {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [self performSegueWithIdentifier:@"detail_logout" sender:self];
}

- (IBAction)cancel:(id)sender {
    [self performSegueWithIdentifier:@"back_navigation" sender:self];
}
@end
