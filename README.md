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

ObjectivePlurk has a singleton instance, it will be instantiated after the first time to call ``[ObjectivePlurk sharedInstance]``. The first thing to do with the shared instance, is to assign your API key to it. Without assigning an API key the library can do nothing at all. Select a proper place to do it after your application is initiated, implementing with the ``applicationDidFinishLaunching:`` delegate method of ``NSApplication`` or ``UIApplicaiton`` should be fine.

	[ObjectivePlurk sharedInstance].APIKey = @"MY API KEY";

Now we can try to login Plurk. Just call ``loginWithUsername:password:delegate:userInfo:`` with your username, password, and a delegate object.

	[[ObjectivePlurk sharedInstance] loginWithUsername:@"zonble" password:@"abcd1234" delegate:self userInfo:nil];

Implement the following two delegate methods in your class. If you are successfully logged in, ``plurk:didLoggedIn:`` will be called and it will return the result fetched from the Plurk API. Otherwise, ``plurk:didFailLoggingIn`` will be called, and it will give you an NSError object to tell you what was wrong.

	- (void)plurk:(ObjectivePlurk *)plurk didLoggedIn:(NSDictionary *)result;
	- (void)plurk:(ObjectivePlurk *)plurk didFailLoggingIn:(NSError *)error;

Then we can try read the timeline by calling ``retrieveMessagesWithDateOffset:limit:user:isResponded:isPrivate:delegate:userInfo:``, or do other things we would like to do.

If you want to logout Plurk, just call ``logout``, and you can know if you are logged in by calling the ``loggedIn`` property.

## Multiple API Calls

You can call an instance of ObjectivePlurk to do more than one task simultaneously. The tasks will be scheduled into a queue, and they will be done one by one. You can cancel all tasks in the queue by calling the ``cancelAllRequest`` method. The design is not very efficient if you have a fast Internet connection, but it works on some limited devices such as iPhone.

On the other hand, you may not want to cancel all the tasks but just part of them. You can cancel all the tasks assigned a specified delegate object by calling ``cancelAllRequestWithDelegate:``. The method should be useful when you want to release your delegate object and ask ObjectivePlurk not to send messages to it, in order to avoid bad access exceptions.


## Contact

Feel free to write me a message via GitHub's mail system, or write to zonble {at} gmail {dot} com. I can read and write English an Chinese.

## License

The project is released under New BSD License.