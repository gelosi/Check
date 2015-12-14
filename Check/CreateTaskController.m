//
//  NewTaskController.m
//  Check
//
//  Created by Oleg Shanyuk on 14/12/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "CreateTaskController.h"

@implementation CreateTaskController

+ (instancetype)createTaskControllerWithDelegate:(id<CreateTaskControllerDelegate>)delegate
{
    CreateTaskController *newTaskController = [CreateTaskController new];

    newTaskController.delegate = delegate;

    return newTaskController;
}

- (void)createNewTask
{
    [self.delegate createdNewTask:[self randomActiveTask]];
}


- (id<Task>)randomActiveTask
{
    TaskItem *Task = [[TaskItem alloc] initWithTitle:[self randomTitle] complete:NO];

    return Task;
}

-(NSString *)randomTitle
{
    NSArray *itemPart = @[@"Item", @"Task", @"Point", @"Punkt", @"Reminder", @"Pink", @"Check"];
    NSArray *explainPart = @[@"One", @"Two", @"Call Someone", @"Floyd", @"Break", @"Off", @"On", @"Pizza"];

    NSUInteger indexPart =  arc4random_uniform((u_int32_t)itemPart.count);
    NSUInteger indexExplain =  arc4random_uniform((u_int32_t)explainPart.count);

    return [@[itemPart[indexPart],explainPart[indexExplain]] componentsJoinedByString:@" "];
}

@end
