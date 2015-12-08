//
//  TaskList.h
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskList : NSObject<NSCoding>

- (instancetype)initWithTasks:(NSArray<id<Task>>*)tasks;

-(NSArray<id<Task>>*)allTasks;
-(NSUInteger)taskCount;

- (id<Task>)taskAtIndex:(NSUInteger)index;
- (void)addTask:(id<Task>)task;
- (void)removeTaskAtIndex:(NSUInteger)index;
- (void)moveTaskAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end

NS_ASSUME_NONNULL_END
