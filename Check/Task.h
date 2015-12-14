//
//  ListItem.h
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

@import UIKit;


NS_ASSUME_NONNULL_BEGIN

@protocol Task <NSObject>

@property (nonatomic, readonly) NSString *taskId;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) BOOL complete;

-(BOOL)isEqualToTask:(id<Task>) task;

@end

@interface TaskItem : NSObject<Task, NSCoding>

- (instancetype)initWithTitle:(NSString *)title complete:(BOOL)complete;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
