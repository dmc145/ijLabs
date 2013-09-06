//
//  ViewController.h
//  secondone
//
//  Created by Daniel Muñoz on 06/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)doLogin:(id)sender;

@end
