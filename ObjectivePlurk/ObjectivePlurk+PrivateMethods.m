//
// ObjectivePlurk+PrivateMethods.m
// ObjectivePlurk
// 
// Copyright (c) 2009 Weizhong Yang (http://zonble.net)
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of Weizhong Yang (zonble) nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY WEIZHONG YANG ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL WEIZHONG YANG BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <CommonCrypto/CommonDigest.h>
#import "ObjectivePlurk+PrivateMethods.h"

NSString *const ObjectivePlurkCookiePreferenceName = @"ObjectivePlurkCookiePreferenceName";
NSString *const ObjectivePlurkUserInfoPreferenceName = @"ObjectivePlurkUserInfoPreferenceName";

NSString *const ObjectivePlurkAPIURLString = @"http://www.plurk.com";
NSString *const ObjectivePlurkErrorDomain = @"ObjectivePlurkErrorDomain";
NSString *const ObjectivePlurkUploadTempFilenamePrefix = @"ObjectivePlurk";

NSString *const OPAlertFriendshipRequestType = @"friendship_request";
NSString *const OPAlertFriendshipPendingType = @"friendship_pending";
NSString *const OPAlertNewFanType = @"new_fan";
NSString *const OPAlertFriendshipAcceptedType = @"friendship_accepted";
NSString *const OPAlertNewFriendType = @"new_friend";

NSString *const OPLoginAction = @"/API/Users/login";
NSString *const OPUpdatePictureAction = @"/API/Users/updatePicture";
NSString *const OPUpdateProfileAction = @"/API/Users/update";

NSString *const OPRetrivePollingMessageAction = @"/API/Polling/getPlurks";

NSString *const OPRetriveMessageAction = @"/API/Timeline/getPlurk";
NSString *const OPRetriveMessagesAction = @"/API/Timeline/getPlurks";
NSString *const OPRetriveUnreadMessagesAction = @"/API/Timeline/getUnreadPlurks";
NSString *const OPMuteMessagesAction = @"/API/Timeline/mutePlurks";
NSString *const OPUnmuteMessagesAction = @"/API/Timeline/unmutePlurks";
NSString *const OPMarkMessageAsReadAction = @"/API/Timeline/markAsRead";
NSString *const OPAddMessageAction = @"/API/Timeline/plurkAdd";
NSString *const OPUploadPictureAction = @"/API/Timeline/uploadPicture";
NSString *const OPDeleteMessageAction = @"/API/Timeline/plurkDelete";
NSString *const OPEditMessageAction = @"/API/Timeline/plurkEdit";

NSString *const OPRetriveResponsesAction = @"/API/Responses/get";
NSString *const OPAddResponsesAction = @"/API/Responses/responseAdd";
NSString *const OPDeleteResponsesAction = @"/API/Responses/responseDelete";

NSString *const OPRetrieveMyProfileAction = @"/API/Profile/getOwnProfile";
NSString *const OPRetrievePublicProfileAction = @"/API/Profile/getPublicProfile";

NSString *const OPRetriveFriendAction = @"/API/FriendsFans/getFriendsByOffset";
NSString *const OPRetriveFansAction = @"/API/FriendsFans/getFansByOffset";
NSString *const OPRetriveFollowingAction = @"/API/FriendsFans/getFollowingByOffset";
NSString *const OPBecomeFriendAction = @"/API/FriendsFans/becomeFriend";
NSString *const OPRemoveFriendshipAction = @"/API/FriendsFans/becomeFriend";
NSString *const OPBecomeFanAction = @"/API/FriendsFans/becomeFan";
NSString *const OPSetFollowingAction = @"/API/FriendsFans/setFollowing";
NSString *const OPRetrieveFriendsCompletionListAction = @"/API/FriendsFans/getCompletion";

NSString *const OPRetriveActiveAlertsAction = @"/API/Alerts/getActive";
NSString *const OPRetriveHistoryAction = @"/API/Alerts/getHistory";
NSString *const OPAddAsFanAction = @"/API/Alerts/addAsFan";
NSString *const OPAddAllAsFanAction = @"/API/Alerts/addAllAsFan";
NSString *const OPAddAsFriendAction = @"/API/Alerts/addAsFriend";
NSString *const OPAddAllAsFriendAction = @"/API/Alerts/addAllAsFriends";
NSString *const OPDenyFriendshipAction = @"/API/Alerts/denyFriendship";
NSString *const OPRemoveNotificationAction = @"/API/Alerts/removeNotification";

