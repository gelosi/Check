//
//  ItemPresenter.m
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "ItemPresenter.h"

@implementation ItemPresenter

- (instancetype)initWithItem:(id<Task>)item
{
    self = [super init];
    
    if (self) {
        _item = item;
    }
    
    return self;
}

- (UIImage *)checkImage
{
    NSString *imageName = self.item.complete ? @"complete" : @"incomplete";
    return [UIImage imageNamed:imageName];
}

- (NSString *)title
{
    return self.item.title;
}

@end
