//
//  TaskListTests.m
//  Check
//
//  Created by Oleg Shanyuk on 12/11/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestsHelper.h"

@interface TaskListTests : XCTestCase

@end

@implementation TaskListTests


- (void)testTaskListCreate
{
    NSArray *testArray = [TestsHelper threeTasksArray:YES];
    
    TaskList *list = [[TaskList alloc] initWithTasks:testArray];
    
    XCTAssertEqual(list.taskCount, testArray.count);
}

-(void)testTaskAddFirst
{
    TaskList *list = [TestsHelper taskListWithThreeCompleteTasks];
    
    TaskItem *newTask = [[TaskItem alloc] initWithTitle:@"task 4" complete:NO];
    
    NSUInteger index = list.taskCount;
    
    [list addTask:newTask atIndex:0];
    
    XCTAssertEqual(list.taskCount, index+1);
    
    XCTAssertEqualObjects([list taskAtIndex:0], newTask);
}

-(void)testTaskAddLast
{
    TaskList *list = [TestsHelper taskListWithThreeCompleteTasks];
    
    id<Task> newTask = [[TaskItem alloc] initWithTitle:@"task 4" complete:NO];
    
    NSUInteger index = list.taskCount;
    
    [list addTask:newTask atIndex:index];
    
    XCTAssertEqual(list.taskCount, index+1);
    
    XCTAssertTrue([newTask isEqualToTask:[list taskAtIndex:index]]);
}

-(void)testTaskDelete
{
    TaskList *list = [TestsHelper taskListWithThreeCompleteTasks];
    
    id<Task> item = [list taskAtIndex:0];
    
    [list removeTaskAtIndex:0];
    
    XCTAssertEqual(list.taskCount, 2);
    
    XCTAssertFalse([list.allTasks containsObject:item]);
}

-(void)testMoveTask
{
    TaskList *list = [TestsHelper taskListWithThreeCompleteTasks];
    
    id<Task> taskOne = [list taskAtIndex:0];
    id<Task> taskThree = [list taskAtIndex:2];
    
    [list moveTaskAtIndex:0 toIndex:2];
    
    XCTAssertTrue([taskOne isEqualToTask:[list taskAtIndex:2]]);
    XCTAssertTrue([taskThree isEqualToTask:[list taskAtIndex:1]]);
    
    XCTAssertTrue(list.taskCount == 3);
}

@end
