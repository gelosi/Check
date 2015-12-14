//
//  NewTaskController.h
//  Check
//
//  Created by Oleg Shanyuk on 14/12/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CreateTaskControllerDelegate <NSObject>

-(void)createdNewTask:(id<Task>)task;

@optional

-(void)cancelled;

@end



@interface CreateTaskController : NSObject

@property (nonatomic, weak, nullable) id<CreateTaskControllerDelegate> delegate;

+ (instancetype)createTaskControllerWithDelegate:(id<CreateTaskControllerDelegate>)delegate;

- (void)createNewTask;

@end

NS_ASSUME_NONNULL_END