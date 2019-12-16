/*
 * Copyright (C) 2011 - 2019 Stephen F. Booth <me@sbooth.org>
 * See https://github.com/sbooth/SFBPopovers/blob/master/LICENSE.txt for license information
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
