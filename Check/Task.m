//
//  ListItem.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

static NSString* const TaskIdKey = @"taskId";
static NSString* const TaskTitleKey = @"title";
static NSString* const TaskCompleteKey = @"complete";

@implementation TaskItem

@synthesize title = _title, complete = _complete, taskId = _taskId;

-(instancetype)initWithTitle:(NSString *)title complete:(BOOL)complete taskId:(NSString *)taskId
{
    self = [super init];

    if (self) {
        _taskId = [[NSUUID UUID] UUIDString];
        _title = [title copy];
        _complete = complete;
    }

    return self;
}


-(instancetype)initWithTitle:(NSString *)title complete:(BOOL)complete
{
    return [self initWithTitle:title complete:complete taskId:[[NSUUID UUID] UUIDString]];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSString *taskId = [aDecoder decodeObjectForKey:TaskIdKey];
    NSString *title = [aDecoder decodeObjectForKey:TaskTitleKey];
    BOOL complete = [aDecoder decodeBoolForKey:TaskCompleteKey];
    
    return [self initWithTitle:title complete:complete taskId:taskId];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.taskId forKey:TaskIdKey];
    [aCoder encodeObject:self.title forKey:TaskTitleKey];
    [aCoder encodeBool:self.complete forKey:TaskCompleteKey];
}

-(BOOL) isEqualToTask:(id<Task>)task
{
    return [self.taskId isEqualToString:task.taskId];
}

@end

NS_ASSUME_NONNULL_END
