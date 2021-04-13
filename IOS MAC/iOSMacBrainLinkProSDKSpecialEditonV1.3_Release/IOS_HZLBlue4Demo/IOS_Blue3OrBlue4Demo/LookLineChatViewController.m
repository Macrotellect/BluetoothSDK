//
//  LookLineChatViewController.m
//  蓝牙4.0测试
//
//  Created by Macrotellect-iOSDev on 2018/5/9.
//  Copyright © 2018年 Macrotellect-iOSDev. All rights reserved.
//

#define ColorX_Med 0xf19149
#define ColorX_Att 0x3589C8
#define ColorX_A 0xef4b57
#define ColorX_B 0xfdb74b
#define ColorX_C 0xc6d180

#define ColorX_D 0x72c469
#define ColorX_E 0x4b8cb2
#define ColorX_F 0x796ea8


#import "LookLineChatViewController.h"
#import "Masonry/Masonry.h"
#import "SystemPublic.h"
#import "SetValueFormatter.h"
#import "DateValueFormatter.h"
#import "Blue4Manager.h"
#import "HZLBlueData.h"

#define HexColor(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height

#define co1  HexColor(ColorX_Att)
#define co2  HexColor(ColorX_Med)
#define fillCo1  [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
#define fillCo2 UIColor.redColor

@interface LookLineChatViewController ()
{
    UIView *eSenseUSDXView;//eSense走势图视图

}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *goBackBtn;

@property (weak, nonatomic) IBOutlet UILabel *confiLabl;

@property (nonatomic, strong) NSMutableArray *lineCVArr;
@property (nonatomic, copy)   NSArray *deviceTextArr;
@property (nonatomic, copy)   NSArray *desArr;
@property (nonatomic, strong) NSMutableArray *desVArr;
@property (nonatomic, strong) NSMutableArray *signalVArr;

@property (nonatomic, strong) NSMutableArray *medArr_A;
@property (nonatomic, strong) NSMutableArray *medArr_B;
@property (nonatomic, strong) NSMutableArray *medArr_C;
@property (nonatomic, strong) NSMutableArray *medArr_D;
@property (nonatomic, strong) NSMutableArray *medArr_E;
@property (nonatomic, strong) NSMutableArray *medArr_F;


@property (nonatomic, strong) NSMutableArray *attArr_A;
@property (nonatomic, strong) NSMutableArray *attArr_B;
@property (nonatomic, strong) NSMutableArray *attArr_C;
@property (nonatomic, strong) NSMutableArray *attArr_D;
@property (nonatomic, strong) NSMutableArray *attArr_E;
@property (nonatomic, strong) NSMutableArray *attArr_F;

//
//@property (nonatomic, strong) NSMutableArray  *medArr_AA;
//@property (nonatomic, strong) NSMutableArray  *attArr_AA;
//@property (nonatomic, strong) NSMutableArray  *tempMedArr_AA;
//@property (nonatomic, strong) NSMutableArray  *tempAttArr_AA;

@property (nonatomic, assign) int  med_A;
@property (nonatomic, assign) int  med_B;
@property (nonatomic, assign) int  med_C;
@property (nonatomic, assign) int  med_D;
@property (nonatomic, assign) int  med_E;
@property (nonatomic, assign) int  med_F;
@property (nonatomic, assign) int  med_G;

@property (nonatomic, assign) int  med_A_count;
@property (nonatomic, assign) int  med_B_count;
@property (nonatomic, assign) int  med_C_count;
@property (nonatomic, assign) int  med_D_count;
@property (nonatomic, assign) int  med_E_count;
@property (nonatomic, assign) int  med_F_count;


@property (nonatomic, assign) int  att_A;
@property (nonatomic, assign) int  att_B;
@property (nonatomic, assign) int  att_C;
@property (nonatomic, assign) int  att_D;
@property (nonatomic, assign) int  att_E;
@property (nonatomic, assign) int  att_F;

@property (nonatomic, assign) int  att_A_count;
@property (nonatomic, assign) int  att_B_count;
@property (nonatomic, assign) int  att_C_count;
@property (nonatomic, assign) int  att_D_count;
@property (nonatomic, assign) int  att_E_count;
@property (nonatomic, assign) int  att_F_count;


@property (nonatomic, strong) NSTimer *timerA;
@property (nonatomic, strong) NSTimer *timerB;
@property (nonatomic, strong) NSTimer *timerC;
@property (nonatomic, strong) NSTimer *timerD;
@property (nonatomic, strong) NSTimer *timerE;
@property (nonatomic, strong) NSTimer *timerF;


