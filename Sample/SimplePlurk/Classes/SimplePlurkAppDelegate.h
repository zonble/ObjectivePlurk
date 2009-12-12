//
//  SimplePlurkAppDelegate.h
//  SimplePlurk
//
//  Created by zonble on 12/12/09.
//  Copyright Lithoglyph Inc. 2009. All rights reserved.
//

#import "ObjectivePlurk.h"
#import "PlurkAPIKey.h"
#ifndef API_KEY
#define API_KEY @""
#endif


@interface SimplePlurkAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end

