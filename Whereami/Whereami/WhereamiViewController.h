//
//  WhereamiViewController.h
//  Whereami
//
//  Created by Daniel Muñoz on 30/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>

{
    CLLocationManager *locationManager;
    
    // For Chap.5...
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
    
    __weak IBOutlet UISegmentedControl *segmentedControl;
}

/*
- (void) doSomethingWeird;
 */

- (void)findLocation;
- (void)foundLocation:(CLLocation *)loc;

/* Chap.5 Silver */
- (IBAction)changeMapType:(id)sender;

@end