NSString *const OPSearchMessagesAction = @"/API/PlurkSearch/search";
NSString *const OPSearchUsersAction = @"/API/UserSearch/search";

NSString *const OPRetrieveEmoticonsAction = @"/API/Emoticons/get";

NSString *const OPRetrieveBlockedUsersAction = @"/API/Blocks/get";
NSString *const OPBlockuUserAction = @"/API/Blocks/block";
NSString *const OPUnblockuUserAction = @"/API/Blocks/unblock";

NSString *const OPRetrieveCliquesAction = @"/API/Cliques/get_cliques";
NSString *const OPCreateNewCliqueAction = @"/API/Cliques/create_clique";
NSString *const OPRetrieveCliqueAction = @"/API/Cliques/get_clique";
NSString *const OPRenameCliqueAction = @"/API/Cliques/rename_clique";
NSString *const OPDeleteCliqueAction = @"/API/Cliques/delete_clique";
NSString *const OPAddUserToCliqueAction = @"/API/Cliques/add";
NSString *const OPRemoveUserFromCliqueAction = @"/API/Cliques/remove";

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

// http://developer.apple.com/macosx/uniformtypeidentifiers.html

NSString *mimeTypeForExtension(NSString *ext)
{	
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_2_2
	return @"application/octet-stream";
#else
	NSString* mimeType = nil;

    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (CFStringRef)ext, NULL);
    if (!UTI) return nil;

    CFStringRef registeredType = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
    if (!registeredType) {
        if ([ext isEqualToString:@"m4v"]) {
			mimeType = @"video/x-m4v";
		}
        else if ([ext isEqualToString:@"m4p"]) {
			mimeType = @"audio/x-m4p";
		}
    }
	else {
		mimeType = (NSString *)registeredType;
		[mimeType autorelease];
	}

    CFRelease(UTI);
    return mimeType;

#endif
}


@implementation ObjectivePlurk(PrivateMethods)