@property (nonatomic, strong) NSTimer *timerAA;
@property (nonatomic, strong) NSTimer *timerBB;

@end

@implementation LookLineChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _deviceTextArr = @[@"设备A",@"设备B",@"设备C",@"设备D",@"设备E",@"设备F"];
    _desArr = @[@"专注力平均值趋势图（10秒）",@"放松力平均值趋势图（10秒）",@"设备A脑波趋势图",@"设备B脑波趋势图",@"设备C脑波趋势图",@"设备D脑波趋势图",@"设备E脑波趋势图",@"设备F脑波趋势图"];
    
    _medArr_A =  [NSMutableArray array];
    _medArr_B =  [NSMutableArray array];
    _medArr_C =  [NSMutableArray array];
    _medArr_D =  [NSMutableArray array];
    _medArr_E =  [NSMutableArray array];
    _medArr_F =  [NSMutableArray array];

    
    _attArr_A =  [NSMutableArray array];
    _attArr_B =  [NSMutableArray array];
    _attArr_C =  [NSMutableArray array];
    _attArr_D =  [NSMutableArray array];
    _attArr_E =  [NSMutableArray array];
    _attArr_F =  [NSMutableArray array];
 
    
    [self createESenseUSDXView];
    [self setChatView];
  
    [self blueSetUp];
    
    _timerA = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAGo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerA forMode:NSDefaultRunLoopMode];
    
    _timerB = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerBGo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerB forMode:NSDefaultRunLoopMode];
    
    _timerC = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerCGo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerC forMode:NSDefaultRunLoopMode];
    
    _timerD = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerDGo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerD forMode:NSDefaultRunLoopMode];
    
    _timerE = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerEGo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerE forMode:NSDefaultRunLoopMode];
    
    _timerF = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFGo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerF forMode:NSDefaultRunLoopMode];
    

    _timerAA = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(timerAAGo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerAA forMode:NSDefaultRunLoopMode];
    
    _timerBB = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(timerBBGo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerBB forMode:NSDefaultRunLoopMode];
    
    
}

