#import "NSFileManager+TemporaryFiles.h"

@implementation NSFileManager (NSFileManager_FileManager)

//
// This is a fancy wrapper over several lower-level libc and cocoa calls for swizzling NSURLs 
// into NSStrings into UTF8 encoded c template strings suitable for mkstemps
//
// As I stated in the header, the error parameter is optional: if you don't specify it, errors will be eaten
//
//
-(NSURL*)createTemporaryFile:(NSString*)prefix suffix:(NSString*)suffix in:(NSURL*)parentFolder onError:(NSError**)error
{
    NSURL * ret_val = nil;
    
    __autoreleasing NSError * tempError;
    error = error == NULL ? &tempError : error;
    
    prefix = prefix == nil ? @"" : prefix;
    suffix = suffix == nil ? @"" : suffix;
    NSString * tempAsPath= [parentFolder path];
    BOOL parentIsDir = NO;
    [self fileExistsAtPath:tempAsPath isDirectory:&parentIsDir];
    NSString * format = parentIsDir ? @"%@/%@XXXXX%@" : @"%@%@XXXXX%@";
    NSString * path_template = [NSString stringWithFormat:format, tempAsPath, prefix, suffix];
    const char * path_template_cstr = [path_template fileSystemRepresentation];
    
    char * tempFileNameCString = (char *)malloc(strlen(path_template_cstr) + 1);
    strcpy(tempFileNameCString, path_template_cstr);
    int fd = mkstemps(tempFileNameCString, (int)strlen ( [suffix UTF8String] ) );
    if ( fd == -1 ) *error = [NSError errorWithDomain:NSPOSIXErrorDomain code:errno userInfo:nil];
    else
    {
        close ( fd );
        // This is the file name if you need to access the file by name, otherwise you can remove
        // this line.
        NSString * tempFilePath = [self stringWithFileSystemRepresentation:tempFileNameCString length:strlen(tempFileNameCString)];
        ret_val = [NSURL fileURLWithPath:tempFilePath];
        
    }
    free(tempFileNameCString);
    return ret_val;
}

//
// Convenience method that passes the value returned by NSTemporaryDirectory() as the parent folder parameter "in"
//
-(NSURL*)createTemporaryFile:(NSString*)prefix suffix:(NSString*)suffix onError:(NSError**)error
{
    return [self createTemporaryFile:prefix suffix:suffix in:[NSURL fileURLWithPath:NSTemporaryDirectory()] onError:error];
}

@end
