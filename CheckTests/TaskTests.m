//
//  TaskTests.m
//  Check
//
//  Created by Oleg Shanyuk on 12/11/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Task.h"

@interface TaskTests : XCTestCase

@end

@implementation TaskTests

-(void)testCreateTask
{
    NSString *title = @"tito";
    BOOL complete = YES;
    
    TaskItem *item = [[TaskItem alloc] initWithTitle:title complete:complete];
    
    XCTAssertEqualObjects(item.title, title);
    XCTAssertEqual(item.complete, complete);
}

@end
