//
//  YSBAddViewController.m
//  vendors_v1
//
//  Created by macadmin on 2014-10-21.
//  Copyright (c) 2014 com.example. All rights reserved.
//

#import "YSBAddViewController.h"

@interface YSBAddViewController ()


@end

@implementation YSBAddViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) alertStatus:(NSString *)msg :(NSString *)title :(int)tag {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
    
    
}

- (IBAction)addVendor:(id)sender {
    
    
    NSInteger success = 0;
    
    @try {
        if ([[self.addName text] isEqualToString:@""] ||
            [[self.addEmail text] isEqualToString:@""] ||
            [[self.addPhNum text] isEqualToString:@""] ||
            [[self.addCountry text] isEqualToString:@""] ||
            [[self.addCity text] isEqualToString:@""] ||
            [[self.addAddress text] isEqualToString:@""] ||
            [[self.addPostalCode text] isEqualToString:@""] ||
            [[self.addImgLink text] isEqualToString:@""])
        {
            [self alertStatus:@"Please fill whole form" :@"Add is Failed!" :0];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&name=%@&email=%@&phonenumber=%@&country=%@&city=%@&address=%@&postalcode=%@&imgLink=%@",@"add",[self.addName text],
                             [self.addEmail text],
                             [self.addPhNum text],
                             [self.addCountry text],
                             [self.addCity text],
                             [self.addAddress text],
                             [self.addPostalCode text],
                             [self.addImgLink text]];
            NSLog(@"PostData: %@",post);
            NSURL *url=[NSURL URLWithString:@"http://vendors.t15.org/main.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                        
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                success = [jsonData[@"success"] integerValue];
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Sign in Failed!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Add Failed!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Add Failed." :@"Error!" :0];
    }
    if (success) {
        
        [self performSegueWithIdentifier:@"back_add" sender:self];
    }
    
}

- (IBAction)back:(id)sender {
     [self performSegueWithIdentifier:@"back_add" sender:self];
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}
@end
