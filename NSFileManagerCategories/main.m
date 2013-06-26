//
// Sample command-line application
//

#import <Foundation/Foundation.h>
#import "NSFileManager+TemporaryFiles.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSError * error = nil;
        NSURL * fileURL = [[NSFileManager defaultManager] createTemporaryFile:@"upload" suffix:@".dir" onError:&error];
        if ( error ) NSLog ( @"%@", error );
        else [[NSFileManager defaultManager] removeItemAtPath:[fileURL path] error:&error];
        if ( error ) NSLog ( @"%@", error );
    }
    return 0;
}

