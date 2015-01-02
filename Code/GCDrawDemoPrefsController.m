#import "GCDrawDemoPrefsController.h"
#import "GCDrawDemoDocument.h"
#import <GCDrawKit/DKObjectDrawingLayer.h>
#import <GCDrawKit/DKBSPObjectStorage.h>

@implementation GCDrawDemoPrefsController

- (IBAction)			qualityThrottlingAction:(id) sender
{
	[GCDrawDemoDocument setDefaultQualityModulation:[sender intValue]];
}


- (IBAction)			undoableSelectionAction:(id) sender
{
	[DKObjectDrawingLayer setDefaultSelectionChangesAreUndoable:[sender intValue]];
}


- (IBAction)			setStorageTypeAction:(id) sender
{
	if([sender intValue] == 0 )
		[DKObjectOwnerLayer setStorageClass:[DKLinearObjectStorage class]];
	else
		[DKObjectOwnerLayer setStorageClass:[DKBSPObjectStorage class]];
	
	[[NSUserDefaults standardUserDefaults] setObject:NSStringFromClass([DKObjectOwnerLayer storageClass]) forKey:@"DKObjectStorageClass"];
}


- (void)				awakeFromNib
{
	[mQualityThrottlingCheckbox setIntValue:[GCDrawDemoDocument defaultQualityModulation]];
	[mUndoSelectionsCheckbox setIntValue:[DKObjectDrawingLayer defaultSelectionChangesAreUndoable]];
	[mStorageTypeCheckbox setIntValue:0];
}


@end
