/*
 *  Copyright (C) 2011 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *
 *    - Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    - Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    - Neither the name of Stephen F. Booth nor the names of its 
 *      contributors may be used to endorse or promote products derived
 *      from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Cocoa/Cocoa.h>
#import <SFBPopovers/SFBPopoverWindowController.h>

@interface ExampleAppDelegate : NSObject <NSApplicationDelegate>
{
@private
	NSPopUpButton *positionPopup;
	NSColorWell *borderColorWell;
	NSColorWell *backgroundColorWell;
	NSSlider *viewMarginSlider;
	NSSlider *borderWidthSlider;
	NSSlider *cornerRadiusSlider;
	NSButton *hasArrowCheckbox;
	NSButton *drawRoundCornerBesideArrowCheckbox;
	NSSlider *arrowWidthSlider;
	NSSlider *arrowHeightSlider;
	NSSlider *distanceSlider;
	NSButton *toggleButton;

	NSWindow *popoverWindow;
	NSWindow *parametersWindow;

	SFBPopoverWindowController *_popoverController;
}
@property (assign) IBOutlet NSPopUpButton *positionPopup;
@property (assign) IBOutlet NSColorWell *borderColorWell;
@property (assign) IBOutlet NSColorWell *backgroundColorWell;
@property (assign) IBOutlet NSSlider *viewMarginSlider;
@property (assign) IBOutlet NSSlider *borderWidthSlider;
@property (assign) IBOutlet NSSlider *cornerRadiusSlider;
@property (assign) IBOutlet NSButton *hasArrowCheckbox;
@property (assign) IBOutlet NSButton *drawRoundCornerBesideArrowCheckbox;
@property (assign) IBOutlet NSSlider *arrowWidthSlider;
@property (assign) IBOutlet NSSlider *arrowHeightSlider;
@property (assign) IBOutlet NSSlider *distanceSlider;
@property (assign) IBOutlet NSButton *toggleButton;

@property (assign) IBOutlet NSWindow *popoverWindow;
@property (assign) IBOutlet NSWindow *parametersWindow;

- (IBAction) changePosition:(id)sender;
- (IBAction) changeBorderColor:(id)sender;
- (IBAction) changeBackgroundColor:(id)sender;
- (IBAction) changeViewMargin:(id)sender;
- (IBAction) changeBorderWidth:(id)sender;
- (IBAction) changeCornerRadius:(id)sender;
- (IBAction) changeHasArrow:(id)sender;
- (IBAction) changeDrawRoundCornerBesideArrow:(id)sender;
- (IBAction) changeArrowWidth:(id)sender;
- (IBAction) changeArrowHeight:(id)sender;
- (IBAction) changeDistance:(id)sender;

- (IBAction) togglePopover:(id)sender;

@end
