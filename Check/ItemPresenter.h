//
//  ItemPresenter.h
//  Check
//
//  Created by Oleg Shanyuk on 12/6/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemPresenter : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) UIImage *checkImage;
@property (nonatomic, readonly) id<Task> item;

- (instancetype)initWithItem:(id<Task>)item;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
