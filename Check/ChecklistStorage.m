//
//  ChecklistStorage.m
//  Check
//
//  Created by Oleg Shanyuk on 12/7/15.
//  Copyright © 2015 xaTa. All rights reserved.
//

#import "ChecklistStorage.h"

@interface ChecklistAsyncFileStorage()
@property (nonatomic) NSOperationQueue *fileOperations;
@end

@implementation ChecklistAsyncFileStorage

-(instancetype)init
{
    self = [super init];

    if (self) {
        _fileOperations = [NSOperationQueue new];
        _fileOperations.maxConcurrentOperationCount = 1;
    }

    return self;
}

+ (instancetype)storage
{
    return [ChecklistAsyncFileStorage new];
}

- (NSString *)pathForFile:(NSString *)file
{
    NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:file];
    
    return filePath;
}


-(void)loadCheckList:(NSString *)name comletion:(ChecklistStorageCompletion)completion
{
    [self.fileOperations addOperationWithBlock:^{

        NSString *fileName = [self pathForFile:name];

        CheckList* checkList = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];

        BOOL success = checkList != nil;

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(checkList, success);
        }];
    }];

}

- (void)storeChecklist:(CheckList *)checkList comletion:(ChecklistStorageCompletion)completion
{
    [self.fileOperations addOperationWithBlock:^{
        
        NSString *fileName = [self pathForFile:checkList.title];
        
        BOOL success = [NSKeyedArchiver archiveRootObject:checkList toFile:fileName];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(checkList, success);
        }];
    }];
}

@end
