//
//  LoginTableViewController.h
//  SimplePlurk
//
//  Created by zonble on 12/12/09.
//

#import "ObjectivePlurk.h"

@class LoginTableViewController;

@protocol LoginTableViewControllerDelegate
- (void)loginController:(LoginTableViewController *)controller didLoggedIn:(NSDictionary *)result;
@end


@interface LoginTableViewController : UITableViewController <UITextFieldDelegate>
{
	id <LoginTableViewControllerDelegate> delegate;
	
	UITextField *loginNameField;
	UITextField *passwordField;
	UIButton *loginButton;
}

- (IBAction)login:(id)sender;
- (IBAction)cancel:(id)sender;

@property (assign) id <LoginTableViewControllerDelegate> delegate;

@end