-(void)blueSetUp{
    
    NSLog(@"====%f",self.goBackBtn.center.y);
   
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
     __weak LookLineChatViewController *weakSelf = self;
     [Blue4Manager shareInstance].blueConBlock = ^( NSString *markKey) {
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
         
     };
     
     //蓝牙断开回调
     [Blue4Manager shareInstance].blueDisBlock =   ^(NSString *markKey){
         int index = 0;
         if ([markKey isEqualToString:@"1"]) {
             //判断连接的设备
            NSLog(@"A设备 蓝牙4.0 断开");
            index = 0;
            weakSelf.med_A = 0;
            weakSelf.med_A = 0;
         }
         else if ([markKey isEqualToString:@"2"]){
             //判断连接的设备
             NSLog(@"B设备 蓝牙4.0 断开");
             index = 1;
             weakSelf.med_B = 0;
             weakSelf.med_B = 0;
         }
         else if ([markKey isEqualToString:@"3"]){
             //判断连接的设备
             NSLog(@"C设备 蓝牙4.0 断开");
             index = 2;
             weakSelf.med_C = 0;
             weakSelf.med_C = 0;
         }
         else if ([markKey isEqualToString:@"4"]){
             //判断连接的设备
             NSLog(@"D设备 蓝牙4.0 断开");
             index = 3;
             weakSelf.med_D = 0;
             weakSelf.med_D = 0;
         }
         else if ([markKey isEqualToString:@"5"]){
             //判断连接的设备
             NSLog(@"E设备 蓝牙4.0 断开");
             index = 4;
             weakSelf.med_E = 0;
             weakSelf.med_E = 0;
         }
         else if ([markKey isEqualToString:@"6"]){
             //判断连接的设备
             NSLog(@"F设备 蓝牙4.0 断开");
             index = 5;
             weakSelf.med_F = 0;
             weakSelf.med_F = 0;
         }
   
         
         UIImageView *iv = weakSelf.signalVArr[index];
         iv.image = [UIImage imageNamed:@"noSignal"];
     };
     
     
     [Blue4Manager shareInstance].hzlblueDataBlock_A = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro || conBT == BlueType_Jii || conBT == BlueType_Lite) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.att_A = blueData.attention;
                 weakSelf.med_A = blueData.meditation;
                 UIImageView *iv = weakSelf.signalVArr[0];
                 if (blueData.signal == 0) {
                     iv.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                      iv.image = [UIImage imageNamed:@"signal3"];
                 }
             }
         }
         
         if (isFalseCon) {
             NSLog(@"A设备假连接");
         }
     };
     
     [Blue4Manager shareInstance].hzlblueDataBlock_B = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro || conBT == BlueType_Jii || conBT == BlueType_Lite) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.att_B = blueData.attention;
                 weakSelf.med_B = blueData.meditation;
                 UIImageView *iv = weakSelf.signalVArr[1];
                 if (blueData.signal == 0) {
                     iv.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                      iv.image = [UIImage imageNamed:@"signal3"];
                 }
             }
         }
         
         if (isFalseCon) {
             NSLog(@"B设备假连接");
         }
     };
     
     [Blue4Manager shareInstance].hzlblueDataBlock_C = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro || conBT == BlueType_Jii || conBT == BlueType_Lite) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.att_C = blueData.attention;
                 weakSelf.med_C = blueData.meditation;
                 UIImageView *iv = weakSelf.signalVArr[2];
                 if (blueData.signal == 0) {
                     iv.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                      iv.image = [UIImage imageNamed:@"signal3"];
                 }
             }
          }
         
         if (isFalseCon) {
             NSLog(@"C设备假连接");
         }
     };
     
     
     [Blue4Manager shareInstance].hzlblueDataBlock_D = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro || conBT == BlueType_Jii || conBT == BlueType_Lite) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.att_D = blueData.attention;
                 weakSelf.med_D = blueData.meditation;
                 UIImageView *iv = weakSelf.signalVArr[3];
                 if (blueData.signal == 0) {
                     iv.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                      iv.image = [UIImage imageNamed:@"signal3"];
                 }
             }
          }
         
         if (isFalseCon) {
             NSLog(@"D设备假连接");
         }
     };
     
     [Blue4Manager shareInstance].hzlblueDataBlock_E = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro || conBT == BlueType_Jii || conBT == BlueType_Lite) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.att_E = blueData.attention;
                 weakSelf.med_E = blueData.meditation;
                 UIImageView *iv = weakSelf.signalVArr[4];
                 if (blueData.signal == 0) {
                     iv.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                      iv.image = [UIImage imageNamed:@"signal3"];
                 }
             }
          }
         
         if (isFalseCon) {
             NSLog(@"E设备假连接");
         }
     };
     
     [Blue4Manager shareInstance].hzlblueDataBlock_F = ^(HZLBlueData *blueData, BlueType conBT, BOOL isFalseCon) {
         if (conBT == BlueType_Pro || conBT == BlueType_Jii || conBT == BlueType_Lite) {
             if (blueData.bleDataType == BLEMIND) {
                 weakSelf.att_F = blueData.attention;
                 weakSelf.med_F = blueData.meditation;
                 UIImageView *iv = weakSelf.signalVArr[5];
                 if (blueData.signal == 0) {
                     iv.image = [UIImage imageNamed:@"signal_zhengChang"];
                 }else{
                      iv.image = [UIImage imageNamed:@"signal3"];
                 }
             }
          }
         
         if (isFalseCon) {
             NSLog(@"F设备假连接");
         }
     };
     
  
    [[Blue4Manager shareInstance] connectBlue4];
}

-(void)timerAAGo
{
     int A =  (int)(_att_A_count/10);
     int B =  (int)(_att_B_count/10);
     int C =  (int)(_att_C_count/10);
     int D =  (int)(_att_D_count/10);
     int E =  (int)(_att_E_count/10);
     int F =  (int)(_att_F_count/10);
    
    NSArray *AA = @[@(A),@(B),@(C),@(D),@(E),@(F)];
    _att_A_count = 0;
    _att_B_count = 0;
    _att_C_count = 0;
    _att_D_count = 0;
    _att_E_count = 0;
    _att_F_count = 0;

    
//    NSLog(@"__count: %d",_att_A_count);
    
    BarChartView *barChartView = (BarChartView *)self.lineCVArr[0];
    barChartView.data = [self getBarChartDataSet:(BarChartView *)barChartView baseDic:@{@"专注度":AA} colorDic:@{@"专注度":co1} fillColorDic:@{@"专注度":fillCo1}];
    barChartView.leftAxis.axisMaximum = 100;
    barChartView.leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
}


