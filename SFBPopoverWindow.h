/*
 * Copyright (C) 2011 - 2019 Stephen F. Booth <me@sbooth.org>
 * See https://github.com/sbooth/SFBPopovers/blob/master/LICENSE.txt for license information
 */

#import <Foundation/Foundation.h>

#import "SFBPopover.h"

// ========================================
// NSWindow subclass implementing a popover window
// ========================================
@interface SFBPopoverWindow : NSWindow

@property (nonatomic, strong) NSView * _Nullable popoverContentView;

// ========================================
// Popover window properties
- (SFBPopoverPosition) popoverPosition;
- (void) setPopoverPosition:(SFBPopoverPosition)popoverPosition;

- (CGFloat) distance;
- (void) setDistance:(CGFloat)distance;

- (nonnull NSColor *) borderColor;
- (void) setBorderColor:(nonnull NSColor *)borderColor;
- (CGFloat) borderWidth;
- (void) setBorderWidth:(CGFloat)borderWidth;
- (CGFloat) cornerRadius;
- (void) setCornerRadius:(CGFloat)cornerRadius;

- (BOOL) drawsArrow;
- (void) setDrawsArrow:(BOOL)drawsArrow;
- (CGFloat) arrowWidth;
- (void) setArrowWidth:(CGFloat)arrowWidth;
- (CGFloat) arrowHeight;
- (void) setArrowHeight:(CGFloat)arrowHeight;
- (BOOL) drawRoundCornerBesideArrow;
- (void) setDrawRoundCornerBesideArrow:(BOOL)drawRoundCornerBesideArrow;

- (CGFloat) viewMargin;
- (void) setViewMargin:(CGFloat)viewMargin;
- (nonnull NSColor *) popoverBackgroundColor;
- (void) setPopoverBackgroundColor:(nonnull NSColor *)backgroundColor;

- (BOOL) isMovable;
- (void) setMovable:(BOOL)movable;

- (BOOL) isResizable;
- (void) setResizable:(BOOL)resizable;

@end
