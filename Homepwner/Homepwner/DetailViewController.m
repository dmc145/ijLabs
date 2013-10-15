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
#import "CrossHairs.h"
#import "BNRItemStore.h"


@implementation DetailViewController

@synthesize item;
@synthesize dismissBlock;


- (void)setItem:(BNRItem *)i
{
    item = i;
    [[self navigationItem] setTitle:[item itemName]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *clr = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        clr = [UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1];
    } else {
        clr = [UIColor groupTableViewBackgroundColor];
    }
    [[self view] setBackgroundColor:clr];
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
    
    /* Chap. 13
     If the UIPopoverController is visible and the user taps on the camera button again, the application will crash
     */
    if ([imagePickerPopover isPopoverVisible]) {
        // If the popover is already up, get rid of it
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
        return;
    }
    /* */
    
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    
    // If our device has a camera, we want to take a picture, otherwise, we
    // just pick from photo library
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];

        /* Chap. 12 Gold Challenge
         
        [[NSBundle mainBundle] loadNibNamed:@"CrossHair" owner:self options:nil];
        [imagePicker setCameraOverlayView:[self overlayView]];
         */
        CrossHairs *reticle = [[CrossHairs alloc]
                               initWithFrame:CGRectMake(imagePicker.view.frame.origin.x,
                                                        imagePicker.view.frame.origin.y,
                                                        imagePicker.view.frame.size.width,
                                                        imagePicker.view.frame.size.height-
                                                        imagePicker.toolbar.frame.size.height)];
        [imagePicker setCameraOverlayView:reticle];
        /* */
        
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    // This line of code will generate a warning right now, ignore it
    [imagePicker setDelegate:self];
    
    /* Chap. 12 Bronze Challenge */
    [imagePicker setAllowsEditing:YES];
    /* */
    
    /* Chap. 13 */
    // Place image picker on the screen
    //[self presentViewController:imagePicker animated:YES completion:nil];
    
    // Check for iPad device before instantiating the popover controller
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        // Create a new popover controller that will display the imagePicker
        imagePickerPopover = [[UIPopoverController alloc]
                              initWithContentViewController:imagePicker];
        
        [imagePickerPopover setDelegate:self];
        
        NSLog(@"popoverBackgroundViewClass: %@", [imagePickerPopover popoverBackgroundViewClass]);
        
        
        // Display the popover controller; sender
        // is the camera bar button item
        [imagePickerPopover presentPopoverFromBarButtonItem:sender
                                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                                   animated:YES];
    } else {
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    /* */
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
    
    [item setThumbnailDataFromImage:image];
    
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

#pragma-mark Chap. 13

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return (io == UIInterfaceOrientationPortrait);
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"User dismissed popover");
    imagePickerPopover = nil;
}

- (id)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:@"DetailViewController" bundle:nil];
    
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                         target:self
                                         action:@selector(save:)];
            [[self navigationItem] setRightBarButtonItem:doneItem];
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                           target:self
                                           action:@selector(cancel:)];
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
        }
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    @throw [NSException exceptionWithName:@"Wrong initializer"
                                   reason:@"Use initForNewItem:"
                                 userInfo:nil];
    return nil;
}

- (void)save:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES
                                                        completion:dismissBlock];
}

- (void)cancel:(id)sender
{
    // If the user cancelled, then remove the BNRItem from the store
    [[BNRItemStore sharedStore] removeItem:item];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES
                                                        completion:dismissBlock];
}

@end