- (BOOL)uploadFile:(NSString *)inPath suggestedFilename:(NSString *)inFilename requestURL:(NSURL *)requestURL multipartName:(NSString *)multipartName sessionInfo:(NSDictionary *)sessionInfo
{
    if ([_request isRunning] || ![self isLoggedIn]) {
        return NO;
    }

	NSString *filename = [inFilename length] ? inFilename : [inPath lastPathComponent];
	NSAssert([filename length], @"Must have the last path component");

	NSInputStream *sourceStream = [NSInputStream inputStreamWithFileAtPath:inPath];
	NSAssert1(sourceStream, @"File not exists or cannot open stream: %@", inPath);

	NSString *boundary = @"---------------------------4ffac661b35420acd1bcceb11c1f610b";
    NSMutableData *postData = [NSMutableData data];
    
    NSString *api_key = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"api_key\"\r\n\r\n%@", APIKey];
    NSString *boundaryString = [NSString stringWithFormat:@"\r\n--%@\r\n", boundary];
    NSString *boundaryStringFinal = [NSString stringWithFormat:@"\r\n--%@--\r\n", boundary];
	
    [postData appendData:[boundaryString dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[api_key dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[boundaryString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", multipartName, filename] dataUsingEncoding:NSUTF8StringEncoding]];
	NSString *mimeType = mimeTypeForExtension([filename pathExtension]);
	[postData appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", mimeType] dataUsingEncoding:NSUTF8StringEncoding]];
	NSData *photo = [NSData dataWithContentsOfFile:inPath];
	[postData appendData:photo];    
    [postData appendData:[boundaryStringFinal dataUsingEncoding:NSUTF8StringEncoding]];
			
	NSString *tempContentType = [[_request.contentType copy] autorelease];
	NSString *multiPartContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
	_request.contentType = multiPartContentType;
	_request.sessionInfo = sessionInfo;

	BOOL result = [_request performMethod:LFHTTPRequestPOSTMethod onURL:requestURL withData:postData];
	_request.contentType = tempContentType;
	
	return result;
}

- (NSString *)GETStringFromDictionary:(NSDictionary *)inDictionary
{
	NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:inDictionary];
	[d setObject:APIKey forKey:@"api_key"];

	NSMutableString *s = [NSMutableString string];
	for (NSString *key in [d allKeys]) {
		if ([key isEqual:[[d allKeys] objectAtIndex:0]]) {
			[s setString:@"?"];
		}
		NSMutableString *v = [NSMutableString stringWithString:[[d valueForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		[v replaceOccurrencesOfString:@"&" withString:@"%26" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"+" withString:@"%2B" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"," withString:@"%2C" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"/" withString:@"%2F" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@":" withString:@"%3A" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@";" withString:@"%3B" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"=" withString:@"%3D" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"?" withString:@"%3F" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"@" withString:@"%40" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@" " withString:@"%20" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"\t" withString:@"%09" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"#" withString:@"%23" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"<" withString:@"%3C" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@">" withString:@"%3E" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"\"" withString:@"%22" options:0 range:NSMakeRange(0, [v length])];
		[v replaceOccurrencesOfString:@"\n" withString:@"%0A"options:0 range:NSMakeRange(0, [v length])];
		[s appendFormat:@"%@=%@", key, v];
		if (![key isEqual:[[d allKeys] lastObject]]) {
			[s appendString:@"&"];
		}
	}
	return s;
}

- (void)runQueue
{
	if ([_queue count]) {
		id sessionInfo = [_queue objectAtIndex:0];
		NSURL *URL = [sessionInfo objectForKey:@"URL"];
		[_request setSessionInfo:sessionInfo];
		[_request performMethod:LFHTTPRequestGETMethod onURL:URL withData:nil];
		[_queue removeObject:sessionInfo];
	}
}

- (void)addRequestWithAction:(NSString *)actionName arguments:(NSDictionary *)arguments filepath:(NSString *)filepath multipartName:(NSString *)multipartName delegate:(id)delegate userInfo:(NSDictionary *)userInfo
{
	NSString *URLString = [ObjectivePlurkAPIURLString stringByAppendingString:actionName];
	URLString = [URLString stringByAppendingString:[self GETStringFromDictionary:arguments]];
	NSURL *URL = [NSURL URLWithString:URLString];
	NSMutableDictionary *sessionInfo = [NSMutableDictionary dictionary];
	[sessionInfo setObject:actionName forKey:@"actionName"];
	[sessionInfo setObject:URL forKey:@"URL"];
	if (delegate) [sessionInfo setObject:delegate forKey:@"delegate"];
	if (arguments) [sessionInfo setObject:arguments forKey:@"arguments"];
	if (userInfo) [sessionInfo setObject:userInfo forKey:@"userInfo"];
	
	if (![actionName isEqualToString:OPLoginAction]) {
		if (_expirationDate && [_expirationDate compare:[NSDate date]] != NSOrderedDescending) {
			[_request setSessionInfo:sessionInfo];
			[self httpRequest:_request didFailWithError:@"Session expired."];
		}		
	}	
	
	
	if (filepath) {
		[_request cancelWithoutDelegateMessage];
		[self uploadFile:filepath suggestedFilename:[filepath lastPathComponent] requestURL:URL multipartName:multipartName sessionInfo:sessionInfo];
	}
	else if (![_queue count] && ![_request isRunning]) {
		[_request setSessionInfo:sessionInfo];
		[_request performMethod:LFHTTPRequestGETMethod onURL:URL withData:nil];
	}
	else {
		if ([_queue count]) {
			[_queue insertObject:sessionInfo atIndex:0];
		}
		else {
			[_queue addObject:sessionInfo];
		}
	}
}

- (void)addRequestWithAction:(NSString *)actionName arguments:(NSDictionary *)arguments delegate:(id)delegate userInfo:(NSDictionary *)userInfo
{
	[self addRequestWithAction:actionName arguments:arguments filepath:nil multipartName:nil delegate:delegate userInfo:userInfo];
}

- (NSDate *)_expirationDateFromCookieString:(NSString *)cookie
{
	if (![cookie length]) {
		return nil;
	}
	NSRange range = [cookie rangeOfString:@"expires="];		
	NSUInteger dateStringStart = range.location;
	if (dateStringStart == NSNotFound) {
		return nil;
	}
	NSString *dateString = [cookie substringFromIndex:dateStringStart + range.length];
	NSUInteger dateStringEnd = [dateString rangeOfString:@";" options:NSLiteralSearch].location;
	dateString = [dateString substringToIndex:dateStringEnd];

	NSDateFormatter *cookieExpireDateFormatter = [[NSDateFormatter alloc] init];
	[cookieExpireDateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	[cookieExpireDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[cookieExpireDateFormatter setDateFormat:@"EEE, dd-MMM-yyyy HH:mm:ss zzz"];
	NSDate *date = [cookieExpireDateFormatter dateFromString:dateString];
	[cookieExpireDateFormatter release];
	
	return date;
}

- (void)loginDidSuccess:(LFHTTPRequest *)request
{
	NSString *s = [[[NSString alloc] initWithData:[request receivedData] encoding:NSUTF8StringEncoding] autorelease];
	NSDictionary *result = [NSDictionary dictionaryWithJSONString:s];
	NSDictionary *sessionInfo = [request sessionInfo];

	if ([result valueForKey:@"error_text"]) {
		NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
		[dictionary setObject:sessionInfo forKey:@"sessionInfo"];
		[dictionary setObject:[result valueForKey:@"error_text"] forKey:NSLocalizedDescriptionKey];
		NSError *error = [NSError errorWithDomain:ObjectivePlurkErrorDomain code:0 userInfo:dictionary];
		[self loginDidFail:error];
		return;
	}

	if (_receivedHeader == nil) {
		return;
	}

	NSString *cookie = [_receivedHeader valueForKey:@"Set-Cookie"];
	NSDate *date = [self _expirationDateFromCookieString:cookie];
	id tmp = _expirationDate;
	_expirationDate = [date retain];
	[tmp release];
	[[NSUserDefaults standardUserDefaults] setObject:cookie forKey:ObjectivePlurkCookiePreferenceName];
	
	NSDictionary *requestHeader = [NSDictionary dictionaryWithObjectsAndKeys:cookie, @"Cookie", nil];
	_request.requestHeader = requestHeader;

	id delegate = [sessionInfo valueForKey:@"delegate"];
	if ([result valueForKey:@"user_info"]) {
		NSMutableDictionary *userInfo = [result valueForKey:@"user_info"];
		self.currentUserInfo = userInfo;
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
		[[NSUserDefaults standardUserDefaults] setValue:data forKey:ObjectivePlurkUserInfoPreferenceName];
		
	}

	if ([delegate respondsToSelector:@selector(plurk:didLoggedIn:)]) {
		[delegate plurk:self didLoggedIn:result];
	}
}

- (void)loginDidFail:(NSError *)error
{
	NSDictionary *sessionInfo = [[error userInfo] valueForKey:@"sessionInfo"];
	id delegate = [sessionInfo valueForKey:@"delegate"];
	if ([delegate respondsToSelector:@selector(plurk:didFailLoggingIn:)]) {
		[delegate plurk:self didFailLoggingIn:error];
	}
}

- (void)commonAPIDidSuccess:(NSDictionary *)sessionInfo
{
	NSDictionary *result = [sessionInfo valueForKey:@"result"];

	if ([result valueForKey:@"error_text"]) {
		NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
		[dictionary setObject:sessionInfo forKey:@"sessionInfo"];
		[dictionary setObject:[result valueForKey:@"error_text"] forKey:NSLocalizedDescriptionKey];
		NSError *error = [NSError errorWithDomain:ObjectivePlurkErrorDomain code:0 userInfo:dictionary];
		[self commonAPIDidFail:error];
		return;
	}

	id delegate = [sessionInfo valueForKey:@"delegate"];
	NSString *actionName = [sessionInfo valueForKey:@"actionName"];

	if ([actionName isEqualToString:OPUpdatePictureAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didUpdatePicture:)]) {
			[delegate plurk:self didUpdatePicture:result];
		}
	}
	else if ([actionName isEqualToString:OPUpdateProfileAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didUpdateProfile:)]) {
			[delegate plurk:self didUpdateProfile:result];
		}
	}
	else if ([actionName isEqualToString:OPRetrivePollingMessageAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrievePollingMessages:)]) {
			[delegate plurk:self didRetrievePollingMessages:result];
		}
	}
	else if ([actionName isEqualToString:OPRetriveMessageAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveMessage:)]) {
			[delegate plurk:self didRetrieveMessage:result];
		}
	}
	else if ([actionName isEqualToString:OPRetriveMessagesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveMessages:)]) {
			[delegate plurk:self didRetrieveMessages:result];
		}
	}
	else if ([actionName isEqualToString:OPRetriveUnreadMessagesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveUnreadMessages:)]) {
			[delegate plurk:self didRetrieveUnreadMessages:result];
		}
	}
	else if ([actionName isEqualToString:OPMuteMessagesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didMuteMessages:)]) {
			[delegate plurk:self didMuteMessages:result];
		}
	}
	else if ([actionName isEqualToString:OPUnmuteMessagesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didUnmuteMessages:)]) {
			[delegate plurk:self didUnmuteMessages:result];
		}
	}
	else if ([actionName isEqualToString:OPMarkMessageAsReadAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didMarkMessagesAsRead:)]) {
			[delegate plurk:self didMarkMessagesAsRead:result];
		}
	}
	else if ([actionName isEqualToString:OPAddMessageAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didAddMessage:)]) {
			[delegate plurk:self didAddMessage:result];
		}
	}
	else if ([actionName isEqualToString:OPUploadPictureAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didUploadPicture:)]) {
			[delegate plurk:self didUploadPicture:result];
		}
	}
	else if ([actionName isEqualToString:OPDeleteMessageAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didDeleteMessage:)]) {
			[delegate plurk:self didDeleteMessage:result];
		}
	}
	else if ([actionName isEqualToString:OPEditMessageAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didEditMessage:)]) {
			[delegate plurk:self didEditMessage:result];
		}
	}
	else if ([actionName isEqualToString:OPRetriveResponsesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveResponses:)]) {
			[delegate plurk:self didRetrieveResponses:result];
		}
	}
	else if ([actionName isEqualToString:OPAddResponsesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didAddResponse:)]) {
			[delegate plurk:self didAddResponse:result];
		}
	}
	else if ([actionName isEqualToString:OPDeleteResponsesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didDeleteResponse:)]) {
			[delegate plurk:self didDeleteResponse:result];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveMyProfileAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveMyProfile:)]) {
			[delegate plurk:self didRetrieveMyProfile:result];
		}
	}
	else if ([actionName isEqualToString:OPRetrievePublicProfileAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrievePublicProfile:)]) {
			[delegate plurk:self didRetrievePublicProfile:result];
		}
	}
	else if ([actionName isEqualToString:OPRetriveFriendAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveFriends:)]) {
			[delegate plurk:self didRetrieveFriends:result];
		}
	}
	else if ([actionName isEqualToString:OPRetriveFansAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveFans:)]) {
			[delegate plurk:self didRetrieveFans:result];
		}
	}
	else if ([actionName isEqualToString:OPRetriveFollowingAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveFollowingUsers:)]) {
			[delegate plurk:self didRetrieveFollowingUsers:result];
		}
	}
	else if ([actionName isEqualToString:OPBecomeFriendAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didBecomeFriend:)]) {
			[delegate plurk:self didBecomeFriend:result];
		}
	}
	else if ([actionName isEqualToString:OPRemoveFriendshipAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRemoveFriendship:)]) {
			[delegate plurk:self didRemoveFriendship:result];
		}
	}
	else if ([actionName isEqualToString:OPBecomeFanAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didBecomeFan:)]) {
			[delegate plurk:self didBecomeFan:result];
		}
	}
	else if ([actionName isEqualToString:OPSetFollowingAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didSetFollowingUser:)]) {
			[delegate plurk:self didSetFollowingUser:result];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveFriendsCompletionListAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveFriendsCompletionList:)]) {
			[delegate plurk:self didRetrieveFriendsCompletionList:result];
		}
	}
	else if ([actionName isEqualToString:OPRetriveActiveAlertsAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetriveActiveAlerts:)]) {
			[delegate plurk:self didRetriveActiveAlerts:result];
		}
	}
	else if ([actionName isEqualToString:OPRetriveHistoryAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetriveHistory:)]) {
			[delegate plurk:self didRetriveHistory:result];
		}
	}
	else if ([actionName isEqualToString:OPAddAsFanAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didAddAsFan:)]) {
			[delegate plurk:self didAddAsFan:result];
		}
	}
	else if ([actionName isEqualToString:OPAddAllAsFanAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didAddAllAsFan:)]) {
			[delegate plurk:self didAddAllAsFan:result];
		}
	}
	else if ([actionName isEqualToString:OPAddAsFriendAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didAddAsFriend:)]) {
			[delegate plurk:self didAddAsFriend:result];
		}
	}
	else if ([actionName isEqualToString:OPAddAllAsFriendAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didAddAllAsFriend:)]) {
			[delegate plurk:self didAddAllAsFriend:result];
		}
	}
	else if ([actionName isEqualToString:OPDenyFriendshipAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didDenyFriendship:)]) {
			[delegate plurk:self didDenyFriendship:result];
		}
	}
	else if ([actionName isEqualToString:OPRemoveNotificationAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRemoveNotification:)]) {
			[delegate plurk:self didRemoveNotification:result];
		}
	}
	else if ([actionName isEqualToString:OPSearchMessagesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didSearchMessages:)]) {
			[delegate plurk:self didSearchMessages:result];
		}
	}
	else if ([actionName isEqualToString:OPSearchUsersAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didSearchUsers:)]) {
			[delegate plurk:self didSearchUsers:result];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveEmoticonsAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveEmoticons:)]) {
			[delegate plurk:self didRetrieveEmoticons:result];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveBlockedUsersAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveBlockedUsers:)]) {
			[delegate plurk:self didRetrieveBlockedUsers:result];
		}
	}
	else if ([actionName isEqualToString:OPBlockuUserAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didBlockUser:)]) {
			[delegate plurk:self didBlockUser:result];
		}
	}
	else if ([actionName isEqualToString:OPUnblockuUserAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didUnblockUser:)]) {
			[delegate plurk:self didUnblockUser:result];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveCliquesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveCliques:)]) {
			[delegate plurk:self didRetrieveCliques:result];
		}
	}
	else if ([actionName isEqualToString:OPCreateNewCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didCreateNewClique:)]) {
			[delegate plurk:self didCreateNewClique:result];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRetrieveClique:)]) {
			[delegate plurk:self didRetrieveClique:result];
		}
	}
	else if ([actionName isEqualToString:OPRenameCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRenameClique:)]) {
			[delegate plurk:self didRenameClique:result];
		}
	}
	else if ([actionName isEqualToString:OPDeleteCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didDeleteClique:)]) {
			[delegate plurk:self didDeleteClique:result];
		}
	}
	else if ([actionName isEqualToString:OPAddUserToCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didAddUserToClique:)]) {
			[delegate plurk:self didAddUserToClique:result];
		}
	}
	else if ([actionName isEqualToString:OPRemoveUserFromCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didRemoveUserFromClique:)]) {
			[delegate plurk:self didRemoveUserFromClique:result];
		}
	}
}

