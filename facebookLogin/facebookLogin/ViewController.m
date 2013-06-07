//
//  ViewController.m
//  facebookLogin
//
//  Created by Jeon Gyuchan on 13. 6. 7..
//  Copyright (c) 2013년 baasio. All rights reserved.
//

#import "ViewController.h"

//facebook method를 사용하기 위해 추가합니다.
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)facebookContect:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate openSessionWithAllowLoginUI:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
