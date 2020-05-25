//
//  AppDelegate.m
//  TGStreamMacDemo
//
//  Created by peterwang on 8/11/15.
//  Copyright (c) 2015 NeuroSky. All rights reserved.
//

#import "AppDelegate.h"
#import <TGStreamMac/TGStreamForMac.h>
#import <TGStreamMac/TGSEEGPower.h>

@interface AppDelegate (){
    
    TGStreamForMac           *streamMac;
}

@property (assign) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    // Insert code here to initialize your application
    NSString *devices=@"/dev/tty.BrainLink-SerialPort";
    streamMac=[TGStreamForMac sharedInstance:devices];
//    streamMac=[TGStreamForMac sharedInstance];
    streamMac.delegate=self;
    [streamMac enableLog:false];
    [streamMac setRecordStreamFilePath:@""];
    NSLog(@"getVersion:%@",[streamMac getVerison]);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - TGStream delegate
-(void) onDataReceived:(NSInteger)datatype data:(int)data obj:(NSObject *)obj {
    
    switch(datatype)
    {
            case 0xBA:
            case 0xBC:
            NSLog(@"Command-%02lx: %d", (long)datatype, data);
            break;
            
        default:
            break;
    }
    
    //-NSLog(@"dataType:%d data:%d",(int)datatype,data);
    
    if (obj) {
        
        TGSEEGPower *kEEGPower=(TGSEEGPower *)obj;
        NSString *TGSEEGPowerSrting=[NSString stringWithFormat:@" TGSEEGPower delta-- %d\n TGSEEGPower theta-- %d\n TGSEEGPower lowAlpha-- %d\n TGSEEGPower highAlpha-- %d\n TGSEEGPower lowBeta-- %d\n TGSEEGPower highAlpha-- %d\n TGSEEGPower lowGamma-- %d\n TGSEEGPower lowGamma-- %d\n ",
                                     kEEGPower.delta,
                                     kEEGPower.theta,
                                     kEEGPower.lowAlpha,
                                     kEEGPower.highAlpha,
                                     kEEGPower.lowBeta,
                                     kEEGPower.highAlpha,
                                     kEEGPower.lowGamma,
                                     kEEGPower.lowGamma];
     //-   NSLog(@"%@",TGSEEGPowerSrting);
        
    }
    
}

-(void)onStatesChanged:(ConnectionStates)connectionState;{
    
    NSString *connectState;
    
    switch (connectionState) {
        case STATE_CONNECTED:
            connectState=@"1 - STATE_CONNECTED";
            break;
            
        case STATE_WORKING:
            connectState=@"2 - STATE_WORKING";
            break;
            
        case STATE_STOPPED:
            connectState=@"3 - STATE_STOPPED";
            break;
            
        case STATE_DISCONNECTED:
            connectState=@"4 - STATE_DISCONNECTED";
            break;
            
        case STATE_COMPLETE:
            connectState=@"5 - STATE_COMPLETE";
            break;
            
        case STATE_RECORDING_START:
            connectState=@"7 - STATE_RECORDING_START";
            break;
            
        case STATE_RECORDING_END:
            connectState=@"8 - STATE_RECORDING_END";
            break;
            
        case STATE_FAILED:
            connectState=@"100 - STATE_FAILED";
            break;
            
        case STATE_ERROR:
            connectState=@"101 - STATE_ERROR";
            break;
            
        default:
            break;
    }
    
    NSLog(@"Connection States:%@",connectState);
    
}

static NSUInteger checkSum=0;

-(void) onChecksumFail:(Byte *)payload length:(NSUInteger)length checksum:(NSInteger)checksum{
    
    checkSum++;
    
    NSLog(@"CheckSum lentgh:%lu  CheckSum:%lu",(unsigned long)length,(unsigned long)checksum);
    
    NSLog(@"CheckSum total: %d",(int)checkSum);
    
}

-(void) onRecordFail:(RecrodError)flag{
    
    NSString *recordFlag;
    
    switch (flag)
    {
        case RECORD_ERROR_FILE_PATH_NOT_READY:
            recordFlag=@"RECORD_ERROR_FILE_PATH_NOT_READY";
            break;
            
        case RECORD_ERROR_RECORD_IS_ALREADY_WORKING:
            recordFlag=@"RECORD_ERROR_RECORD_IS_ALREADY_WORKING";
            break;
            
        case RECORD_ERROR_RECORD_OPEN_FILE_FAILED:
            recordFlag=@"RECORD_ERROR_RECORD_OPEN_FILE_FAILED";
            break;
            
        case RECORD_ERROR_RECORD_WRITE_FILE_FAILED:
            recordFlag=@"RECORD_ERROR_RECORD_WRITE_FILE_FAILED";
            break;
            
    }
    
    NSLog(@"RecordFail %@",recordFlag);
    
}

#pragma mark - button action
- (IBAction)recordBegin:(NSButton *)sender {
    [streamMac startRecordRawData];
}

- (IBAction)recordEnd:(id)sender {
    [streamMac stopRecordRawData];
}

- (IBAction)initBT:(id)sender {
    [streamMac startStream];
}

- (IBAction)initFile:(id)sender
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    //    NSString *filePath = [mainBundle pathForResource:@"sample_data" ofType:@"txt"];
    NSString *filePath = [mainBundle pathForResource:@"OneCheckSumFail" ofType:@"txt"];
    
    [streamMac initStreamWithFile:filePath];
    checkSum=0;
    
}

- (IBAction)stop:(id)sender {
    
    [streamMac stopStream];
    
}

@end
