//
//  AppDelegate.h
//  MartRush
//
//  Created by 전 수열 on 11. 9. 30..
//  Copyright Joyfl 2011년. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
