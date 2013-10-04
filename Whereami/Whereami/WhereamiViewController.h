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

@interface WhereamiViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>

{
    CLLocationManager *locationManager;
    
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
}

/*
- (void) doSomethingWeird;
 */

@end
