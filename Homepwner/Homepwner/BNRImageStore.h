//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Daniel Muñoz on 11/10/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

{
    NSMutableDictionary *dictionary;
}

+ (BNRImageStore *)sharedStore;

- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *)imageForKey:(NSString *)s;
- (void)deleteImageForKey:(NSString *)s;

@end