-(void)timerBBGo
{
    int A =  (int)(_med_A_count/10);
    int B =  (int)(_med_B_count/10);
    int C =  (int)(_med_C_count/10);
    int D =  (int)(_med_D_count/10);
    int E =  (int)(_med_E_count/10);
    int F =  (int)(_med_F_count/10);;
    
    NSArray *BB = @[@(A),@(B),@(C),@(D),@(E),@(F)];
    
    _med_A_count = 0;
    _med_B_count = 0;
    _med_C_count = 0;
    _med_D_count = 0;
    _med_E_count = 0;
    _med_F_count = 0;

    
    BarChartView *barChartView = (BarChartView *)self.lineCVArr[1];
    barChartView.data = [self getBarChartDataSet:(BarChartView *)barChartView baseDic:@{@"专注度":BB} colorDic:@{@"专注度":co1} fillColorDic:@{@"专注度":fillCo1}];
    barChartView.leftAxis.axisMaximum = 100;
    barChartView.leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
    
 
}

-(void)timerAGo
{
    [_attArr_A addObject:@(_att_A)];
    [_medArr_A addObject:@(_med_A)];
    LineChartView *lineChartView = (LineChartView *)self.lineCVArr[2];
    lineChartView.data = [self getLineChartDataSet:(LineChartView *)lineChartView baseDic:@{@"专注度":_attArr_A,@"放松度":_medArr_A} colorDic:@{@"专注度":co1,@"放松度":co2} fillColorDic:@{@"专注度":fillCo1,@"放松度":fillCo2}];
    _att_A_count = _att_A_count + _att_A;
    _med_A_count = _med_A_count + _med_A;
    
//    NSLog(@"_count: %d",_att_A_count);
   
    
//    channel1_ChartView.data = [self setLinData:channel1_ChartView :channel1_Arr :YES];
//    channel2_ChartView.data = [self setLinData:channel2_ChartView :channel2_Arr :YES];
//    if(channel1_Arr.count > 256*6)
//    {
//        [channel1_Arr removeObjectsInRange:NSMakeRange(0, 256*4)];
//    }
//    //   NSLog(@"======%ld",channel1_Arr.count);
//
//    if(_attArr_A.count > 10*6)
//    {
//        [_attArr_A removeObjectsInRange:NSMakeRange(0,10)];
//    }
    
}

-(void)timerBGo
{
    [_attArr_B addObject:@(_att_B)];
    [_medArr_B addObject:@(_med_B)];
    LineChartView *lineChartView = (LineChartView *)self.lineCVArr[3];
    lineChartView.data = [self getLineChartDataSet:(LineChartView *)lineChartView baseDic:@{@"专注度":_attArr_B,@"放松度":_medArr_B} colorDic:@{@"专注度":co1,@"放松度":co2} fillColorDic:@{@"专注度":fillCo1,@"放松度":fillCo2}];
    
    _att_B_count = _att_B_count + _att_B;
    _med_B_count = _med_B_count + _med_B;
    
//    if(_attArr_B.count > 10*6)
//    {
//        [_attArr_B removeObjectsInRange:NSMakeRange(0,10)];
//    }
    
}
-(void)timerCGo
{
    [_attArr_C addObject:@(_att_C)];
    [_medArr_C addObject:@(_med_C)];
    LineChartView *lineChartView = (LineChartView *)self.lineCVArr[4];
    lineChartView.data = [self getLineChartDataSet:(LineChartView *)lineChartView baseDic:@{@"专注度":_attArr_C,@"放松度":_medArr_C} colorDic:@{@"专注度":co1,@"放松度":co2} fillColorDic:@{@"专注度":fillCo1,@"放松度":fillCo2}];
    
    _att_C_count = _att_C_count + _att_C;
    _med_C_count = _med_C_count + _med_C;
    
//    if(_attArr_C.count > 10*6)
//    {
//        [_attArr_C removeObjectsInRange:NSMakeRange(0,10)];
//    }
}
-(void)timerDGo
{
    [_attArr_D addObject:@(_att_D)];
    [_medArr_D addObject:@(_med_D)];
    LineChartView *lineChartView = (LineChartView *)self.lineCVArr[5];
    lineChartView.data = [self getLineChartDataSet:(LineChartView *)lineChartView baseDic:@{@"专注度":_attArr_D,@"放松度":_medArr_D} colorDic:@{@"专注度":co1,@"放松度":co2} fillColorDic:@{@"专注度":fillCo1,@"放松度":fillCo2}];
    
    _att_D_count = _att_D_count + _att_D;
    _med_D_count = _med_D_count + _med_D;
    
    
//    if(_attArr_D.count > 10*6)
//    {
//        [_attArr_D removeObjectsInRange:NSMakeRange(0,10)];
//    }
}
-(void)timerEGo
{
    [_attArr_E addObject:@(_att_E)];
    [_medArr_E addObject:@(_med_E)];
    LineChartView *lineChartView = (LineChartView *)self.lineCVArr[6];
    lineChartView.data = [self getLineChartDataSet:(LineChartView *)lineChartView baseDic:@{@"专注度":_attArr_E,@"放松度":_medArr_E} colorDic:@{@"专注度":co1,@"放松度":co2} fillColorDic:@{@"专注度":fillCo1,@"放松度":fillCo2}];
    
    _att_E_count = _att_E_count + _att_E;
    _med_E_count = _med_E_count + _med_E;
    
//    if(_attArr_E.count > 10*6)
//    {
//        [_attArr_E removeObjectsInRange:NSMakeRange(0,10)];
//    }
}
-(void)timerFGo
{
    [_attArr_F addObject:@(_att_F)];
    [_medArr_F addObject:@(_med_F)];
    LineChartView *lineChartView = (LineChartView *)self.lineCVArr[7];
    lineChartView.data = [self getLineChartDataSet:(LineChartView *)lineChartView baseDic:@{@"专注度":_attArr_F,@"放松度":_medArr_F} colorDic:@{@"专注度":co1,@"放松度":co2} fillColorDic:@{@"专注度":fillCo1,@"放松度":fillCo2}];
    
    _att_F_count = _att_F_count + _att_F;
    _med_F_count = _med_F_count + _med_F;
    
//    if(_attArr_F.count > 10*6)
//    {
//        [_attArr_F removeObjectsInRange:NSMakeRange(0,10)];
//    }
}






