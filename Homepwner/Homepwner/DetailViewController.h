//
//  DetailViewController.h
//  Homepwner
//
//  Created by Daniel Muñoz on 10/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>

{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    
    __weak IBOutlet UIImageView *imageView;
    
    UIPopoverController *imagePickerPopover;
}

@property (nonatomic, strong) BNRItem *item;

@property (nonatomic) IBOutlet UIView *overlayView;

@property (nonatomic, copy) void (^dismissBlock)(void);

- (IBAction)changeDate:(id)sender;
- (IBAction)takePicture:(id)sender;
- (IBAction)backgroundTapped:(id)sender;
- (IBAction)clearImage:(id)sender;
- (id)initForNewItem:(BOOL)isNew;

@end
