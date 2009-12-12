//
//  RootViewController.m
//  SimplePlurk
//
//  Created by zonble on 12/12/09.
//

#import "RootViewController.h"

@implementation RootViewController

- (void) dealloc
{
	[plurkArray release];
	[super dealloc];
}


- (IBAction)login:(id)sender
{
	LoginTableViewController *loginController = [[LoginTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	loginController.delegate = self;
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginController];
	[loginController release];
	[self presentModalViewController:navController animated:YES];
	[navController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	plurkArray = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [plurkArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSDictionary *plurk = [plurkArray objectAtIndex:indexPath.row];
	cell.textLabel.text = [plurk objectForKey:@"content_raw"];
	cell.detailTextLabel.text = [plurk valueForKeyPath:@"userDictionary.nick_name"];
    return cell;
}

- (void)loginController:(LoginTableViewController *)controller didLoggedIn:(NSDictionary *)result
{
	[plurkArray removeAllObjects];
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
		[plurkArray addObject:newDictionary];
	}
	[self.tableView reloadData];
	NSLog(@"plurkArray:%@", [plurkArray description]);
}


@end

