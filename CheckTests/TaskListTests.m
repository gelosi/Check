//
//  TaskListTests.m
//  Check
//
//  Created by Oleg Shanyuk on 12/11/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TaskList.h"

@interface TaskListTests : XCTestCase

@end

@implementation TaskListTests

- (NSArray *)threeTasksArray
{
    return @[
             [[TaskItem alloc] initWithTitle:@"item 1" complete:NO],
             [[TaskItem alloc] initWithTitle:@"item 2" complete:NO],
             [[TaskItem alloc] initWithTitle:@"item 3" complete:NO]
             ];
}

- (TaskList *)taskListWithThreeTasks
{
    NSArray *testArray = [self threeTasksArray];
    
    return [[TaskList alloc] initWithTasks:testArray];
}

- (void)testTaskListCreate
{
    NSArray *testArray = [self threeTasksArray];
    
    TaskList *list = [[TaskList alloc] initWithTasks:testArray];
    
    XCTAssertEqual(list.taskCount, testArray.count);
}

-(void)testTaskAddFirst
{
    TaskList *list = [self taskListWithThreeTasks];
    
    TaskItem *newTask = [[TaskItem alloc] initWithTitle:@"task 4" complete:NO];
    
    NSUInteger index = list.taskCount;
    
    [list addTask:newTask atIndex:0];
    
    XCTAssertEqual(list.taskCount, index+1);
    
    XCTAssertEqualObjects([list taskAtIndex:0], newTask);
}

-(void)testTaskAddLast
{
    TaskList *list = [self taskListWithThreeTasks];
    
    id<Task> newTask = [[TaskItem alloc] initWithTitle:@"task 4" complete:NO];
    
    NSUInteger index = list.taskCount;
    
    [list addTask:newTask atIndex:index];
    
    XCTAssertEqual(list.taskCount, index+1);
    
    XCTAssertEqualObjects([list taskAtIndex:index], newTask);
}

-(void)testTaskDelete
{
    TaskList *list = [self taskListWithThreeTasks];
    
    id<Task> item = [list taskAtIndex:0];
    
    [list removeTaskAtIndex:0];
    
    XCTAssertEqual(list.taskCount, 2);
    
    XCTAssertFalse([list.allTasks containsObject:item]);
}

-(void)testMoveTask
{
    TaskList *list = [self taskListWithThreeTasks];
    
    id<Task> taskOne = [list taskAtIndex:0];
    id<Task> taskThree = [list taskAtIndex:2];
    
    [list moveTaskAtIndex:0 toIndex:2];
    
    XCTAssertEqualObjects([list taskAtIndex:2], taskOne);
    XCTAssertEqualObjects([list taskAtIndex:1], taskThree);
    
    XCTAssertTrue(list.taskCount == 3);
}

@end
