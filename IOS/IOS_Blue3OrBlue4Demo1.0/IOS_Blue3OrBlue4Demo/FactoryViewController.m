//
//  FactoryViewController.m
//  蓝牙4.0测试
//
//  Created by Macrotellect-iOSDev on 17/5/17.
//  Copyright © 2017年 Macrotellect-iOSDev. All rights reserved.
//

#import "FactoryViewController.h"

#import "Blue3OrBlue4Manager.h"

#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface FactoryViewController ()
{

}

@property (weak, nonatomic) IBOutlet UIImageView *signalIv;

@property (weak, nonatomic) IBOutlet UIButton *makeSureBu;
@property (weak, nonatomic) IBOutlet UITextField *conSumTf;

@property (weak, nonatomic) IBOutlet UILabel *electricityLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionlabel;
@property (weak, nonatomic) IBOutlet UILabel *medlabel;
@property (weak, nonatomic) IBOutlet UILabel *favrouteRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *circleRateLabel;

@property (weak, nonatomic) IBOutlet UILabel *rawLabel;

@property (weak, nonatomic) IBOutlet UILabel *otherLabel;

@property (weak, nonatomic) IBOutlet UILabel *pDataLabbel;

@end

@implementation FactoryViewController

#pragma 改变连接个数 大于0的整数

