//
//  ListItem.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

static NSString* const TaskTitleKey = @"title";
static NSString* const TaskCompleteKey = @"complete";

@implementation TaskItem

@synthesize title = _title, complete = _complete;

-(instancetype)initWithTitle:(NSString *)title complete:(BOOL)complete
{
    self = [super init];
    
    if (self) {
        _title = [title copy];
        _complete = complete;
    }
    
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSString *title = [aDecoder decodeObjectForKey:TaskTitleKey];
    BOOL complete = [aDecoder decodeBoolForKey:TaskCompleteKey];
    
    return [self initWithTitle:title complete:complete];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:TaskTitleKey];
    [aCoder encodeBool:self.complete forKey:TaskCompleteKey];
}

@end

NS_ASSUME_NONNULL_END
