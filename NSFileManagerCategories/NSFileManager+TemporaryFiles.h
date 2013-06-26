//
// This Objective C category for the NSFileManager class lets you create
// temporary files either in the directory of your choice or in the directory
// returned by the NSTemporaryDirectory() function
//
// The error parameter is optional: errors will be eaten silently if you don't provide it.
//
#import <Foundation/Foundation.h>

@interface NSFileManager (NSFileManager_FileManager)
-(NSURL*)createTemporaryFile:(NSString*)prefix suffix:(NSString*)suffix in:(NSURL*)parentFolder onError:(NSError**)error;
-(NSURL*)createTemporaryFile:(NSString*)prefix suffix:(NSString*)suffix onError:(NSError**)error;
@end