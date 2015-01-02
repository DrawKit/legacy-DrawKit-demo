#import "NSWindow+SheetAdditions.h"


@implementation NSWindow (SheetAdditions)


- (void)	beginSheet:(NSWindow*) sheet modalDelegate:(id) modalDelegate didEndSelector:(SEL) didEndSelector contextInfo:(void*) contextInfo
{
	[NSApp beginSheet:sheet modalForWindow:self modalDelegate:modalDelegate didEndSelector:didEndSelector contextInfo:contextInfo];
}


- (void)	beginSheetModalForWindow:(NSWindow*) docWindow modalDelegate:(id) modalDelegate didEndSelector:(SEL) didEndSelector contextInfo:(void*) contextInfo;
{
	[NSApp beginSheet:self modalForWindow:docWindow modalDelegate:modalDelegate didEndSelector:didEndSelector contextInfo:contextInfo];
}


@end