- (void)setChatView
{
    
    for (int i = 0 ; i <  self.lineCVArr.count;i++) {
   
        UIView *chartView  =  self.lineCVArr[i];
        
        if (i ==0) {
            [self setBarChartViewAttribute:(BarChartView *)chartView];
        }
        else if (i == 1){
            [self setBarChartViewAttribute:(BarChartView *)chartView];
        }
        else{
            LineChartView *lineChartView = (LineChartView *)chartView;
            lineChartView.leftAxis.axisMaximum = 100;
            lineChartView.leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
            [self setLineChartViewAttribute:(LineChartView *)chartView];
        }
       
        
    }
 


}

#pragma mark eSense走势图
- (void)createESenseUSDXView{
    
    // 设置scrollView的子视图，即过渡视图contentSize，并设置其约束
    eSenseUSDXView = [UIView new];
    eSenseUSDXView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:eSenseUSDXView];
    [eSenseUSDXView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.scrollView).with.insets(UIEdgeInsetsZero);
        make.width.equalTo(self.scrollView);
    }];

    //    eSenseUSDXView.backgroundColor = [UIColor redColor];
    
    //过渡视图添加子视图
    self.lineCVArr = [NSMutableArray arrayWithCapacity:0];
    self.desVArr = [NSMutableArray arrayWithCapacity:0];
    self.signalVArr = [NSMutableArray arrayWithCapacity:0];
    UIView *lastView =nil;
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
//        label.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:label];
        [self.desVArr  addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->eSenseUSDXView).offset(30);
            make.right.equalTo(self->eSenseUSDXView).offset(-30);
            
            make.height.mas_equalTo(30);
            if (lastView)
            {
                make.top.mas_equalTo(lastView.mas_bottom).offset(20);
            }
            else
            {
                make.top.mas_equalTo(0);
            }
        }];
        lastView = label;
        UIView *barChartView = [[BarChartView alloc] init];
        [self.scrollView addSubview:barChartView];
        barChartView.backgroundColor = [UIColor clearColor];
//        if (index == 0) {
//            lineChartView.backgroundColor = [UIColor redColor];
//        }
//        else if (index == 1)
//        {
//            lineChartView.backgroundColor = [UIColor systemBlueColor];
//        }
        //添加到父视图，并设置过渡视图中子视图的约束
        [barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->eSenseUSDXView).offset(30);
            make.right.equalTo(self->eSenseUSDXView).offset(-30);
            int hei = (int)(self.scrollView.frame.size.width - 60)/3*2;
            make.height.mas_equalTo(hei);
            if (lastView)
            {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            else
            {
                make.top.mas_equalTo(0);
            }
        }];
        lastView = barChartView;
        [self.lineCVArr addObject:barChartView];
    }
    
    
    for (NSInteger index =2; index <8; index++)
    {
        UILabel *label = [[UILabel alloc] init];
        [self.scrollView addSubview:label];
        [self.desVArr  addObject:label];
        label.textAlignment = NSTextAlignmentCenter;
//        label.backgroundColor = [UIColor redColor];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->eSenseUSDXView).offset(30);
            make.right.equalTo(self->eSenseUSDXView).offset(-30);
            
            make.height.mas_equalTo(30);
            if (lastView)
            {
                make.top.mas_equalTo(lastView.mas_bottom).offset(20);;
            }
            else
            {
                make.top.mas_equalTo(0);
            }
        }];
        lastView = label;
        
        UIView *ivBG = [[UIView alloc] init];
        ivBG.backgroundColor = [UIColor grayColor];
        [label addSubview:ivBG];
        [ivBG mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(label).offset(30);
              make.centerY.equalTo(label);
              make.width.equalTo(@(60));
            make.height.equalTo(label);
        }];
        
        UIImageView *ivBack = [[UIImageView alloc] init];
        ivBack.image = [UIImage imageNamed:@"signalOutlet"];
        [ivBG addSubview:ivBack];
        [ivBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ivBG);
            make.centerY.equalTo(ivBG);
        }];
        
        UIImageView *iv = [[UIImageView alloc] init];
        iv.image = [UIImage imageNamed:@"noSignal"];
        [ivBG addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ivBG);
            make.centerY.equalTo(ivBG);
        }];
        [self.signalVArr addObject:iv];
        
        UIView *lineChartView = [[LineChartView alloc] init];
        [self.scrollView addSubview:lineChartView];
        lineChartView.backgroundColor = [UIColor clearColor];
        
