//
//  ObjectivePlurkTest.m
//  ObjectivePlurk
//
//  Created by zonble on 12/10/09.
//  Copyright 2009 Lithoglyph Inc.. All rights reserved.
//

#import "ObjectivePlurkTest.h"


NS_INLINE NSString *GenerateUUIDString()
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
	
#if MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_4
	return (NSString *)[(NSString*)uuidStr autorelease];
#else
	return (NSString *)[NSMakeCollectable(uuidStr) autorelease];
#endif
}


@implementation ObjectivePlurkTest

- (void) dealloc
{
	[currentUserInfo release];
	[super dealloc];
}


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
	
	[[ObjectivePlurk sharedInstance] addNewMessageWithContent:[NSString stringWithFormat:@"Unittest - new: %@", GenerateUUIDString()] qualifier:@":" othersCanComment:YES lang:@"en" limitToUsers:nil delegate:self];
	[[ObjectivePlurk sharedInstance] retrieveMessagesWithDateOffset:nil limit:0 user:[currentUserInfo valueForKey:@"uid"] isResponded:NO isPrivate:NO delegate:self];

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

- (void)_validateResponse:(NSDictionary *)response
{
	STAssertNotNil([response valueForKey:@"content"], @"The field is required.");
	STAssertNotNil([response valueForKey:@"content_raw"], @"The field is required.");
	STAssertNotNil([response valueForKey:@"id"], @"The field is required.");
	STAssertNotNil([response valueForKey:@"plurk_id"], @"The field is required.");
	STAssertNotNil([response valueForKey:@"posted"], @"The field is required.");
	STAssertNotNil([response valueForKey:@"qualifier"], @"The field is required.");
	STAssertNotNil([response valueForKey:@"user_id"], @"The field is required.");
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
	currentUserInfo = [userInfo retain];
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

#pragma mark Timeline

- (void)plurk:(ObjectivePlurk *)plurk didRetrieveMessage:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	NSDictionary *message = [result valueForKey:@"plurk"];
	NSDictionary *user = [result valueForKey:@"user"];
	[self _validateMessage:message];
	[self _validateUser:user];
}
- (void)plurk:(ObjectivePlurk *)plurk didFailRetrievingMessage:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

- (void)plurk:(ObjectivePlurk *)plurk didRetrieveMessages:(NSDictionary *)result
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
	if ([messages count]) {
		NSDictionary *firstMessage = [messages objectAtIndex:0];
		[plurk retrieveMessageWithMessageIdentifier:[firstMessage valueForKey:@"plurk_id"] delegate:self];
	}
	NSArray *messageIDs = [messages valueForKeyPath:@"plurk_id"];
	
	[plurk muteMessagesWithMessageIdentifiers:messageIDs delegate:self];
	[plurk unmuteMessagesWithMessageIdentifiers:messageIDs delegate:self];
	[plurk markMessagesAsReadWithMessageIdentifiers:messageIDs delegate:self];
}
- (void)plurk:(ObjectivePlurk *)plurk didFailRetrievingMessages:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

- (void)plurk:(ObjectivePlurk *)plurk didMuteMessages:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	NSString *successText = [result valueForKey:@"success_text"];
	STAssertNotNil(successText, @"success_text should exist.");		
	STAssertTrue([successText isEqualToString:@"ok"], @"success_text should be 'ok'.");	
}
- (void)plurk:(ObjectivePlurk *)plurk didFailMutingMessages:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

- (void)plurk:(ObjectivePlurk *)plurk didUnmuteMessages:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	NSString *successText = [result valueForKey:@"success_text"];
	STAssertNotNil(successText, @"success_text should exist.");		
	STAssertTrue([successText isEqualToString:@"ok"], @"success_text should be 'ok'.");	
}
- (void)plurk:(ObjectivePlurk *)plurk didFailUnmutingMessages:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

- (void)plurk:(ObjectivePlurk *)plurk didMarkMessagesAsRead:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	NSString *successText = [result valueForKey:@"success_text"];
	STAssertNotNil(successText, @"success_text should exist.");		
	STAssertTrue([successText isEqualToString:@"ok"], @"success_text should be 'ok'.");	
}
- (void)plurk:(ObjectivePlurk *)plurk didFailMarkingMessagesAsRead:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

- (void)plurk:(ObjectivePlurk *)plurk didAddMessage:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	[self _validateMessage:result];
	[plurk editMessageWithMessageIdentifier:[result valueForKey:@"plurk_id"] content:[NSString stringWithFormat:@"Unittest - edit: %@", GenerateUUIDString()] delegate:self];
}
- (void)plurk:(ObjectivePlurk *)plurk didFailAddingMessage:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

- (void)plurk:(ObjectivePlurk *)plurk didEditMessage:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	[self _validateMessage:result];
	for (NSInteger i = 0; i < 5; i++) {
		[plurk addNewResponseWithContent:[NSString stringWithFormat:@"Unittest - response: %@", GenerateUUIDString()] qualifier:@":" toMessages:[result valueForKey:@"plurk_id"] delegate:self];
	}
	[plurk retrieveResponsesWithMessageIdentifier:[result valueForKey:@"plurk_id"] delegate:self];
}
- (void)plurk:(ObjectivePlurk *)plurk didFailEditingMessage:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

#pragma mark Responses

- (void)plurk:(ObjectivePlurk *)plurk didRetrieveResponses:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	NSArray *responses = [result valueForKey:@"responses"];
	for (NSDictionary *response in responses) {
		[self _validateResponse:response];
	}
	if ([responses count]) {
		NSDictionary *response = [responses objectAtIndex:0];
		[plurk deleteResponseWithMessageIdentifier:[response valueForKey:@"plurk_id"] responseIdentifier:[response valueForKey:@"id"] delegate:self];
	}
}
- (void)plurk:(ObjectivePlurk *)plurk didFailRetrievingResponses:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

- (void)plurk:(ObjectivePlurk *)plurk didAddResponse:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	[self _validateResponse:result];
}
- (void)plurk:(ObjectivePlurk *)plurk didFailAddingResponse:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}

- (void)plurk:(ObjectivePlurk *)plurk didDeleteResponse:(NSDictionary *)result
{
//	STFail(@"%s %@", __PRETTY_FUNCTION__, [result description]);
	NSString *successText = [result valueForKey:@"success_text"];
	STAssertNotNil(successText, @"success_text should exist.");		
	STAssertTrue([successText isEqualToString:@"ok"], @"success_text should be 'ok'.");		
}
- (void)plurk:(ObjectivePlurk *)plurk didFailDeletingResponse:(NSError *)error
{
	STFail(@"%s %@", __PRETTY_FUNCTION__, [error localizedDescription]);
}





@end
