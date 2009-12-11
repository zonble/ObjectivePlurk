//
//  SimplePlurkClientAppDelegate.m
//  SimplePlurkClient
//

#import "SimplePlurkClientAppDelegate.h"

@implementation SimplePlurkClientAppDelegate

- (void)dealloc
{
	[loginName release];
	[password release];
	[super dealloc];
}

- (id)init
{
	self = [super init];
	if (self != nil) {
		loginName = [[NSMutableString alloc] init];
		password = [[NSMutableString alloc] init];
	}
	return self;
}

- (void)awakeFromNib
{
	[loginWindow setDefaultButtonCell:[loginButton cell]];
	[loginProgressIndicator setHidden:YES];
}

- (void)setLoginUIEnabled:(BOOL)flag
{
	[loginButton setEnabled:flag];
	[passwordField setEnabled:flag];
	[loginNameField setEditable:flag];
	[passwordField setEditable:flag];
}

- (IBAction)showLoginSheet:(id)sender
{
	if ([self.window attachedSheet]) {
		return;
	}
	[NSApp beginSheet:loginWindow modalForWindow:self.window modalDelegate:nil didEndSelector:NULL contextInfo:NULL];
}

- (IBAction)loginAction:(id)sender
{
	[self setLoginUIEnabled:NO];
	[[ObjectivePlurk sharedInstance] loginWithUsername:loginName password:password delegate:self userInfo:nil];
	[loginProgressIndicator setHidden:NO];
	[loginProgressIndicator startAnimation:self];
}

- (IBAction)cancelLoginAction:(id)sender
{
	[NSApp endSheet:loginWindow];
	[loginWindow orderOut:self];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
	[ObjectivePlurk sharedInstance].APIKey = API_KEY;
	[self showLoginSheet:self];
}

- (void)plurk:(ObjectivePlurk *)plurk didLoggedIn:(NSDictionary *)result
{
	[loginProgressIndicator setHidden:YES];
	[loginProgressIndicator stopAnimation:self];
	[self cancelLoginAction:self];
	[self setLoginUIEnabled:YES];
//	NSLog(@"result:%@", [result description]);
	
	NSMutableArray *plurks = [NSMutableArray array];
	NSArray *inPlurks = [result valueForKey:@"plurks"];
	NSDictionary *inUsers = [result valueForKey:@"plurks_users"];
	for (NSDictionary *d in inPlurks) {
		NSString *ownerID = [d valueForKey:@"owner_id"];
		if ([ownerID isKindOfClass:[NSNumber class]]) {
			ownerID = [(NSNumber *)ownerID stringValue];
		}
		NSDictionary *userDictionary = [inUsers valueForKey:ownerID];
		NSMutableDictionary *newDictionary = [NSMutableDictionary dictionaryWithDictionary:d];
		[newDictionary setValue:[[userDictionary copy] autorelease] forKey:@"userDictionary"];
		[plurks addObject:newDictionary];
	}
//	NSLog(@"plurks:%@", [plurks description]);
	[plurkArrayController setContent:plurks];
	
}
- (void)plurk:(ObjectivePlurk *)plurk didFailLoggingIn:(NSError *)error
{
	[self setLoginUIEnabled:YES];
	[loginProgressIndicator setHidden:YES];
	[loginProgressIndicator stopAnimation:self];
	NSRunAlertPanelRelativeToWindow([error localizedDescription], @"", @"OK", nil, nil, loginWindow);
}



@synthesize window;


@end
