//
//  LoginTableViewController.m
//  SimplePlurk
//
//  Created by zonble on 12/12/09.
//

#import "LoginTableViewController.h"


@implementation LoginTableViewController

- (void)removeOutletsAndControls_LoginTableViewController
{
	[loginNameField release];
	[passwordField release];
}

- (void)dealloc 
{
	[self removeOutletsAndControls_LoginTableViewController];
    [super dealloc];
}
- (void)viewDidUnload
{
	[super viewDidUnload];
	[self removeOutletsAndControls_LoginTableViewController];
}

#pragma mark -
#pragma mark UIViewContoller Methods

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.title = @"Login";
	self.tableView.scrollEnabled = NO;
	loginNameField = [[UITextField alloc] initWithFrame:CGRectMake(120, 12, 180, 30)];
	loginNameField.autocorrectionType = UITextAutocorrectionTypeNo;
	loginNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;	
	loginNameField.placeholder = @"Your Login Name";
	loginNameField.returnKeyType = UIReturnKeyNext;
	loginNameField.delegate = self;
	loginNameField.textColor = [UIColor blueColor];
	passwordField = [[UITextField alloc] initWithFrame:CGRectMake(120, 12, 180, 30)];
	passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
	passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	passwordField.secureTextEntry = YES;
	passwordField.placeholder = @"Your Password";
	passwordField.returnKeyType = UIReturnKeyDone;
	passwordField.delegate = self;
	passwordField.textColor = [UIColor blueColor];
	
	loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	loginButton.frame = CGRectMake(20, 20, 280, 40);
	[loginButton setTitle:@"Login" forState:UIControlStateNormal];
	[loginButton setTitle:@"Login" forState:UIControlStateHighlighted];
	[loginButton setTitle:@"Login" forState:UIControlStateDisabled];
	[loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
	self.tableView.tableFooterView = loginButton;
	
	UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	self.navigationItem.rightBarButtonItem = cancelItem;
	[cancelItem release];
}
- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
	[loginNameField becomeFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated 
{
	[super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated 
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}


- (IBAction)login:(id)sender
{
	NSString *loginName = loginNameField.text;
	NSString *password = passwordField.text;
	[[ObjectivePlurk sharedInstance] loginWithUsername:loginName password:password delegate:self userInfo:nil];
}
- (IBAction)cancel:(id)sender
{
	[self.navigationController.parentViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
	switch (indexPath.row) {
		case 0:
			cell.textLabel.text = @"Login Name";
			[cell addSubview:loginNameField];
			break;
		case 1:
			cell.textLabel.text = @"Password";
			[cell addSubview:passwordField];
			break;
			
		default:
			break;
	}
    return cell;
}

- (void)plurk:(ObjectivePlurk *)plurk didLoggedIn:(NSDictionary *)result
{	
	if (delegate) {
		[delegate loginController:self didLoggedIn:result];
	}
	[self.navigationController.parentViewController dismissModalViewControllerAnimated:YES];
}
- (void)plurk:(ObjectivePlurk *)plurk didFailLoggingIn:(NSError *)error
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login failed!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

@synthesize delegate;

@end

