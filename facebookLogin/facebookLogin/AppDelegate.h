//
//  AppDelegate.h
//  facebookLogin
//
//  Created by Jeon Gyuchan on 13. 6. 7..
//  Copyright (c) 2013년 baasio. All rights reserved.
//

#import <UIKit/UIKit.h>

//Facebook 로그인을 위해 추가합니다.
#import <FacebookSDK/FacebookSDK.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

-(BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end
