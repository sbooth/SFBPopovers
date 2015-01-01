/*
 *  Copyright (C) 2011, 2012, 2013, 2014, 2015 Stephen F. Booth <me@sbooth.org>
 *  All Rights Reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
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

@interface ExampleAppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, weak) IBOutlet NSPopUpButton *positionPopup;
@property (nonatomic, weak) IBOutlet NSColorWell *borderColorWell;
@property (nonatomic, weak) IBOutlet NSColorWell *backgroundColorWell;
@property (nonatomic, weak) IBOutlet NSSlider *viewMarginSlider;
@property (nonatomic, weak) IBOutlet NSSlider *borderWidthSlider;
@property (nonatomic, weak) IBOutlet NSSlider *cornerRadiusSlider;
@property (nonatomic, weak) IBOutlet NSButton *hasArrowCheckbox;
@property (nonatomic, weak) IBOutlet NSButton *drawRoundCornerBesideArrowCheckbox;
@property (nonatomic, weak) IBOutlet NSButton *movableCheckbox;
//@property (nonatomic, weak) IBOutlet NSButton *resizableCheckbox;
@property (nonatomic, weak) IBOutlet NSSlider *arrowWidthSlider;
@property (nonatomic, weak) IBOutlet NSSlider *arrowHeightSlider;
@property (nonatomic, weak) IBOutlet NSSlider *distanceSlider;
@property (nonatomic, weak) IBOutlet NSButton *toggleButton;

@property (nonatomic, weak) IBOutlet NSView *popoverView;
@property (nonatomic, weak) IBOutlet NSWindow *parametersWindow;

- (IBAction) changePosition:(id)sender;
- (IBAction) changeBorderColor:(id)sender;
- (IBAction) changeBackgroundColor:(id)sender;
- (IBAction) changeViewMargin:(id)sender;
- (IBAction) changeBorderWidth:(id)sender;
- (IBAction) changeCornerRadius:(id)sender;
- (IBAction) changeHasArrow:(id)sender;
- (IBAction) changeDrawRoundCornerBesideArrow:(id)sender;
- (IBAction) changeMovable:(id)sender;
//- (IBAction) changeResizable:(id)sender;
- (IBAction) changeArrowWidth:(id)sender;
- (IBAction) changeArrowHeight:(id)sender;
- (IBAction) changeDistance:(id)sender;

- (IBAction) togglePopover:(id)sender;

@end