//        lineChartView.backgroundColor = [UIColor orangeColor];

        //添加到父视图，并设置过渡视图中子视图的约束
        [lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->eSenseUSDXView).offset(30);
            make.right.equalTo(self->eSenseUSDXView).offset(-30);
            int hei = (int)(self.scrollView.frame.size.width - 60)/3*2;
            make.height.mas_equalTo(hei);
            if (lastView)
            {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            else
            {
                make.top.mas_equalTo(0);
            }
        }];
        lastView = lineChartView;
        [self.lineCVArr addObject:lineChartView];
    }
    
    // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）
    [eSenseUSDXView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    
    
    for (int i = 0 ; i <  self.desVArr.count;i++) {
        UILabel *label = (UILabel *)self.desVArr[i];
        label.text =  _desArr[i];
        label.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
        
    }
    
}

-(void)setBarChartViewAttribute:(BarChartView *)barChartView{
    barChartView.drawBarShadowEnabled = NO;
    barChartView.drawValueAboveBarEnabled = YES;
    
    barChartView.maxVisibleCount = 60;
//    barChartView.descriptionText = @"";
    barChartView.chartDescription.text = @"";
    barChartView.highlightPerTapEnabled = NO;
    barChartView.scaleYEnabled = NO;//取消Y轴缩放
    barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    barChartView.dragEnabled = YES;//启用拖拽图标
    barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    
    
    ChartXAxis *xAxis = barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.granularity = 1.0; // only intervals of 1 day
//    xAxis.labelCount = 7;
//
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    //   xAxis.spaceBetweenLabels = 4;//设置label间隔
    xAxis.labelTextColor = UIColor.blackColor;//HexColor(0x8b939c);//label文字颜色 2---
    xAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    xAxis.axisLineColor = [UIColor blackColor];
    
//    xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:barChartView];
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.minimumFractionDigits = 0;
    leftAxisFormatter.maximumFractionDigits = 1;
//    leftAxisFormatter.negativeSuffix = @" $";
//    leftAxisFormatter.positiveSuffix = @" $";
    
    ChartYAxis *leftAxis = barChartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 5;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.axisLineColor = [UIColor blackColor];
    
    barChartView.rightAxis.enabled = NO;//不绘制右边轴
//    ChartYAxis *rightAxis = barChartView.rightAxis;
//    rightAxis.enabled = YES;
//    rightAxis.drawGridLinesEnabled = NO;
//    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
//    rightAxis.labelCount = 8;
//    rightAxis.valueFormatter = leftAxis.valueFormatter;
//    rightAxis.spaceTop = 0.15;
//    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = barChartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 5;
    l.font = [UIFont systemFontOfSize:12.f];
    l.xEntrySpace = 9.0;
}
- (void)setLineChartViewAttribute:(LineChartView *)lineChartView
{
    //    self.lineChartView.noDataText = BALocalizedString(@"temporarilyNoData");
    
    lineChartView.scaleYEnabled = NO;//取消Y轴缩放
    lineChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    lineChartView.dragEnabled = YES;//启用拖拽图标
    lineChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    lineChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    
    ChartXAxis *xAxis = lineChartView.xAxis;
    xAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    //   xAxis.spaceBetweenLabels = 4;//设置label间隔
    xAxis.labelTextColor = UIColor.blackColor;//HexColor(0x8b939c);//label文字颜色 2---
    xAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    xAxis.axisLineColor = [UIColor blackColor];
    
    lineChartView.rightAxis.enabled = NO;//不绘制右边轴
    ChartYAxis *leftAxis = lineChartView.leftAxis;//获取左边Y轴
    
    leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
    //    leftAxis.showOnlyMinMaxEnabled = NO;//是否只显示最大值和最小值
    leftAxis.axisMinimum = 0;//设置Y轴的最小值
    //    leftAxis.startAtZeroEnabled = 0;//从0开始绘制
    //    leftAxis.axisMaxValue = 360;//设置Y轴的最大值
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//Y轴线宽
    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    //    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];//自定义格式
    //    leftAxis.valueFormatter.positiveSuffix = @" $";//数字后缀单位
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = UIColor.blackColor;//HexColor(0x8b939c);//文字颜色  1---
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    
    //    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    //    leftAxis.gridColor = [UIColor whiteColor];//网格线颜色
    leftAxis.gridColor = [UIColor clearColor];
    leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
    
    //    [self.lineChartView setDescriptionText:@"折线图"];//折线图描述
//    lineChartView.descriptionText = @"";
//    [lineChartView setDescriptionTextColor:[UIColor darkGrayColor]];
    lineChartView.chartDescription.text = @"";
    lineChartView.legend.form = ChartLegendFormCircle;//图例的样式
    lineChartView.legend.font = [UIFont systemFontOfSize:9];
    lineChartView.legend.formSize = 5;//图例中线条的长度
//    lineChartView.legend.position = ChartLegendPositionBelowChartCenter;
    
    lineChartView.legend.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    lineChartView.legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    
    lineChartView.legend.textColor = UIColor.blackColor;//图例文字颜色
    lineChartView.legend.font = [UIFont systemFontOfSize:12.f];
    [lineChartView animateWithXAxisDuration:2.0f easingOption:ChartEasingOptionEaseOutExpo];
    
}

