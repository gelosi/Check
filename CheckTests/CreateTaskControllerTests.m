//
//  CreateTaskController.m
//  Check
//
//  Created by Oleg Shanyuk on 14/12/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CreateTaskController.h"

@interface CreateTaskControllerTests : XCTestCase

@end

@implementation CreateTaskControllerTests

-(void)testCreateRandomTask
{
    CreateTaskController *controller = [CreateTaskController new];
    id<Task> task = [controller randomActiveTask];

    XCTAssert(task);
}

@end
