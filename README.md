# ObjectivePlurk

Copyright © 2009-2010 Weizhong Yang. All Rights Reserved.

ObjectivePlurk is a Plurk API implemented with Objective-C programming language. It helps you to create a client software for Mac OS X and iPhone OS devices, to read feeds from Plurk, and post new messages and pictures.

## Requirement

I suggest that you are ready to create a new Mac or iPhone application, and you already had required environment for software development such as a Macintosh computer with an Intel CPU which is running Leopard or Snow Leopard operating system, and Xcode. What you still need includes,

1. A Plurk API key. You can obtain one from the [Plurk API page](http://www.plurk.com/API). Go visit the page and fill the registration form, Plurk will send your API key to your email address.

2. Libraries the project depends on, including
	* [LFWebAPIKit](http://github.com/lukhnos/LFWebAPIKit/), I use it to work with HTTP request stuffs.
	* [bsjsonadditions](http://github.com/blakeseely/bsjsonadditions), I use it to parse JSON datas.

## How to Use It

Checkout all required source code and the dependency, create a new project with Xcode, add all the files to your Xcode project file, and add required frameworks such as ``CFNetwork``, ``SystemConfiguration``, ``MobileCoreServices`` and so on. Now, let us start coding.

After adding a new NSObject subclass, the first thing you should do is to include ``ObjectivePlurk`` to your header file.

	#import "ObjectivePlurk.h"

ObjectivePlurk has a singleton instance, it will be instantiated after the first time to call ``[ObjectivePlurk sharedInstance]``. The first thing to do with the shared instance, is to assign your API key to it. Without assigning an API key the library can do nothing at all. Select a proper place to do it after your application is initiated, implementing with the ``applicationDidFinishLaunching:`` delegate method of NSApplication or UIApplicaiton should be fine.

	[ObjectivePlurk sharedInstance].APIKey = @"MY API KEY";

Now we can try to login Plurk. Just call ``loginWithUsername:password:delegate:userInfo:`` with your username, password, and a delegate object.

	[[ObjectivePlurk sharedInstance] loginWithUsername:@"zonble" password:@"abcd1234" delegate:self userInfo:nil];

Implement the following two delegate methods in your class. If you are successfully logged in, ``plurk:didLoggedIn:`` will be called and it will return the result fetched from the Plurk API. Otherwise, ``plurk:didFailLoggingIn`` will be called, and it will give you an NSError object to tell you what was wrong.

	- (void)plurk:(ObjectivePlurk *)plurk didLoggedIn:(NSDictionary *)result;
	- (void)plurk:(ObjectivePlurk *)plurk didFailLoggingIn:(NSError *)error;
	

## License

The project is released under New BSD License.