//
-(BarChartData *)getBarChartDataSet:(BarChartView *)barChartView baseDic:(NSDictionary *)baseDic colorDic:(NSDictionary *)colorDic fillColorDic:(NSDictionary*)fillColorDic
{
    NSArray *keyArr = [baseDic allKeys];
    NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:3];
    for (id key in keyArr) {
        [valueArr addObject:baseDic[key]];
    }
    
    NSArray *colorKeyArr = [colorDic allKeys];
    NSMutableArray *colorValueArr = [NSMutableArray arrayWithCapacity:3];
    for (id key in colorKeyArr) {
        [colorValueArr addObject:colorDic[key]];
    }
    
    NSArray *fillColorKeyArr = [fillColorDic allKeys];
    NSMutableArray *fillColorValueArr = [NSMutableArray arrayWithCapacity:3];
    for (id key in fillColorKeyArr) {
        [fillColorValueArr addObject:fillColorDic[key]];
    }
    
    NSArray *oneArr = (NSArray *)(valueArr[0]);
    int xVals_count = (int)oneArr.count;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
       
        [xVals addObject:[NSString stringWithFormat:@"%@", _deviceTextArr[i]]];
    }
    barChartView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
    
    //对应Y轴上面需要显示的数据
    NSMutableArray* yArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < valueArr.count; i++) {
        NSArray *everyArr = (NSArray *)valueArr[i];
        NSMutableArray *yVals = [[NSMutableArray alloc] init];
        for (int i = 0; i < xVals_count; i++) {
            double b;
            b=[everyArr[i] doubleValue];
            BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:b];
            [yVals addObject:entry];
        }
        [yArray addObject:yVals];
    }
    
    if (barChartView.data.dataSetCount > 0) {
        BarChartData *data = (BarChartData *)barChartView.data;
        for (int i = 0;i < yArray.count ;i++) {
            NSArray *yVals = yArray[i];
            BarChartDataSet *set =(BarChartDataSet *)barChartView.data.dataSets[i];
//            set.drawValuesEnabled =
              set.highlightEnabled = NO;//选中拐点,是否开启高亮效果(显示十字线)
            set.values = yVals;
        }
        [barChartView.data notifyDataChanged];
        [barChartView notifyDataSetChanged];
        return data;
    }
    else
    {
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        for (int i = 0;i<yArray.count;i++) {
            BarChartDataSet *set = [[BarChartDataSet alloc] initWithValues:yArray[i] label:keyArr[i]];
            set.axisDependency = AxisDependencyLeft;
            
            [set setColors:@[HexColor(ColorX_A),HexColor(ColorX_B),HexColor(ColorX_C),HexColor(ColorX_D),HexColor(ColorX_E),HexColor(ColorX_F)]];
            [dataSets addObject:set];
        }
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:[UIColor blackColor]]; ///
        [data setValueFont:[UIFont systemFontOfSize:10.f]];
        data.barWidth = 0.9f;
        return  data;
    }
}


