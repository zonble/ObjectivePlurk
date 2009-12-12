//
//  RootViewController.h
//  SimplePlurk
//
//  Created by zonble on 12/12/09.
//

#import "ObjectivePlurk.h"
#import "LoginTableViewController.h"

@interface RootViewController : UITableViewController <LoginTableViewControllerDelegate>
{
	NSMutableArray *plurkArray;
}

- (IBAction)login:(id)sender;

@end
