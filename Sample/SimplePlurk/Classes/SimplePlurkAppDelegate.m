//
//  SimplePlurkAppDelegate.m
//  SimplePlurk
//
//  Created by zonble on 12/12/09.
//  Copyright Lithoglyph Inc. 2009. All rights reserved.
//

#import "SimplePlurkAppDelegate.h"
#import "RootViewController.h"

@implementation SimplePlurkAppDelegate

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[navigationController release];
	[window release];
	[super dealloc];
}

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	[ObjectivePlurk sharedInstance].APIKey = API_KEY;
	
	window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	RootViewController *rootController = [[[RootViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
	navigationController = [[UINavigationController alloc] initWithRootViewController:rootController];
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	
	rootController = [navigationController.viewControllers objectAtIndex:0];
	[rootController login:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
	// Save data if appropriate
}

@synthesize window;
@synthesize navigationController;


@end

