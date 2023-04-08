//
//  FileManager.m
//  images-fetcher
//
//  Created by Youssef on 08/04/2023.
//

#import <Foundation/Foundation.h>

@interface DataFileManager : NSObject

+ (instancetype)sharedInstance;
- (void)saveData:(NSData *)data withName:(NSString *)name;
- (NSData *)getDataWithName:(NSString *)name;
- (void)removeFileWithName:(NSString *)name;

@end

@implementation DataFileManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static DataFileManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[DataFileManager alloc] init];
    });
    return instance;
}

- (void)saveData:(NSData *)data withName:(NSString *)name {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:name];
    [data writeToFile:filePath atomically:YES];
}

- (NSData *)getDataWithName:(NSString *)name {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:name];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

- (void)removeFileWithName:(NSString *)name {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"Error removing file: %@", error.localizedDescription);
    }
}

@end
