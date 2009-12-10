//
//  ObjectivePlurkTest.h
//  ObjectivePlurk
//
//  Created by zonble on 12/10/09.
//  Copyright 2009 Lithoglyph Inc.. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <ObjectivePlurk/ObjectivePlurk.h>
#import "PlurkAPIKey.h"

@interface ObjectivePlurkTest : SenTestCase 
{
	NSDictionary *currentUserInfo;
}

- (void)testAPI;

@end
