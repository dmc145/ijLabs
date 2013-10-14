//
//  DetailViewController.m
//  Homepwner
//
//  Created by Daniel Muñoz on 10/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "DateViewController.h"
#import "BNRImageStore.h"


@implementation DetailViewController

@synthesize item;

- (void)setItem:(BNRItem *)i
{
    item = i;
    [[self navigationItem] setTitle:[item itemName]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [nameField setText:[item itemName]];
    [serialNumberField setText:[item serialNumber]];
    [valueField setText:[NSString stringWithFormat:@"%d", [item valueInDollars]]];
    
    // Create a NSDateFormatter that will turn a date into a simple date string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateLabel setText:[dateFormatter stringFromDate:[item dateCreated]]];
    
    /* Chap. 12 */
    NSString *imageKey = [item imageKey];
    
    if (imageKey) {
        // Get image for image key from image store
        UIImage *imageToDisplay =
        [[BNRImageStore sharedStore] imageForKey:imageKey];
        
        // Use that image to put on the screen in imageView
        [imageView setImage:imageToDisplay];
    } else {
        // Clear the imageView
        [imageView setImage:nil];
    }
    /* */
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [[self view] endEditing:YES];
    
    // "Save" changes to item
    [item setItemName:[nameField text]];
    [item setSerialNumber:[serialNumberField text]];
    [item setValueInDollars:[[valueField text] intValue]];
}

#pragma-mark Chap. 11 Silver challenge

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma-mark Chap. 11 Gold challenge

- (IBAction)changeDate:(id)sender
{
    DateViewController *dateViewController = [[DateViewController alloc] init];
    
    // Give detail view controller a pointer to the item object in row
    [dateViewController setItem:item];
    
    // Push it onto the top of the navigation controller's stack
    [[self navigationController] pushViewController:dateViewController
                                           animated:YES];
}

#pragma-mark Chap. 12

- (IBAction)takePicture:(id)sender {
    
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    
    // If our device has a camera, we want to take a picture, otherwise, we
    // just pick from photo library
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];

        /*
        [[NSBundle mainBundle] loadNibNamed:@"CrossHair" owner:self options:nil];
        [imagePicker setCameraOverlayView:[self overlayView]];
         */
        
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    // This line of code will generate a warning right now, ignore it
    [imagePicker setDelegate:self];
    
    /* Chap. 12 Bronze Challenge */
    [imagePicker setAllowsEditing:YES];
    /* */
    
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *oldKey = [item imageKey];
    
    // Did the item already have an image?
    if (oldKey) {
        
        // Delete the old image
        [[BNRImageStore sharedStore] deleteImageForKey:oldKey];
    }

    // Get picked image from info dictionary
    // UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    // Chap. 12 Bronze Challenge
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // Create a CFUUID object - it knows how to create unique identifier strings
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);

    // Create a string from unique identifier
    CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
    
    // Use that unique ID to set our item's imageKey
    NSString *key = (__bridge NSString *)newUniqueIDString;
    [item setImageKey:key];
    
    // Store image in the BNRImageStore with this key
    [[BNRImageStore sharedStore] setImage:image
                                   forKey:[item imageKey]];
    
    // Put that image onto the screen in our image view
    //[imageView setImage:image];
    
    /*
     When a variable that points to an Objective-C object is destroyed, ARC knows that object has lost an owner. ARC doesn’t do this with Core Foundation objects. Thus, when a Core Foundation object loses a pointer, you must call a function that tells the object to lose an owner before you lose the pointer.
     */
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    
    // Take image picker off the screen -
    // you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma-mark Chap. 12 Silver Challenge

- (IBAction)clearImage:(id)sender {
    
    NSString *imageKey = [item imageKey];
    [[BNRImageStore sharedStore] deleteImageForKey:imageKey];
    
    [item setImageKey:nil];
    
    [imageView setImage:nil];
}

@end
