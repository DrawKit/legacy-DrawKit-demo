#import <Cocoa/Cocoa.h>

@interface GCDrawDemoPrefsController : NSWindowController
{
	IBOutlet id			mQualityThrottlingCheckbox;
	IBOutlet id			mUndoSelectionsCheckbox;
	IBOutlet id			mStorageTypeCheckbox;
}


- (IBAction)			qualityThrottlingAction:(id) sender;
- (IBAction)			undoableSelectionAction:(id) sender;
- (IBAction)			setStorageTypeAction:(id) sender;

@end
