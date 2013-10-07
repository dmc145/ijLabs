//
//  WhereamiViewController.m
//  Whereami
//
//  Created by Daniel Muñoz on 30/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "WhereamiViewController.h"

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
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    NSLog(@"[UPDATE userLocation: %f, %f]", loc.latitude, loc.longitude);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region animated:YES];
}


@end