//
-(LineChartData *)getLineChartDataSet:(LineChartView *)lineChartView baseDic:(NSDictionary *)baseDic colorDic:(NSDictionary *)colorDic fillColorDic:(NSDictionary*)fillColorDic
{
    NSArray *keyArr = [baseDic allKeys];
    NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:3];
    for (id key in keyArr) {
        [valueArr addObject:baseDic[key]];
    }
    
    NSArray *colorKeyArr = [colorDic allKeys];
    NSMutableArray *colorValueArr = [NSMutableArray arrayWithCapacity:3];
    for (id key in colorKeyArr) {
        [colorValueArr addObject:colorDic[key]];
    }
    
    NSArray *fillColorKeyArr = [fillColorDic allKeys];
    NSMutableArray *fillColorValueArr = [NSMutableArray arrayWithCapacity:3];
    for (id key in fillColorKeyArr) {
        [fillColorValueArr addObject:fillColorDic[key]];
    }
    
    NSArray *oneArr = (NSArray *)(valueArr[0]);
    int xVals_count = (int)oneArr.count;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        NSString *string = [[SystemPublic publicManage] timeStamp:[NSString stringWithFormat:@"%d",i] dateFormat:@"mm:ss"];
        [xVals addObject:[NSString stringWithFormat:@"%@", string]];
    }
    lineChartView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
    //对应Y轴上面需要显示的数据
    NSMutableArray* yArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < valueArr.count; i++) {
        NSArray *everyArr = (NSArray *)valueArr[i];
        NSMutableArray *yVals = [[NSMutableArray alloc] init];
        for (int i = 0; i < xVals_count; i++) {
            double b;
            b=[everyArr[i] doubleValue];
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:b];
            [yVals addObject:entry];
        }
        [yArray addObject:yVals];
    }
    
    if (lineChartView.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)lineChartView.data;
        for (int i = 0;i < yArray.count ;i++) {
            NSArray *yVals = yArray[i];
            LineChartDataSet *set =(LineChartDataSet *)lineChartView.data.dataSets[i];
//            set.drawValuesEnabled =
            set.values = yVals;
            set.valueFormatter = [[SetValueFormatter alloc] initWithArr:yVals];
        }
        [lineChartView.data notifyDataChanged];
        [lineChartView notifyDataSetChanged];
        
        [lineChartView setVisibleXRangeMaximum:60];
        if  (lineChartView.data.entryCount>=60) {
            //print("\n\n count : \(count) \n\n")
            [lineChartView moveViewToX:(lineChartView.data.entryCount-10)];
        }
        
        return data;
    }
    else
    {
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        for (int i = 0;i<yArray.count;i++) {
            NSArray *yVals = yArray[i];
            LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:yVals label:keyArr[i]];
            set.axisDependency = AxisDependencyLeft;

            [set setColor:colorValueArr[i]];
            [set setCircleColor:colorValueArr[i]];
            set.lineWidth = 2.0;
            set.circleRadius = 3.0;
            set.fillAlpha = 65/255.0;
            set.highlightEnabled = NO;//选中拐点,是否开启高亮效果(显示十字线)
//            set.fillColor = UIColor.redColor;
            set.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
            set.drawCircleHoleEnabled = NO;
            set.valueFormatter = [[SetValueFormatter alloc] initWithArr:yVals];
            [dataSets addObject:set];
        }
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:[UIColor blackColor]]; ///
        [data setValueFont:[UIFont systemFontOfSize:10.f]];
        return  data;
    }
}



- (IBAction)goback:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self clearTimer];
    [[Blue4Manager shareInstance] disConnectBlue4];
}

-(void)clearTimer{
    if (_timerA) {
        [_timerA invalidate];
        _timerA = nil;
    }
    if (_timerB) {
        [_timerB invalidate];
        _timerB = nil;
    }
    if (_timerC) {
        [_timerC invalidate];
        _timerC = nil;
    }
    if (_timerD) {
        [_timerD invalidate];
        _timerD = nil;
    }
    if (_timerE) {
        [_timerE invalidate];
        _timerE = nil;
    }
    if (_timerF) {
        [_timerF invalidate];
        _timerF = nil;
    }
    
    if (_timerAA) {
        [_timerAA invalidate];
        _timerAA = nil;
    }
    if (_timerBB) {
        [_timerBB invalidate];
        _timerBB = nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