- (void)commonAPIDidFail:(NSError *)error
{
	NSDictionary *sessionInfo = [[error userInfo] valueForKey:@"sessionInfo"];
	id delegate = [sessionInfo valueForKey:@"delegate"];

	NSString *actionName = [sessionInfo valueForKey:@"actionName"];

	if ([actionName isEqualToString:OPUpdatePictureAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailUpdatingPicture:)]) {
			[delegate plurk:self didFailUpdatingPicture:error];
		}
	}
	else if ([actionName isEqualToString:OPUpdateProfileAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailUpdatingProfile:)]) {
			[delegate plurk:self didFailUpdatingProfile:error];
		}
	}
	else if ([actionName isEqualToString:OPRetrivePollingMessageAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingPollingMessages:)]) {
			[delegate plurk:self didFailRetrievingPollingMessages:error];
		}
	}
	else if ([actionName isEqualToString:OPRetriveMessageAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingMessage:)]) {
			[delegate plurk:self didFailRetrievingMessage:error];
		}
	}
	else if ([actionName isEqualToString:OPRetriveMessagesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingMessages:)]) {
			[delegate plurk:self didFailRetrievingMessages:error];
		}
	}
	else if ([actionName isEqualToString:OPRetriveUnreadMessagesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingUnreadMessages:)]) {
			[delegate plurk:self didFailRetrievingUnreadMessages:error];
		}
	}
	else if ([actionName isEqualToString:OPMuteMessagesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailMutingMessages:)]) {
			[delegate plurk:self didFailMutingMessages:error];
		}
	}
	else if ([actionName isEqualToString:OPUnmuteMessagesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailUnmutingMessages:)]) {
			[delegate plurk:self didFailUnmutingMessages:error];
		}
	}
	else if ([actionName isEqualToString:OPMarkMessageAsReadAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailMarkingMessagesAsRead:)]) {
			[delegate plurk:self didFailMarkingMessagesAsRead:error];
		}
	}
	else if ([actionName isEqualToString:OPAddMessageAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailAddingMessage:)]) {
			[delegate plurk:self didFailAddingMessage:error];
		}
	}
	else if ([actionName isEqualToString:OPUploadPictureAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailUploadingPicture:)]) {
			[delegate plurk:self didFailUploadingPicture:error];
		}
	}
	else if ([actionName isEqualToString:OPDeleteMessageAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailDeletingMessage:)]) {
			[delegate plurk:self didFailDeletingMessage:error];
		}
	}
	else if ([actionName isEqualToString:OPEditMessageAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailEditingMessage:)]) {
			[delegate plurk:self didFailEditingMessage:error];
		}
	}
	else if ([actionName isEqualToString:OPRetriveResponsesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingResponses:)]) {
			[delegate plurk:self didFailRetrievingResponses:error];
		}
	}
	else if ([actionName isEqualToString:OPAddResponsesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailAddingResponse:)]) {
			[delegate plurk:self didFailAddingResponse:error];
		}
	}
	else if ([actionName isEqualToString:OPDeleteResponsesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailDeletingResponse:)]) {
			[delegate plurk:self didFailDeletingResponse:error];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveMyProfileAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingMyProfile:)]) {
			[delegate plurk:self didFailRetrievingMyProfile:error];
		}
	}
	else if ([actionName isEqualToString:OPRetrievePublicProfileAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingPublicProfile:)]) {
			[delegate plurk:self didFailRetrievingPublicProfile:error];
		}
	}

	else if ([actionName isEqualToString:OPRetriveFriendAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingFriends:)]) {
			[delegate plurk:self didFailRetrievingFriends:error];
		}
	}
	else if ([actionName isEqualToString:OPRetriveFansAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingFans:)]) {
			[delegate plurk:self didFailRetrievingFans:error];
		}
	}
	else if ([actionName isEqualToString:OPRetriveFollowingAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingFollowingUsers:)]) {
			[delegate plurk:self didFailRetrievingFollowingUsers:error];
		}
	}
	else if ([actionName isEqualToString:OPBecomeFriendAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailBecomingFriend:)]) {
			[delegate plurk:self didFailBecomingFriend:error];
		}
	}
	else if ([actionName isEqualToString:OPRemoveFriendshipAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRemovingFriendship:)]) {
			[delegate plurk:self didFailRemovingFriendship:error];
		}
	}
	else if ([actionName isEqualToString:OPBecomeFanAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailBecomingFan:)]) {
			[delegate plurk:self didFailBecomingFan:error];
		}
	}
	else if ([actionName isEqualToString:OPSetFollowingAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailSettingFollowingUser:)]) {
			[delegate plurk:self didFailSettingFollowingUser:error];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveFriendsCompletionListAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingFriendsCompletionList:)]) {
			[delegate plurk:self didFailRetrievingFriendsCompletionList:error];
		}
	}
	else if ([actionName isEqualToString:OPRetriveActiveAlertsAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrivingActiveAlerts:)]) {
			[delegate plurk:self didFailRetrivingActiveAlerts:error];
		}
	}
	else if ([actionName isEqualToString:OPRetriveHistoryAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrivingHistory:)]) {
			[delegate plurk:self didFailRetrivingHistory:error];
		}
	}
	else if ([actionName isEqualToString:OPAddAsFanAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailAddingAsFan:)]) {
			[delegate plurk:self didFailAddingAsFan:error];
		}
	}
	else if ([actionName isEqualToString:OPAddAllAsFanAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailAddingAllAsFan:)]) {
			[delegate plurk:self didFailAddingAllAsFan:error];
		}
	}
	else if ([actionName isEqualToString:OPAddAsFriendAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailAddingAsFriend:)]) {
			[delegate plurk:self didFailAddingAsFriend:error];
		}
	}
	else if ([actionName isEqualToString:OPAddAllAsFriendAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailAddingAllAsFriend:)]) {
			[delegate plurk:self didFailAddingAllAsFriend:error];
		}
	}
	else if ([actionName isEqualToString:OPDenyFriendshipAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailDenyingFriendship:)]) {
			[delegate plurk:self didFailDenyingFriendship:error];
		}
	}
	else if ([actionName isEqualToString:OPRemoveNotificationAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRemovingNotification:)]) {
			[delegate plurk:self didFailRemovingNotification:error];
		}
	}
	else if ([actionName isEqualToString:OPSearchMessagesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailSearchingMessages:)]) {
			[delegate plurk:self didFailSearchingMessages:error];
		}
	}
	else if ([actionName isEqualToString:OPSearchUsersAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailSearchingUsers:)]) {
			[delegate plurk:self didFailSearchingUsers:error];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveEmoticonsAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingEmoticons:)]) {
			[delegate plurk:self didFailRetrievingEmoticons:error];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveBlockedUsersAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingBlockedUsers:)]) {
			[delegate plurk:self didFailRetrievingBlockedUsers:error];
		}
	}
	else if ([actionName isEqualToString:OPBlockuUserAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailBlockingUser:)]) {
			[delegate plurk:self didFailBlockingUser:error];
		}
	}
	else if ([actionName isEqualToString:OPUnblockuUserAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailUnblockingUser:)]) {
			[delegate plurk:self didFailUnblockingUser:error];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveCliquesAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingCliques:)]) {
			[delegate plurk:self didFailRetrievingCliques:error];
		}
	}
	else if ([actionName isEqualToString:OPCreateNewCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailCreatingNewClique:)]) {
			[delegate plurk:self didFailCreatingNewClique:error];
		}
	}
	else if ([actionName isEqualToString:OPRetrieveCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRetrievingClique:)]) {
			[delegate plurk:self didFailRetrievingClique:error];
		}
	}
	else if ([actionName isEqualToString:OPRenameCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRenamingClique:)]) {
			[delegate plurk:self didFailRenamingClique:error];
		}
	}
	else if ([actionName isEqualToString:OPDeleteCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailDeletingClique:)]) {
			[delegate plurk:self didFailDeletingClique:error];
		}
	}
	else if ([actionName isEqualToString:OPAddUserToCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailAddingUserToClique:)]) {
			[delegate plurk:self didFailAddingUserToClique:error];
		}
	}
	else if ([actionName isEqualToString:OPRemoveUserFromCliqueAction]) {
		if ([delegate respondsToSelector:@selector(plurk:didFailRemovingUserFromClique:)]) {
			[delegate plurk:self didFailRemovingUserFromClique:error];
		}
	}
}