- (void)viewDidLoad {
    [super viewDidLoad];

    //蓝牙连接
    NSArray *blue3Name = @[@"BrainLink",@"BrainLink_Pro"];
    [Blue3OrBlue4Manager logEnable:YES];
    [[Blue3OrBlue4Manager shareInstance] configureBlue3MFiOrBlue4Names:blue3Name];
   
    //连接蓝牙成功回调
      __weak FactoryViewController *weakSelf = self;
    [Blue3OrBlue4Manager shareInstance].blueConBlock =  ^(BlueType conBT){
        //判断连接的设备
        if (conBT == BlueType_3) {
            NSLog(@"蓝牙3.0连接");
        }
        else if(conBT == BlueType_4Pro)
        {
            NSLog(@"蓝牙4.0 Pro连接");
        }
        else if (conBT == BlueType_4Jii){
            NSLog(@"蓝牙4.0 Jii连接");
        }
    };
    
    
    //蓝牙断开回调
    [Blue3OrBlue4Manager shareInstance].blueDisBlock =  ^(BlueType disBT){
        if (disBT == BlueType_3) {
            NSLog(@"蓝牙3.0断开");
        }
        else if(disBT == BlueType_4Pro)
        {
            NSLog(@"蓝牙4.0 Pro断开");
        }
        else if(disBT == BlueType_4Jii)
        {
            NSLog(@"蓝牙4.0 Jii断开");
        }
        
        weakSelf.signalIv.image = [UIImage imageNamed:@"noSignal"];
        
        weakSelf.attentionlabel.text = @"";
        weakSelf.medlabel.text = @"";
        weakSelf.electricityLabel.text = @"";
        weakSelf.favrouteRateLabel.text = @"";
        weakSelf.otherLabel.text = @"";
        
        weakSelf.circleRateLabel.text = @"";
        
        weakSelf.rawLabel.text = @"";
        weakSelf.pDataLabbel.text= @"";
    };
    
  
    
    
    [Blue3OrBlue4Manager shareInstance].hzlblueDataBlock = ^(HZLBlueData *blueData, BlueType conBT){
        
        if (conBT == BlueType_4Pro) {
            NSString *peripID = [blueData.identifier substringWithRange:NSMakeRange(blueData.identifier.length - 5, 4)];
            if (blueData.bleDataType == BLEMIND) {
                
                weakSelf.attentionlabel.text  =   [NSString stringWithFormat:@"%@=%d",peripID,blueData.attention];
                weakSelf.medlabel.text  =   [NSString stringWithFormat:@"%@=%d",peripID,blueData.meditation];
                weakSelf.electricityLabel.text  =   [NSString stringWithFormat:@"%@=%d",peripID, blueData.batteryCapacity];
                weakSelf.favrouteRateLabel.text = [NSString stringWithFormat:@"%@=%d  ",peripID,blueData.ap];
                
                weakSelf.otherLabel.text = [NSString stringWithFormat:
                                            @"%@=Delta:%d Theta:%d LowAlpha:%d HighAlpha:%d LowBeta:%d HighBeta:%d LowGamma:%d HighGamma:%d Hardwareversion:%d  grid=%d",peripID,blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma,blueData.hardwareVersion,blueData.grind];
                
                //信号值为0 即佩戴了蓝牙设备
                //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                if(blueData.signal == 0){
                    weakSelf.signalIv.image = [UIImage imageNamed:@"signal_zhengChang"];
                }else{
                     weakSelf.signalIv.image = [UIImage imageNamed:@"signal3.png"];
                }

            }
            if (blueData.bleDataType == BLEGRAVITY) {
                weakSelf.circleRateLabel.text = [NSString stringWithFormat:@"%@=x:%d y:%d z:%d ",peripID,blueData.xvlaue,blueData.yvlaue,blueData.zvlaue];
            }
            if(blueData.bleDataType == BLERaw)
            {
                  weakSelf.rawLabel.text = [NSString stringWithFormat:@"Blue3=Raw:%d Blinkeye:%d",blueData.raw,blueData.blinkeye];
            }
            
//            if (blueData.bleDataType == BLE_PrePackageForHzl) {
//                weakSelf.pDataLabbel.text = [NSString stringWithFormat:@"%@=长度:%lu \n数据:\n%@",peripID,(unsigned long)blueData.prePackageStrForHzl.length,blueData.prePackageStrForHzl];
//            }
            
        }
        else if (conBT == BlueType_4Jii){
            NSString *peripID = [blueData.identifier substringWithRange:NSMakeRange(blueData.identifier.length - 5, 4)];
            if (blueData.bleDataType == BLEMIND){
                
                weakSelf.attentionlabel.text  =   [NSString stringWithFormat:@"%@=%d",peripID,blueData.attention];
                weakSelf.medlabel.text  =   [NSString stringWithFormat:@"%@=%d",peripID,blueData.meditation];
                weakSelf.electricityLabel.text  =   [NSString stringWithFormat:@"%@=%d",peripID, blueData.batteryCapacity];
                weakSelf.favrouteRateLabel.text = [NSString stringWithFormat:@"%@=%d  ",peripID,blueData.ap];
                
               //信号值为0 即佩戴了蓝牙设备
               //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
               if(blueData.signal == 0){
                   weakSelf.signalIv.image = [UIImage imageNamed:@"signal_zhengChang"];
               }else{
                    weakSelf.signalIv.image = [UIImage imageNamed:@"signal3.png"];
               }
            }
            
            
        }
        else if (conBT == BlueType_3){
            if (blueData.bleDataType == BLEMIND){
                
                weakSelf.attentionlabel.text  =   [NSString stringWithFormat:@"Blue3=%d",blueData.attention];
                weakSelf.medlabel.text  =   [NSString stringWithFormat:@"Blue3=%d",blueData.meditation];
                
                weakSelf.otherLabel.text = [NSString stringWithFormat:
                                            @"Blue3=Delta:%d Theta:%d LowAlpha:%d HighAlpha:%d LowBeta:%d HighBeta:%d LowGamma:%d HighGamma:%d ",blueData.delta,blueData.theta,blueData.lowAlpha,blueData.highAlpha,blueData.lowBeta,blueData.highBeta,blueData.lowGamma,blueData.highGamma];
               
                  //信号值为0 即佩戴了蓝牙设备
                  //注：如果连接了蓝牙设备而未佩戴，信号值为大于0且小于或等于200
                  if(blueData.signal == 0){
                      weakSelf.signalIv.image = [UIImage imageNamed:@"signal_zhengChang"];
                  }else{
                       weakSelf.signalIv.image = [UIImage imageNamed:@"signal3.png"];
                  }
            }
            
            if(blueData.bleDataType == BLERaw){
                weakSelf.rawLabel.text = [NSString stringWithFormat:@"Blue3=Raw:%d Blinkeye:%d",blueData.raw,blueData.blinkeye];
            }
            
//            if (blueData.bleDataType == BLE_PrePackageForHzl) {
//                weakSelf.pDataLabbel.text = [NSString stringWithFormat:@"长度:%lu \n数据:\n%@",(unsigned long)blueData.prePackageStrForHzl.length,blueData.prePackageStrForHzl];
//            }
        }
    };
    
    [[Blue3OrBlue4Manager shareInstance] connectBlue3OrBlue4];
    
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



- (IBAction)back:(id)sender
{
   [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma 断开蓝牙
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[Blue3OrBlue4Manager shareInstance] disConnectBlue3OrBlue4];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
