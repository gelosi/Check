//
//  TaskList.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "TaskList.h"

static NSString* const TaskListKey = @"TaskList";

@interface TaskList()

@property (nonatomic) NSMutableArray<id<Task>> *taskList;

@end

@implementation TaskList

- (instancetype)initWithTasks:(NSArray<id<Task>>*)tasks
{
    self = [super init];
    
    if (self) {
        _taskList = [NSMutableArray array];
        [_taskList addObjectsFromArray:tasks];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSArray *tasks = [aDecoder decodeObjectForKey:TaskListKey];
    return [self initWithTasks:tasks];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.taskList forKey:TaskListKey];
}

- (NSArray<id<Task>>*)allTasks
{
    return [NSArray arrayWithArray:self.taskList];
}

- (NSUInteger)taskCount
{
    return self.taskList.count;
}

- (id<Task>)taskAtIndex:(NSUInteger)index
{
    return self.taskList[index];
}

- (void)addTask:(id<Task>)task atIndex:(NSUInteger)index
{
    NSParameterAssert(task);

    [self.taskList insertObject:task atIndex:index];
}

- (void)removeTaskAtIndex:(NSUInteger)index
{
    [self.taskList removeObjectAtIndex:index];
}

- (void)moveTaskAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    id task = self.taskList[fromIndex];
    
    [self.taskList removeObjectAtIndex:fromIndex];
    
    [self.taskList insertObject:task atIndex:toIndex];
}

@end
