/**
 @file TGStreamDelegate.h
 @discussion TGStreamDelegate header in CommunicationSDK
 @author Angelo Wang
 @version 0.7.0  3/2/15 Creation
 @copyright   Copyright (c) 2015 com.neurosky. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "TGStreamEnum.h"

/**
 @protocol TGStreamDelegate
 @abstract TGStreamDelegate Protocol
 @discussion output data & class status
 */

@protocol TGStreamDelegate <NSObject>

/**
 @method onDataReceived
 @discussion When data received, this function will be called.
 @param datatype  type of data
 @param data  data value
 @param obj  return a obj such EEGPower instance
 @return void
 */
-(void)onDataReceived:(NSInteger)datatype data:(int)data obj:(NSObject *)obj;


@optional

/**
 @method onStatesChanged
 @discussion When the connection state changed, this method will be called.
 @param connectionState  output the connection state
 @return void
 */
-(void)onStatesChanged:(ConnectionStates)connectionState;

/**
 @method onChecksumFail
 @discussion When check sum error happens, this method will be called.
 @param payload  playload byte data
 @param length  length of playload
 @param checksum  the checksum value
 @return void
 */
-(void) onChecksumFail:(Byte *)payload length:(NSUInteger)length checksum:(NSInteger)checksum;

/**
 @method onRecordFail
 @discussion When you call startRecordRawData(), and some error happens, this method will be called.
 @param flag  record error flag
 @return void
 */

-(void)onRecordFail:(RecrodError)flag;

@end