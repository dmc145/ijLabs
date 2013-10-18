//
//  JSONSerializable.h
//  Nerdfeed
//
//  Created by Daniel Muñoz on 17/10/13.
//  Copyright (c) 2013 net.infojobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONSerializable <NSObject>

- (void)readFromJSONDictionary:(NSDictionary *)d;

@end
