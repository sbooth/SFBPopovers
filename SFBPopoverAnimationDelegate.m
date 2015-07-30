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

#import "SFBPopoverAnimationDelegate.h"
#import "SFBPopoverWindow.h"

@implementation SFBPopoverAnimationDelegate {
    
    SFBPopoverWindow* __weak _popoverWindow;
}

- (instancetype)initWithPopoverWindow:(SFBPopoverWindow*)window {
    
    if (self = [super init]) {
        _popoverWindow = window;
    }
    return self;
}

@end

@implementation SFBPopoverAnimationDelegate (NSAnimationDelegateMethods)

- (void) animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
#pragma unused(animation)
    // Detect the end of fade out and close the window
    if(flag && 0 == [_popoverWindow alphaValue]) {
        NSWindow *parentWindow = [_popoverWindow parentWindow];
        [parentWindow removeChildWindow:_popoverWindow];
        [_popoverWindow orderOut:nil];
        [_popoverWindow setAlphaValue:1];
    }
}

@end
