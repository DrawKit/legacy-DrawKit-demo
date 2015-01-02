#import <Cocoa/Cocoa.h>


@interface NSWindow (SheetAdditions)

- (void)	beginSheet:(NSWindow*) sheet modalDelegate:(id) modalDelegate didEndSelector:(SEL) didEndSelector contextInfo:(void*) contextInfo;
- (void)	beginSheetModalForWindow:(NSWindow*) docWindow modalDelegate:(id) modalDelegate didEndSelector:(SEL) didEndSelector contextInfo:(void*) contextInfo;

@end


/*

provides a more logical way to start sheets than using NSApplication directly by invoking the method on the sheet or the parent window
itself. These are very minimal wrappers around the NSApplicaiton method.

*/

