//
//  SimplePlurkClientAppDelegate.h
//  SimplePlurkClient
//

#import <Cocoa/Cocoa.h>
#import "ObjectivePlurk.h"
#import "PlurkAPIKey.h"
#ifndef API_KEY
#define API_KEY @""
#endif

@interface SimplePlurkClientAppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *window;
	IBOutlet NSWindow *loginWindow;
	IBOutlet NSButton *loginButton;
	IBOutlet NSButton *cancelLoginButton;
	IBOutlet NSTextField *loginNameField;
	IBOutlet NSTextField *passwordField;
	IBOutlet NSProgressIndicator *loginProgressIndicator;
	
	IBOutlet NSArrayController *plurkArrayController;
	
	NSMutableString *loginName;
	NSMutableString *password;
}

- (void)setLoginUIEnabled:(BOOL)flag;

- (IBAction)showLoginSheet:(id)sender;
- (IBAction)loginAction:(id)sender;
- (IBAction)cancelLoginAction:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