#pragma mark -

- (void)httpRequest:(LFHTTPRequest *)request didReceiveStatusCode:(NSUInteger)statusCode URL:(NSURL *)url responseHeader:(CFHTTPMessageRef)header
{
//	NSLog(@"%d", statusCode);
	id tmp = _receivedHeader;
	CFDictionaryRef headerRef = CFHTTPMessageCopyAllHeaderFields(header);
	_receivedHeader = [[NSDictionary alloc] initWithDictionary:(NSDictionary *)headerRef];
	[tmp release];
}

- (void)httpRequestDidCancel:(LFHTTPRequest *)request
{
	[self runQueue];
}

- (void)httpRequest:(LFHTTPRequest *)request didFailWithError:(NSString *)error
{
	NSDictionary *sessionInfo = [request sessionInfo];
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary setObject:error forKey:NSLocalizedDescriptionKey];
	[dictionary setObject:sessionInfo forKey:@"sessionInfo"];
	NSError *theError = [NSError errorWithDomain:ObjectivePlurkErrorDomain code:0 userInfo:dictionary];

	NSString *actionName = [sessionInfo valueForKey:@"actionName"];
	if ([actionName isEqualToString:OPLoginAction]) {
		[self loginDidFail:theError];
	}
	else {
		[self commonAPIDidFail:theError];
	}

	[self runQueue];
}

