//
//  ObjCHiredis_TestCase.m
//  ObjCHiredis
//
//  Created by Louis-Philippe on 10-10-15.
//  Copyright 2010 Modul. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <Foundation/Foundation.h>

#ifdef IOS
#import "ObjCHiredis.h"
#endif

#ifndef IOS
#import "ObjCHiredis/ObjCHiredis.h"
#endif


@interface ObjCHiredis_01_Basic_TestCase : SenTestCase {
	ObjCHiredis * redis;
}

@end

@implementation ObjCHiredis_01_Basic_TestCase

- (void)setUp {
	redis = [ObjCHiredis redis];
	[redis retain];
}

- (void)tearDown {
	[redis command:@"FLUSHALL"];
	[redis release];
}

- (void) test_01_Math {
    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );    
}

- (void)test_02_Init {
	STAssertNotNil(redis, @"Couldn't init... ");
}

- (void)test_03_EXISTS {
	id retVal = [redis command:@"EXISTS MYKEY"];
	STAssertTrue([retVal isKindOfClass:[NSNumber class]], @"EXISTS didn't return an NSNumber, got: %@", [retVal class]);
	STAssertTrue([retVal isEqualToNumber:[NSNumber numberWithInt:0]], @"EXISTS didn't return 0 on failure, got: %d", [retVal integerValue]);
	
	[redis command:@"SET MYKEY MYVALUE"];
	retVal = [redis command:@"EXISTS MYKEY"];
	STAssertTrue([retVal isEqualToNumber:[NSNumber numberWithInt:1]], @"EXISTS didn't return 1 on success, got: %d", [retVal integerValue]);
}

@end
