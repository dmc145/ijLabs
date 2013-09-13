//
//  AppDelegate.h
//  secondone
//
//  Created by Daniel Muñoz on 06/09/13.
//  Copyright (c) 2013 Daniel Muñoz. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
