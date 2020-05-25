//
//  AppDelegate.h
//  TGStreamMacDemo
//
//  Created by peterwang on 8/11/15.
//  Copyright (c) 2015 NeuroSky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <TGStreamMac/TGStreamDelegate.h>

@interface AppDelegate : NSObject <NSApplicationDelegate,TGStreamDelegate>

- (IBAction)recordBegin:(NSButton *)sender;

- (IBAction)recordEnd:(id)sender;

- (IBAction)initBT:(id)sender;

- (IBAction)initFile:(id)sender;

- (IBAction)stop:(id)sender;


@end

