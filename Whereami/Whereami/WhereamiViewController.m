//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Daniel Muñoz on 30/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "WhereamiViewController.h"
#import "BNRMapPoint.h"

NSString * const WhereamiMapTypePrefKey = @"WhereamiMapTypePrefKey";

@implementation WhereamiViewController

- (id)initWithCoder:(NSCoder *) aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        locationManager = [[CLLocationManager alloc] init];
        
        //[self doSomethingWeird];
        
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];

        /* Chap.4 Bronze Challenge */
        if ([locationManager distanceFilter]==kCLDistanceFilterNone) {
            NSLog(@"[DEFAULT distanceFilter: %f]", [locationManager distanceFilter]);
            [locationManager setDistanceFilter:50];
            NSLog(@"[NEW distanceFilter: %f]", [locationManager distanceFilter]);
        }
        
        /* In Chap.5 with MKMapView we don't need this...
        [locationManager startUpdatingLocation];
         */
        
        /* Chap.4 Silver Challenge
        if ([locationManager headingAvailable]) {
            [locationManager startUpdatingHeading];
        } else {
            NSLog(@"[UNAVAILABLE heading]");
        }
        */
        
    }
    return self;
}

#pragma-mark Chap.4

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"[NEW location: %@]", newLocation);
    
    // For Chap.5...
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    if (t < -180) {
        return;
    }
    [self foundLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"[NEW heading: %@]", newHeading);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"[ERROR Could not find location: %@]", error);
}

/*
 CLLocationManager’s delegate property is not a strong reference. But it is not a weak reference, either. To maintain backwards-compatibility with non-ARC versions of iOS, delegate properties are __unsafe_unretained.
 
 Because delegate is unsafe unretained instead of weak, it is not automatically set to nil when the object it points to is destroyed
 
 It is a little deceptive on our part to have you implement dealloc for WhereamiViewController. Why? Because the WhereamiViewController will never be destroyed in this application – the dealloc method you just implemented will never be called. The Whereami application needs the WhereamiViewController from beginning to end, so the WhereamiViewController always has an owner.
 */
- (void)dealloc
{
    [locationManager setDelegate:nil];
}

/* Debugging exceptions...
- (void)doSomethingWeird
{
    NSLog(@"Line 1");
    NSLog(@"Line 2");
    NSLog(@"Line 3");
}
 */

#pragma-mark Chap.5

- (void)viewDidLoad
{
    [worldView setShowsUserLocation:YES];
    
    NSInteger mapTypeValue = [[NSUserDefaults standardUserDefaults]
                              integerForKey:WhereamiMapTypePrefKey];
    
    // Update the UI
    [segmentedControl setSelectedSegmentIndex:mapTypeValue];
    
    // Update the map
    [self changeMapType:segmentedControl];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    NSLog(@"[UPDATE userLocation: %f, %f]", loc.latitude, loc.longitude);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self findLocation];
    [textField resignFirstResponder];
    
    return YES;
}

- (void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];
    
    // Add to map view
    [worldView addAnnotation:mp];
    
    // Zoom...
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
 
    // UI reset...
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}

#pragma-mark Chap. 18

- (IBAction)changeMapType:(id)sender
{
    /* Chap.5 Silver Challenge
    NSLog(@"\n...doChangeMapType...\nfrom %u to %ld", [worldView mapType], (long)[segmentedControl selectedSegmentIndex]);
    [worldView setMapType:[segmentedControl selectedSegmentIndex]];
     */
    
    [[NSUserDefaults standardUserDefaults] setInteger:[sender selectedSegmentIndex]
                                               forKey:WhereamiMapTypePrefKey];

    
    switch ([sender selectedSegmentIndex])
    {
        case 0:
        {
            [worldView setMapType:MKMapTypeStandard];
        } break;
        case 1:
        {
            [worldView setMapType:MKMapTypeSatellite];
        } break;
        case 2:
        {
            [worldView setMapType:MKMapTypeHybrid];
        } break;
    }
}

/*
 override the class method initialize to register defaults, including setting the map type preference to 1
 */
+ (void)initialize
{
    NSDictionary *defaults = [NSDictionary
                              dictionaryWithObject:[NSNumber numberWithInt:1]
                              forKey:WhereamiMapTypePrefKey];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}


@end
