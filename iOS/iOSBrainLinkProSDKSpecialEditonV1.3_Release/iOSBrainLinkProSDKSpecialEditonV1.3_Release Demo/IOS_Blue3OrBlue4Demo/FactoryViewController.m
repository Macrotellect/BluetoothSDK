//
//  FactoryViewController.m
//  蓝牙4.0测试
//
//  Created by Macrotellect-iOSDev on 17/5/17.
//  Copyright © 2017年 Macrotellect-iOSDev. All rights reserved.
//

#import "FactoryViewController.h"

#import "HZLBlueData.h"
#import "Blue4Manager.h"

#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface FactoryViewController ()
{
}


@property (weak, nonatomic) IBOutlet UIButton *testABtn;


@property (weak, nonatomic) IBOutlet UILabel *confiLabl;

@property (weak, nonatomic) IBOutlet UIImageView *ASignalIV;
@property (weak, nonatomic) IBOutlet UILabel *ALabl;
@property (weak, nonatomic) IBOutlet UILabel *ARawLabl;
@property (weak, nonatomic) IBOutlet UILabel *ACircleLabl;

@property (weak, nonatomic) IBOutlet UIImageView *BSignalIV;
@property (weak, nonatomic) IBOutlet UILabel *BLabl;
@property (weak, nonatomic) IBOutlet UILabel *BRawLabl;
@property (weak, nonatomic) IBOutlet UILabel *BCircleLabl;

@property (weak, nonatomic) IBOutlet UIImageView *CSignalIV;
@property (weak, nonatomic) IBOutlet UILabel *CLabl;
@property (weak, nonatomic) IBOutlet UILabel *CRawLabl;
@property (weak, nonatomic) IBOutlet UILabel *CCircleLabl;

@property (weak, nonatomic) IBOutlet UIImageView *DSignalIV;
@property (weak, nonatomic) IBOutlet UILabel *DLabl;
@property (weak, nonatomic) IBOutlet UILabel *DRawLabl;
@property (weak, nonatomic) IBOutlet UILabel *DCircleLabl;

@property (weak, nonatomic) IBOutlet UIImageView *ESignalIV;
@property (weak, nonatomic) IBOutlet UILabel *ELabl;
@property (weak, nonatomic) IBOutlet UILabel *ERawLabl;
@property (weak, nonatomic) IBOutlet UILabel *ECircleLabl;

@property (weak, nonatomic) IBOutlet UIImageView *FSignalIV;
@property (weak, nonatomic) IBOutlet UILabel *FLabl;
@property (weak, nonatomic) IBOutlet UILabel *FRawLabl;
@property (weak, nonatomic) IBOutlet UILabel *FCircleLabl;




@end

@implementation FactoryViewController

#pragma 改变连接个数 大于0的整数

