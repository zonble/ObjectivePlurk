//
//  ObjectivePlurkTest.h
//  ObjectivePlurk
//
//  Created by zonble on 12/10/09.
//

#import <SenTestingKit/SenTestingKit.h>
#import <ObjectivePlurk/ObjectivePlurk.h>
#import "PlurkAPIKey.h"

@interface ObjectivePlurkTest : SenTestCase 
{
	NSDictionary *currentUserInfo;
}

- (void)testAPI;

@property (retain) NSDictionary *currentUserInfo;

@end
