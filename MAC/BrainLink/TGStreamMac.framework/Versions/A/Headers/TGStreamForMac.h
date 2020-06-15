//
//  thinkGear.h
//  blueToothMac
//
//  Created by peterwang on 7/23/15.
//  Copyright (c) 2015 NeuroSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IOBluetooth/IOBluetooth.h>

#import "TGStreamDelegate.h"

@interface TGStreamForMac : NSObject<TGStreamDelegate,NSStreamDelegate>

@property (unsafe_unretained)   id<TGStreamDelegate> delegate;

+ (TGStreamForMac *) sharedInstance;

+ (TGStreamForMac *)sharedInstance:(NSString *)deviceFile;

- (NSString *) getVerison;

- (void) enableLog:(BOOL)enabled;

- (void) initStreamWithFile:(NSString *)filePath;

- (void) startStream;

- (void) stopStream;

- (void) setRecordStreamFilePath;

- (void) setRecordStreamFilePath:(NSString *)filePath;

- (void) startRecordRawData;

- (void) stopRecordRawData;

@end