- (void)viewDidLoad {
    [super viewDidLoad];

    _testABtn.titleLabel.numberOfLines = 0;

    
    NSString *deviceText= @"";
    for (int i = 0; i < _deviceNames.count; i++) {
        NSString *item = _deviceNames[i];
        deviceText = [deviceText stringByAppendingString:item];
        if (i != _deviceNames.count-1) {
            deviceText = [deviceText stringByAppendingString:@","];
        }
    }
    _confiLabl.text = [NSString stringWithFormat:@"当前可连接设备名：%@ 可连接个数：%d",deviceText,_devSum];
    
    //蓝牙连接设置
    [Blue4Manager logEnable:YES];
    [[Blue4Manager shareInstance] configureBlueNames:_deviceNames ableDeviceSum:_devSum];
    //连接蓝牙成功回调
     __weak FactoryViewController *weakSelf = self;
     [Blue4Manager shareInstance].blueConBlock = ^(NSString *markKey) {
         if ([markKey isEqualToString:@"1"]) {
             //判断连接的设备
             NSLog(@"A设备 蓝牙 连接成功");
         }
         else if ([markKey isEqualToString:@"2"]){
             //判断连接的设备
            NSLog(@"B设备 蓝牙 连接成功");
         }
         else if ([markKey isEqualToString:@"3"]){
             //判断连接的设备
             NSLog(@"C设备 蓝牙 连接成功");
         }
         else if ([markKey isEqualToString:@"4"]){
             //判断连接的设备
             NSLog(@"D设备 蓝牙 连接成功");
         }
         else if ([markKey isEqualToString:@"5"]){
             //判断连接的设备
             NSLog(@"E设备 蓝牙 连接成功");
         }
         else if ([markKey isEqualToString:@"6"]){
             //判断连接的设备
             NSLog(@"F设备 蓝牙 连接成功");
         }
         else if ([markKey isEqualToString:@"7"]){
             //判断连接的设备
             NSLog(@"G设备 蓝牙 连接成功");
         }
         
     };
     
     //蓝牙断开回调
     [Blue4Manager shareInstance].blueDisBlock =   ^(NSString *markKey){
         if ([markKey isEqualToString:@"1"]) {
             //判断连接的设备
             NSLog(@"A设备 蓝牙 断开");
             weakSelf.ALabl.text = @"";
             weakSelf.ACircleLabl.text = @"";
             weakSelf.ARawLabl.text = @"";
             weakSelf.ASignalIV.image = [UIImage imageNamed:@"noSignal"];
         }
         else if ([markKey isEqualToString:@"2"]){
             //判断连接的设备
             NSLog(@"B设备 蓝牙 断开");
             weakSelf.BLabl.text = @"";
             weakSelf.BCircleLabl.text = @"";
             weakSelf.BRawLabl.text = @"";
             weakSelf.BSignalIV.image = [UIImage imageNamed:@"noSignal"];
         }
         else if ([markKey isEqualToString:@"3"]){
             //判断连接的设备
             NSLog(@"C设备 蓝牙 断开");
             weakSelf.CLabl.text = @"";
             weakSelf.CCircleLabl.text = @"";
             weakSelf.CRawLabl.text = @"";
             weakSelf.CSignalIV.image = [UIImage imageNamed:@"noSignal"];
         }
         else if ([markKey isEqualToString:@"4"]){
             //判断连接的设备
             NSLog(@"D设备 蓝牙 断开");
             weakSelf.DLabl.text = @"";
             weakSelf.DCircleLabl.text = @"";
             weakSelf.DRawLabl.text = @"";
             weakSelf.DSignalIV.image = [UIImage imageNamed:@"noSignal"];
         }
         else if ([markKey isEqualToString:@"5"]){
             //判断连接的设备
             NSLog(@"E设备 蓝牙 断开");
             weakSelf.ELabl.text = @"";
             weakSelf.ECircleLabl.text = @"";
             weakSelf.ERawLabl.text = @"";
             weakSelf.ESignalIV.image = [UIImage imageNamed:@"noSignal"];
         }
         else if ([markKey isEqualToString:@"6"]){
             //判断连接的设备
             NSLog(@"F设备 蓝牙 断开");
             weakSelf.FLabl.text = @"";
             weakSelf.FCircleLabl.text = @"";
             weakSelf.FRawLabl.text = @"";
             weakSelf.FSignalIV.image = [UIImage imageNamed:@"noSignal"];
         }
        
     };
     
     
     [Blue4Manager shareInstance].hzlblueDataBlock_A = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.ALabl.text =    [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d version:%d grid=%d ",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma,blueData.hardwareVersion,blueData.grind];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.ASignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.ASignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
             else if (blueData.bleDataType == BLEGRAVITY) {
                 weakSelf.ACircleLabl.text =  [NSString stringWithFormat:@"x:%d y:%d z:%d",blueData.xvlaue,blueData.yvlaue,blueData.zvlaue];
             }
             else if (blueData.bleDataType == BLERaw) {
                 weakSelf.ARawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
             }
         }
         else if (conBT == BlueType_Jii){
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.ALabl.text =  [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.ASignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.ASignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
         }
         else if (conBT == BlueType_Lite) {
               if (blueData.bleDataType == BLEMIND) {
                   weakSelf.ALabl.text =   [NSString stringWithFormat:@"sigal:%d att:%d med:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma];
                   //信号值为0 即佩戴了蓝牙设备
                   //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                   if(blueData.signal == 0){
                       weakSelf.ASignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                   }else{
                       weakSelf.ASignalIV.image = [UIImage imageNamed:@"signal3.png"];
                   }
               }
               else if (blueData.bleDataType == BLERaw) {
                   weakSelf.ARawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
               }
         }
               
         
         if (isFalseCon) {
             NSLog(@"A设备假连接");
         }
     };
     
     [Blue4Manager shareInstance].hzlblueDataBlock_B = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.BLabl.text =    [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d version:%d grid=%d ",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma,blueData.hardwareVersion,blueData.grind];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.BSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.BSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
             else if (blueData.bleDataType == BLEGRAVITY) {
                 weakSelf.BCircleLabl.text =  [NSString stringWithFormat:@"x:%d y:%d z:%d",blueData.xvlaue,blueData.yvlaue,blueData.zvlaue];
             }
             else if (blueData.bleDataType == BLERaw) {
                 weakSelf.BRawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
             }
         }
         else if (conBT == BlueType_Jii){
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.BLabl.text =  [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.BSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.BSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
         }
         else if (conBT == BlueType_Lite) {
               if (blueData.bleDataType == BLEMIND) {
                   weakSelf.BLabl.text =   [NSString stringWithFormat:@"sigal:%d att:%d med:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma];
                   //信号值为0 即佩戴了蓝牙设备
                   //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                   if(blueData.signal == 0){
                       weakSelf.BSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                   }else{
                       weakSelf.BSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                   }
               }
               else if (blueData.bleDataType == BLERaw) {
                   weakSelf.BRawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
               }
         }
            
         if (isFalseCon) {
             NSLog(@"B设备假连接");
         }
     };
     
     [Blue4Manager shareInstance].hzlblueDataBlock_C = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.CLabl.text =    [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d version:%d grid=%d ",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma,blueData.hardwareVersion,blueData.grind];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.CSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.CSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
             else if (blueData.bleDataType == BLEGRAVITY) {
                 weakSelf.CCircleLabl.text =  [NSString stringWithFormat:@"x:%d y:%d z:%d",blueData.xvlaue,blueData.yvlaue,blueData.zvlaue];
             }
             else if (blueData.bleDataType == BLERaw) {
                 weakSelf.CRawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
             }
         }
         else if (conBT == BlueType_Jii){
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.CLabl.text =  [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.CSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.CSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
         }
         else if (conBT == BlueType_Lite) {
               if (blueData.bleDataType == BLEMIND) {
                   weakSelf.CLabl.text =   [NSString stringWithFormat:@"sigal:%d att:%d med:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma];
                   //信号值为0 即佩戴了蓝牙设备
                   //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                   if(blueData.signal == 0){
                       weakSelf.CSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                   }else{
                       weakSelf.CSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                   }
               }
               else if (blueData.bleDataType == BLERaw) {
                   weakSelf.CRawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
               }
         }
            
         
         if (isFalseCon) {
             NSLog(@"C设备假连接");
         }
     };
     
     
     [Blue4Manager shareInstance].hzlblueDataBlock_D = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.DLabl.text =    [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d version:%d grid=%d ",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma,blueData.hardwareVersion,blueData.grind];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.DSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.DSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
             else if (blueData.bleDataType == BLEGRAVITY) {
                 weakSelf.DCircleLabl.text =  [NSString stringWithFormat:@"x:%d y:%d z:%d",blueData.xvlaue,blueData.yvlaue,blueData.zvlaue];
             }
             else if (blueData.bleDataType == BLERaw) {
                 weakSelf.DRawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
             }
         }
         else if (conBT == BlueType_Jii){
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.DLabl.text =  [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.DSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.DSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
         }
         else if (conBT == BlueType_Lite) {
               if (blueData.bleDataType == BLEMIND) {
                   weakSelf.DLabl.text =   [NSString stringWithFormat:@"sigal:%d att:%d med:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma];
                   //信号值为0 即佩戴了蓝牙设备
                   //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                   if(blueData.signal == 0){
                       weakSelf.DSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                   }else{
                       weakSelf.DSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                   }
               }
               else if (blueData.bleDataType == BLERaw) {
                   weakSelf.DRawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
               }
         }
            
         
         if (isFalseCon) {
             NSLog(@"D设备假连接");
         }
     };
     
     [Blue4Manager shareInstance].hzlblueDataBlock_E = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.ELabl.text =    [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d version:%d grid=%d , ",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma,blueData.hardwareVersion,blueData.grind];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.ESignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.ESignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
             else if (blueData.bleDataType == BLEGRAVITY) {
                 weakSelf.ECircleLabl.text =  [NSString stringWithFormat:@"x:%d y:%d z:%d",blueData.xvlaue,blueData.yvlaue,blueData.zvlaue];
             }
             else if (blueData.bleDataType == BLERaw) {
                 weakSelf.ERawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
             }
         }
         else if (conBT == BlueType_Jii){
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.ELabl.text =  [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.ESignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.ESignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
         }
         else if (conBT == BlueType_Lite) {
               if (blueData.bleDataType == BLEMIND) {
                   weakSelf.ELabl.text =   [NSString stringWithFormat:@"sigal:%d att:%d med:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma];
                   //信号值为0 即佩戴了蓝牙设备
                   //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                   if(blueData.signal == 0){
                       weakSelf.ESignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                   }else{
                       weakSelf.ESignalIV.image = [UIImage imageNamed:@"signal3.png"];
                   }
               }
               else if (blueData.bleDataType == BLERaw) {
                   weakSelf.ERawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
               }
         }
            
         
         if (isFalseCon) {
             NSLog(@"E设备假连接");
         }
     };
     
     [Blue4Manager shareInstance].hzlblueDataBlock_F = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro) {
             if (blueData.bleDataType == BLEMIND) {
               
                 
                 weakSelf.FLabl.text =    [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d version:%d grid=%d ",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma,blueData.hardwareVersion,blueData.grind];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.FSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.FSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
             else if (blueData.bleDataType == BLEGRAVITY) {
                 weakSelf.FCircleLabl.text =  [NSString stringWithFormat:@"x:%d y:%d z:%d",blueData.xvlaue,blueData.yvlaue,blueData.zvlaue];
             }
             else if (blueData.bleDataType == BLERaw) {
                 weakSelf.FRawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
             }
         }
         else if (conBT == BlueType_Jii){
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.FLabl.text =  [NSString stringWithFormat:@"sigal:%d att:%d med:%d ele:%d ap:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.batteryCapacity,blueData.ap];
                 //信号值为0 即佩戴了蓝牙设备
                 //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                 if(blueData.signal == 0){
                     weakSelf.FSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                     weakSelf.FSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                 }
             }
         }
         else if (conBT == BlueType_Lite) {
               if (blueData.bleDataType == BLEMIND) {
                   weakSelf.FLabl.text =   [NSString stringWithFormat:@"sigal:%d att:%d med:%d del:%d theta:%d lowAlp:%d highAlp:%d lowBe:%d highBe:%d lowGa:%d highGa:%d",blueData.signal,blueData.attention,blueData.meditation,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma];
                   //信号值为0 即佩戴了蓝牙设备
                   //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                   if(blueData.signal == 0){
                       weakSelf.FSignalIV.image = [UIImage imageNamed:@"signal_zhengChang"];
                   }else{
                       weakSelf.FSignalIV.image = [UIImage imageNamed:@"signal3.png"];
                   }
               }
               else if (blueData.bleDataType == BLERaw) {
                   weakSelf.FRawLabl.text = [NSString stringWithFormat:@"raw:%d eye:%d",blueData.raw,blueData.blinkeye];
               }
         }
            
         
         if (isFalseCon) {
             NSLog(@"F设备假连接");
         }
     };
     
     
      
    [[Blue4Manager shareInstance] connectBlue4];
               
             
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

}

- (IBAction)back:(id)sender
{
   [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)testA:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setTitle:@"当前测试A假连接" forState:UIControlStateNormal];
        [btn setTintColor:UIColor.whiteColor];
        [[Blue4Manager shareInstance] testAFalseCon:YES];
    }else{
        [btn setTitle:@"当前不测试A假连接" forState:UIControlStateNormal];
        [[Blue4Manager shareInstance] testAFalseCon:NO];
    }
}



#pragma 断开蓝牙
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[Blue4Manager shareInstance] setTestToZero];
    [[Blue4Manager shareInstance] disConnectBlue4];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
