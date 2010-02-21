//
// ObjectivePlurk+PrivateMethods.h
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

#import "ObjectivePlurk.h"

#if TARGET_OS_IPHONE
	#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_2_2
#import <MobileCoreServices/MobileCoreServices.h>
	#endif
#endif

@interface ObjectivePlurk(PrivateMethods)

- (NSString *)GETStringFromDictionary:(NSDictionary *)inDictionary;
- (void)runQueue;
- (void)addRequestWithAction:(NSString *)actionName arguments:(NSDictionary *)arguments filepath:(NSString *)filepath multipartName:(NSString *)multipartName delegate:(id)delegate userInfo:(NSDictionary *)userInfo;
- (void)addRequestWithAction:(NSString *)actionName arguments:(NSDictionary *)arguments delegate:(id)delegate userInfo:(NSDictionary *)userInfo;

- (NSDate *)_expirationDateFromCookieString:(NSString *)cookie;

- (void)loginDidSuccess:(LFHTTPRequest *)request;
- (void)loginDidFail:(NSError *)error;
- (void)commonAPIDidSuccess:(NSDictionary *)sessionInfo;
- (void)commonAPIDidFail:(NSError *)error;

@end
