//
// Copyright (c) 2011 - 2021 Stephen F. Booth <me@sbooth.org>
// Part of https://github.com/sbooth/SFBPopovers
// MIT license
//

#import <Foundation/Foundation.h>

#import "SFBPopover.h"

/// @c NSWindow subclass implementing a popover window
@interface SFBPopoverWindow : NSWindow

@property (nonatomic, strong, nullable) NSView * popoverContentView;

// MARK: Popover window properties

@property (nonatomic, assign) SFBPopoverPosition popoverPosition;

@property (nonatomic, assign) CGFloat distance;

@property (nonatomic, copy, nonnull) NSColor * borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) BOOL drawsArrow;
@property (nonatomic, assign) CGFloat arrowWidth;
@property (nonatomic, assign) CGFloat arrowHeight;
@property (nonatomic, assign) BOOL drawRoundCornerBesideArrow;

@property (nonatomic, assign) CGFloat viewMargin;
@property (nonatomic, copy, nonnull) NSColor * popoverBackgroundColor;

@property (nonatomic, assign, getter=isPopoverMovable) BOOL popoverMovable;

@property (nonatomic, assign, getter=isPopoverResizable) BOOL popoverResizable;

@end
