//
//  ChecklistDatasourceTests.m
//  Check
//
//  Created by Oleg Shanyuk on 14/12/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestsHelper.h"
#import "ChecklistDataSource.h"

@interface ChecklistDataSourceTests : XCTestCase

@end

@implementation ChecklistDataSourceTests

-(CheckList *)makeCheckListWithThreeTasks
{
    return [[CheckList alloc] initWithTitle:@"Test List Check"
                                activeTasks:[TestsHelper taskListWithThreeIncompleteTasks]
                              completeTasks:[TestsHelper taskListWithThreeCompleteTasks]];
}

-(void)testDataSourceAddTaskAtValidIndexPath
{
    CheckList *checkList = [self makeCheckListWithThreeTasks];

    ChecklistDataSource *datasource = [[ChecklistDataSource alloc] initWithCheckList:checkList];

    TaskItem *task = [[TaskItem alloc] initWithTitle:@"add Task" complete:NO];

    NSIndexPath *indexPath = [datasource indexPathForNewActiveTask];

    [datasource addTask:task atIndexPath:indexPath];

    XCTAssert(datasource.checkList.activeTasks.taskCount == 4);
    XCTAssertTrue([task isEqualToTask:[datasource taskAtIndexPath:indexPath]] );
}

-(void)testDataSourceAddTaskAtInvalidIndexPath
{
    CheckList *checkList = [self makeCheckListWithThreeTasks];

    ChecklistDataSource *datasource = [[ChecklistDataSource alloc] initWithCheckList:checkList];

    TaskItem *task = [[TaskItem alloc] initWithTitle:@"add Task" complete:NO];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:10 inSection:0];

    XCTAssertThrows([datasource addTask:task atIndexPath:indexPath]);

    XCTAssert(datasource.checkList.activeTasks.taskCount == 3);
}

-(void)testChecklistDataSourceTests
{
    CheckList *checkList = [self makeCheckListWithThreeTasks];

    ChecklistDataSource *datasource = [[ChecklistDataSource alloc] initWithCheckList:checkList];

    NSIndexPath *firstActiveTaskIndex = [datasource indexPathForNewActiveTask];

    id<Task> deletedTask = [datasource taskAtIndexPath:firstActiveTaskIndex];

    [datasource deleteTaskAtIndexPath:firstActiveTaskIndex];

    XCTAssert(datasource.checkList.activeTasks.taskCount == 2);
    XCTAssertFalse([deletedTask isEqualToTask:[datasource taskAtIndexPath:firstActiveTaskIndex]]);
}

-(void)testIndexPathByUpdatingTaskCompletionStatusAtIndexPath
{
    CheckList *checkList = [self makeCheckListWithThreeTasks];

    ChecklistDataSource *datasource = [[ChecklistDataSource alloc] initWithCheckList:checkList];

    NSIndexPath *activeTaskIndex = [datasource indexPathForNewActiveTask];

    id<Task> taskToBeMoved = [datasource taskAtIndexPath:activeTaskIndex];

    NSIndexPath *completeTaskIndex = [datasource indexPathByUpdatingTaskCompletionStatusAtIndexPath:activeTaskIndex];

    XCTAssert(completeTaskIndex);

    id<Task> taskAfterMove = [datasource taskAtIndexPath:completeTaskIndex];

    XCTAssertEqualObjects(taskToBeMoved.taskId, taskAfterMove.taskId);
    XCTAssertNotEqual(taskToBeMoved.complete, taskAfterMove.complete);
}

@end
