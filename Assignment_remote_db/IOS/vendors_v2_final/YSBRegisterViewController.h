//
//  YSBRegisterViewController.h
//  vendors_v1
//
//  Created by macadmin on 2014-10-15.
//  Copyright (c) 2014 com.example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSBRegisterViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputName;

@property (weak, nonatomic) IBOutlet UITextField *inputEmail;

@property (weak, nonatomic) IBOutlet UITextField *inputPassword;

- (IBAction)btnRegister:(id)sender;

- (IBAction)backgroundTap:(id)sender;

@end
