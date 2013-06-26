NSFileManagerCategories
=======================

I really don't like dropping into straight C from objective-c source, so whenever I find myself calling unistd
functions from mainline code more than once, I'll remove it and stick it someplace behind an objective-c class.

In Java you've got a convenient method for creating temporary files using the static File.createTemporaryFile
(see http://docs.oracle.com/javase/6/docs/api/java/io/File.html#createTempFile(java.lang.String, java.lang.String, java.io.File),
but I didn't see anything similar for Cocoa.

I found some good tips on both stackoverflow and cocoawithlove (http://www.cocoawithlove.com/2009/07/temporary-files-and-folders-in-cocoa.html),
so I thought I'd wrap them up and stick them in a category for the NSFileManager class.

I may add some additional helper methods for other file functions in the future, so you may want to watch this project.

Thanks for reading.
-Chris

P.S. Oh, the code is ARC-compatible.  I should probably mention that.
