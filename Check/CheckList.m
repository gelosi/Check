//
//  CheckList.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "CheckList.h"

static NSString* const ChecklistTitleKey = @"title";
static NSString* const ChecklistActiveKey = @"active";
static NSString* const ChecklistCompleteKey = @"complete";

@implementation CheckList

- (instancetype)initWithTitle:(NSString *)title activeTasks:(TaskList *)active completeTasks:(TaskList *)complete
{
    self = [super init];
    
    if (self) {
        _title = title;
        _activeTasks = active;
        _completeTasks = complete;
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSString *title = [aDecoder decodeObjectForKey:ChecklistTitleKey];
    TaskList *active = [aDecoder decodeObjectForKey:ChecklistActiveKey];
    TaskList *completed = [aDecoder decodeObjectForKey:ChecklistCompleteKey];
    
    return [self initWithTitle:title activeTasks:active completeTasks:completed];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:ChecklistTitleKey];
    [aCoder encodeObject:self.activeTasks forKey:ChecklistActiveKey];
    [aCoder encodeObject:self.completeTasks forKey:ChecklistCompleteKey];
}

@end
