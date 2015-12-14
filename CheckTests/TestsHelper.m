//
//  TestsHelper.m
//  Check
//
//  Created by Oleg Shanyuk on 14/12/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "TestsHelper.h"

@implementation TestsHelper

+ (NSArray *)threeTasksArray:(BOOL)complete
{
    return @[
             [[TaskItem alloc] initWithTitle:@"item 1" complete:complete],
             [[TaskItem alloc] initWithTitle:@"item 2" complete:complete],
             [[TaskItem alloc] initWithTitle:@"item 3" complete:complete]
             ];
}

+ (TaskList *)taskListWithThreeCompleteTasks
{
    NSArray *testArray = [self threeTasksArray:YES];

    return [[TaskList alloc] initWithTasks:testArray];
}

+ (TaskList *)taskListWithThreeIncompleteTasks
{
    NSArray *testArray = [self threeTasksArray:NO];

    return [[TaskList alloc] initWithTasks:testArray];
}


@end
