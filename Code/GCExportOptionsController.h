//
//  GCExportOptionsController.h
//  GCDrawKit
//
//  Created by graham on 11/07/2008.
//  Copyright 2008 Apptree.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GCExportOptionsController : NSObject
{
	IBOutlet	id			mExportAccessoryView;
	IBOutlet	id			mExportFormatPopUpButton;
	IBOutlet	id			mExportResolutionPopUpButton;
	IBOutlet	id			mExportIncludeGridCheckbox;
	IBOutlet	id			mExportOptionsTabView;
	IBOutlet	id			mJPEGQualitySlider;
	IBOutlet	id			mJPEGProgressiveCheckbox;
	IBOutlet	id			mPNGInterlaceCheckbox;
	IBOutlet	id			mTIFFCompressionTypePopUpButton;
	IBOutlet	id			mTIFFAlphaCheckbox;
	
	NSSavePanel*			mSavePanel;
	id						mDelegate;
	NSMutableDictionary*	mOptionsDict;
	NSBitmapImageFileType	mFileType;
}


- (void)		beginExportDialogWithParentWindow:(NSWindow*) parent delegate:(id) delegate;

- (IBAction)	formatPopUpAction:(id) sender;
- (IBAction)	resolutionPopUpAction:(id) sender;
- (IBAction)	formatIncludeGridAction:(id) sender;
- (IBAction)	jpegQualityAction:(id) sender;
- (IBAction)	jpegProgressiveAction:(id) sender;
- (IBAction)	tiffCompressionAction:(id) sender;
- (IBAction)	tiffAlphaAction:(id) sender;
- (IBAction)	pngInterlaceAction:(id) sender;

- (void)		displayOptionsForFileType:(int) type;
- (void)		exportPanelDidEnd:(NSSavePanel*) sp returnCode:(int) returnCode contextInfo:(void*) contextInfo;

@end


// delegate protocol:

@interface NSObject (ExportControllerDelegate)

- (void)	performExportType:(NSBitmapImageFileType) fileType withOptions:(NSDictionary*) options;	

@end

// to unify the file types for export, the following is used to indicate export to PDF

enum
{
	NSPDFFileType		= -1
};

// additional keys for option properties not used by Cocoa

extern NSString*		kGCIncludeGridInExportedFile;	// BOOL property
extern NSString*		kGCExportedFileURL;				// NSURL property



