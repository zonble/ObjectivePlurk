//
//  ObjectivePlurkTest.m
//  ObjectivePlurk
//
//  Created by zonble on 12/10/09.
//  Copyright 2009 Lithoglyph Inc.. All rights reserved.
//

#import "ObjectivePlurkTest.h"


@implementation ObjectivePlurkTest

- (void)testAPI
{
	STAssertNotNil(API_KEY, @"You must set your API key");
	[ObjectivePlurk sharedInstance].APIKey = API_KEY;
	[ObjectivePlurk sharedInstance].shouldWaitUntilDone = YES;
	
	// Users
	[[ObjectivePlurk sharedInstance] loginWithUsername:ACCOUNT password:PASSWD delegate:self];
	[[ObjectivePlurk sharedInstance] updateProfileWithOldPassword:PASSWD fullname:@"ObjectivePlurk Test" newPassword:nil email:@"example@exmaple.com" displayName:@"for unittest" privacy:OPPrivacyOnlyFriends dateOfBirth:nil delegate:self];
	[[ObjectivePlurk sharedInstance] updateProfileWithOldPassword:PASSWD fullname:@"Objective Plurk" newPassword:nil email:@"objplurk@zonble.net" displayName:@"Objective Plurk" privacy:OPPrivacyWorld dateOfBirth:nil delegate:self];
	
	[[ObjectivePlurk sharedInstance] retrievePollingMessagesWithDateOffset:[NSDate dateWithTimeIntervalSinceNow:-60 * 60 * 24 *3] delegate:self];

}

- (void)_validateMessage:(NSDictionary *)message
{
	STAssertNotNil([message valueForKey:@"content"], @"The field is required.");
	STAssertNotNil([message valueForKey:@"content_raw"], @"The field is required.");
	STAssertNotNil([message valueForKey:@"is_unread"], @"The field is required.");
	STAssertNotNil([message valueForKey:@"lang"], @"The field is required.");
	STAssertNotNil([message valueForKey:@"limited_to"], @"The field is required.");
	STAssertNotNil([message valueForKey:@"no_comments"], @"The field is required.");
	STAssertNotNil([message valueForKey:@"owner_id"], @"The field is required.");
	STAssertTrue([[message valueForKey:@"owner_id"] isKindOfClass:[NSNumber class]], @"owner_id should be an integer.");
	STAssertNotNil([message valueForKey:@"plurk_id"], @"The field is required.");
	STAssertTrue([[message valueForKey:@"plurk_id"] isKindOfClass:[NSNumber class]], @"plurk_id should be an integer.");
	STAssertNotNil([message valueForKey:@"plurk_type"], @"The field is required.");
	STAssertNotNil([message valueForKey:@"posted"], @"The field is required.");
	STAssertNotNil([message valueForKey:@"qualifier"], @"The field is required.");
	STAssertNotNil([message valueForKey:@"response_count"], @"The field is required.");
	STAssertNotNil([message valueForKey:@"responses_seen"], @"The field is required.");
	STAssertTrue([[message valueForKey:@"responses_seen"] isKindOfClass:[NSNumber class]], @"The field is required.");
	STAssertNotNil([message valueForKey:@"user_id"], @"The field is required.");
	STAssertTrue([[message valueForKey:@"user_id"] isKindOfClass:[NSNumber class]], @"The field is required.");
}

- (void)_validateUser:(NSDictionary *)user
{
	STAssertNotNil([user valueForKey:@"avatar"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"date_of_birth"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"full_name"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"gender"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"has_profile_image"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"id"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"karma"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"location"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"nick_name"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"timezone"], @"The field is required.");
}

- (void)_validateUserInfo:(NSDictionary *)user
{
	STAssertNotNil([user valueForKey:@"avatar"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"date_of_birth"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"display_name"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"full_name"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"gender"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"has_profile_image"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"id"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"karma"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"location"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"nick_name"], @"The field is required.");
	STAssertNotNil([user valueForKey:@"recruited"], @"The field is required.");	
	STAssertNotNil([user valueForKey:@"relationship"], @"The field is required.");		
	STAssertNotNil([user valueForKey:@"timezone"], @"The field is required.");		
	STAssertNotNil([user valueForKey:@"uid"], @"The field is required.");		
}

#pragma mark Users

- (void)plurk:(ObjectivePlurk *)plurk didLoggedIn:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	NSArray *messages = [result valueForKey:@"plurks"];
	STAssertNotNil(messages, @"There should be messages after loggin in.");
	for (NSDictionary *message in messages) {
		[self _validateMessage:message];
	}
	NSDictionary *users = [result valueForKey:@"plurks_users"];
	STAssertNotNil(users, @"There should be a user list after loggin in.");
	for (NSString *key in [users allKeys]) {
		NSDictionary *user = [users valueForKey:key];
		[self _validateUser:user];
	}	
	
	NSDictionary *userInfo = [result valueForKey:@"user_info"];
	STAssertNotNil(userInfo, @"There should be  after loggin in.");
	[self _validateUserInfo:userInfo];	
}
- (void)plurk:(ObjectivePlurk *)plurk didFailLoggingIn:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

- (void)plurk:(ObjectivePlurk *)plurk didUpdateProfile:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	NSString *successText = [result valueForKey:@"success_text"];
	STAssertNotNil(successText, @"success_text should exist.");		
	STAssertTrue([successText isEqualToString:@"ok"], @"success_text should be 'ok'.");
}
- (void)plurk:(ObjectivePlurk *)plurk didFailUpdatingProfile:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

#pragma mark Polling

- (void)plurk:(ObjectivePlurk *)plurk didRetrievePollingMessages:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	
	NSArray *messages = [result valueForKey:@"plurks"];
	STAssertNotNil(messages, @"There should be messages after loggin in.");
	for (NSDictionary *message in messages) {
		[self _validateMessage:message];
	}
	NSDictionary *users = [result valueForKey:@"plurk_users"];
	STAssertNotNil(users, @"There should be a user list after loggin in.");
	for (NSString *key in [users allKeys]) {
		NSDictionary *user = [users valueForKey:key];
		[self _validateUser:user];
	}	
	
}
- (void)plurk:(ObjectivePlurk *)plurk didFailRetrievingPollingMessages:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}



@end
