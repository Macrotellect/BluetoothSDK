/**
 @file EEGPower.h
 @discussion EEGPower Class
 @author Angelo Wang
 @version 0.7.0  2/28/15 Creation
 @copyright   Copyright (c) 2015 com.neurosky. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 @class EEGPower
 @discussion Parse the stream data to EEGPower object
 */
@interface TGSEEGPower : NSObject

@property (nonatomic,readonly)  int delta;

@property (nonatomic,readonly)  int theta;

@property (nonatomic,readonly)  int lowAlpha;

@property (nonatomic,readonly)  int highAlpha;

@property (nonatomic,readonly)  int lowBeta;

@property (nonatomic,readonly)  int highBeta;

@property (nonatomic,readonly)  int lowGamma;

@property (nonatomic,readonly)  int middleGamma;

/**
 @method initWithBytes
 @discussion Init EEGPower object with bytes array
 @param arr  bytes array
 @param start  the start index
 @param length  length of bytes array
 @return pointer of EEGPower
 */
- (instancetype)initWithBytes:(Byte *)arr st:(int)start len:(int)length;

/**
 *  isValidate
 *  @discussion Check bytes is validate?
 *  @return true: length == 24 && start + length <= arr.length or false
 */
- (bool)isValidate;

@end
