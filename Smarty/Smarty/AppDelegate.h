//
//  AppDelegate.h
//  Smarty
//
//  Created by Abner Castro Aguilar on 11/12/14.
//  Copyright (c) 2014 Abner Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartyLocation.h"
#import <Parse/Parse.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//Core Location properties
@property (nonatomic, weak)SmartyLocation *singletonManager;

@end

