//
//  AppDelegate.m
//  facebookLogin
//
//  Created by Jeon Gyuchan on 13. 6. 7..
//  Copyright (c) 2013년 baasio. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import <baas.io/Baas.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 여기!!
    [Baasio setApplicationInfo:@"<#Your baas.io ID#>" applicationName:@"<#Your Application ID#>"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Baasio user login with Facebook

NSString *const FBSessionStateChangedNotification = @"com.baasio:FBSessionStateChangedNotification";

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    return [FBSession openActiveSessionWithReadPermissions:nil
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,FBSessionState state,NSError *error) {
                                             
                                             [self sessionStateChanged:session state:state error:error];
                                         }];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState)state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                NSLog(@"User session found");
                
                //회원가입이 안되어있을 경우에 회원가입을 실행하세요./////////////////////////
                //facebook의 user정보를 baas.io가입에 사용합니다.
                
                NSString *accessToken = session.accessTokenData.accessToken;	//facebook Token
                [BaasioUser signInViaFacebook:accessToken error:&error];
                if (!error) {
                    //성공
                    NSLog(@"회원가입 성공");
                    
                } else {
                    //실패
                    NSLog(@"Error: %@", error.localizedDescription);
                }
                /////////////////////////////////////////////////////////////////////
                
                //회원가입이 되어있을경우 로그인을 실행하세요.//////////////////////////////////
                //tip.[NSUserDefaults standardUserDefaults]를 이용해 회원가입유무를 판단////
                //                [BaasioUser signUpViaFacebook:accessToken error:&error];
                //                if (!error) {
                //                    //성공
                //                    NSLog(@"Success");
                //                } else {
                //                    //실패
                //                    NSLog(@"Error: %@", error.localizedDescription);
                //                }
                /////////////////////////////////////////////////////////////////////
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:FBSessionStateChangedNotification
                                                        object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"취소"
                                                            message:@"facebook로그인 실패"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

@end