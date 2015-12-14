//
//  CheckListTests.m
//  Check
//
//  Created by Oleg Shanyuk on 14/12/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestsHelper.h"

@interface CheckListTests : XCTestCase

@end

@implementation CheckListTests


-(void)testTaskListCreate
{
    TaskList *incompleteTasks = [TestsHelper taskListWithThreeIncompleteTasks];
    TaskList *completeTasks = [TestsHelper taskListWithThreeCompleteTasks];
    NSString *testTitle = @"Check Check List";

    CheckList *checkList = [[CheckList alloc] initWithTitle:testTitle activeTasks:incompleteTasks completeTasks:completeTasks];

    XCTAssertEqualObjects(checkList.title,testTitle);
    XCTAssertEqualObjects(completeTasks, checkList.completeTasks);
    XCTAssertEqualObjects(incompleteTasks, checkList.activeTasks);
}

@end