- (void)httpRequestDidComplete:(LFHTTPRequest *)request
{
	NSDictionary *sessionInfo = [request sessionInfo];
	NSString *actionName = [sessionInfo valueForKey:@"actionName"];
	if ([actionName isEqualToString:OPLoginAction]) {
		[self loginDidSuccess:request];
	}
	else {
		NSString *s = [[[NSString alloc] initWithData:[request receivedData] encoding:NSUTF8StringEncoding] autorelease];
		if (!s) {
			[self httpRequest:request didFailWithError:@"Failed to fetch contents. (1)"]; return;
		}

		NSDictionary *result = [NSDictionary dictionaryWithJSONString:s];

		if (!result) {
			NSLog(@"%@", s);
			[self httpRequest:request didFailWithError:@"Failed to parse contents"]; return;
		}

		NSMutableDictionary *sessionInfoWithResult = [NSMutableDictionary dictionaryWithDictionary:sessionInfo];
		[sessionInfoWithResult setObject:result forKey:@"result"];
		[self commonAPIDidSuccess:sessionInfoWithResult];
	}
	[self runQueue];
}
- (void)httpRequest:(LFHTTPRequest *)request sentBytes:(NSUInteger)bytesSent total:(NSUInteger)total
{
//	NSLog(@"bytesSent/total:%d/%d", bytesSent, total);
}


@end

