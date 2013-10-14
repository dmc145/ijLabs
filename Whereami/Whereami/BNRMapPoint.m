//
//  BNRMapPoint.m
//  Whereami
//
//  Created by Daniel Muñoz on 03/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import "BNRMapPoint.h"

@implementation BNRMapPoint

@synthesize coordinate, title, subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if(self){
        coordinate = c;
        [self setTitle:t];
        
        // Chap.5 Gold Challenge...
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_ES"];
        [dateFormatter setLocale:usLocale];
        
        NSDate *date = [[NSDate alloc] init];
        NSString *subt = [dateFormatter stringFromDate:date];
        
        [self setSubtitle:subt];
    }
    return self;
}

- (id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(41.540940, 2.448195)
                              title:@"HomeSweetHome"];
}

#pragma-mark Chap. 14

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:subtitle forKey:@"subtitle"];
    [aCoder encodeDouble:coordinate.latitude forKey:@"latitude"];
    [aCoder encodeDouble:coordinate.longitude forKey:@"longitude"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        [self setSubtitle:[aDecoder decodeObjectForKey:@"subtitle"]];
        [self setCoordinate:
         CLLocationCoordinate2DMake([aDecoder decodeDoubleForKey:@"latitude"],
                                    [aDecoder decodeDoubleForKey:@"longitude"])];
    }
    return self;
}

@end
