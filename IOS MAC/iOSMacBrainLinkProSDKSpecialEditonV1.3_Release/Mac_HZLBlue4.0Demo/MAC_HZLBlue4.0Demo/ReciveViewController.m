//
//  ReciveViewController.m
//  MAC_HZLBlue4.0Demo
//
//  Created by 方亮 on 2018/6/24.
//  Copyright © 2018年 macrotellect. All rights reserved.
//

#import "ReciveViewController.h"
#import "Blue4Manager.h"

typedef enum : NSUInteger {
    SIGNAL_STATE_NOSIGNAL = 0,//无信号
    SIGNAL_STATE_WEAK,//信号弱
    SIGNAL_STATE_GENERAL,//信号一般
    SIGNAL_STATE_GOOD,//信号很好
    SIGNAL_STATE_VERYGOOD,//信号非常好
    
} SignalState;


@interface ReciveViewController ()
{
    //信号指示
    NSView *signalview;
    NSImageView *signalInstructions;
    dispatch_source_t timer;
    //信号状态
    SignalState signalState;
    int  baseCount;
    
    BOOL    isaccetable4;
}


@property (weak) IBOutlet NSView *signalview;
@property (weak) IBOutlet NSTextField *conSumTf;
@property (weak) IBOutlet NSTextField *electricityLabel;
@property (weak) IBOutlet NSTextField *attentionlabel;
@property (weak) IBOutlet NSTextField *medlabel;
@property (weak) IBOutlet NSTextField *favrouteRateLabel;
@property (weak) IBOutlet NSTextField *circleRateLabel;
@property (weak) IBOutlet NSTextField *rawLabel;
@property (weak) IBOutlet NSTextField *otherLabel;

//@property (weak) IBOutlet NSButton *isAutoConBleSwi;
//@property (weak) IBOutlet NSButton *conBle;
//@property (weak) IBOutlet NSButton *makeSureBu;

@property (strong)  NSImageView    *signalImageView;
@end

@implementation ReciveViewController

#pragma 改变连接个数 大于0的整数
//- (IBAction)makeSure:(id)sender {
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.view.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
    [self.view setNeedsDisplay:YES];
 
    //蓝牙连接指示灯外框
    signalInstructions       = [NSImageView new];
    signalInstructions.image = [NSImage imageNamed:@"signalOutlet"];
    signalInstructions.frame=CGRectMake(2, 0, 44, 44);
    [_signalview addSubview:signalInstructions];
    
    //随着蓝牙连接状态变化的指图标
    _signalImageView       = [NSImageView new];
    _signalImageView.tag   = 200;
    _signalImageView.frame=CGRectMake(2, 0, 44, 44);
    _signalImageView.image = [NSImage imageNamed:@"noSignal"];
    [_signalview addSubview:_signalImageView];

    NSTextField *tips      = [NSTextField new];
    tips.font          =[NSFont systemFontOfSize:14];
    tips.stringValue          = @"请正确佩戴设备";
    tips.textColor     = [NSColor whiteColor];
    [_signalview addSubview:tips];
    
    _otherLabel.maximumNumberOfLines = 2;
    [[_otherLabel cell] setUsesSingleLineMode:NO];
    
    //蓝牙连接
    [Blue4Manager logEnable:YES];
    [[Blue4Manager shareInstance] configureBlueNames:@[@"BrainLink_Pro"] ableDeviceSum:1];
    
    
    //连接蓝牙成功回调
    __weak ReciveViewController *weakSelf = self;
    [Blue4Manager shareInstance].blueConBlock  =  ^(NSString *markKey) {
        NSLog(@"连接蓝牙成功");
    };
    
    //蓝牙断开回调
    [Blue4Manager shareInstance].blueDisBlock  =   ^(NSString *markKey){
    
        self.signalImageView.image = [NSImage imageNamed:@"noSignal"];
        
        weakSelf.electricityLabel.stringValue = @"";
        weakSelf.attentionlabel.stringValue = @"";
        weakSelf.medlabel.stringValue = @"";
        weakSelf.favrouteRateLabel.stringValue = @"";
        weakSelf.circleRateLabel.stringValue = @"";
     
        weakSelf.rawLabel.stringValue = @"";
        
        weakSelf.otherLabel.stringValue = @"";
      
        NSLog(@"蓝牙断开");
    };
    
    
    [Blue4Manager shareInstance].hzlblueDataBlock_A = ^(HZLBlueData *hzlBlueData, BlueType conBT, BOOL isFalseCon) {
        NSString *peripID = @"";
        if (hzlBlueData.bleDataType==BLEMIND) {
            
            weakSelf.attentionlabel.stringValue  =   [NSString stringWithFormat:@"%@=%d",peripID,hzlBlueData.attention];
            
            weakSelf.medlabel.stringValue  =   [NSString stringWithFormat:@"%@=%d",peripID,hzlBlueData.meditation];
            weakSelf.electricityLabel.stringValue  =   [NSString stringWithFormat:@"%@=%d",peripID, hzlBlueData.batteryCapacity];
            weakSelf.favrouteRateLabel.stringValue = [NSString stringWithFormat:@"%@=%d  ",peripID,hzlBlueData.ap];
            
            weakSelf.otherLabel.stringValue = [NSString stringWithFormat:
                                               @"%@=Delta:%d Theta:%d LowAlpha:%d HighAlpha:%d LowBeta:%d HighBeta:%d LowGamma:%d HighGamma:%d ",peripID,hzlBlueData.delta,hzlBlueData.theta,hzlBlueData.lowAlpha,hzlBlueData.highAlpha,hzlBlueData.lowBeta,hzlBlueData.highBeta,hzlBlueData.lowGamma,hzlBlueData.highGamma];
            
            //信号值为0 即佩戴了蓝牙设备
            //注：如果连接了蓝牙设备而未佩戴，信号值为200
            [self changeSignalStateWithSignal:hzlBlueData.signal];
        }
        if (hzlBlueData.bleDataType == BLEGRAVITY) {
            weakSelf.circleRateLabel.stringValue = [NSString stringWithFormat:@"%@=x:%d y:%d z:%d ",peripID,hzlBlueData.xvlaue,hzlBlueData.yvlaue,hzlBlueData.zvlaue];
        }
        if(hzlBlueData.bleDataType == BLERaw)
        {
            weakSelf.rawLabel.stringValue = [NSString stringWithFormat:@"%@=Raw:%d blinkeye:%d",peripID,hzlBlueData.raw,hzlBlueData.blinkeye];
        }
        
    };
    [[Blue4Manager shareInstance] connectBlue4];
    
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewController:self];
}

#pragma mark 改变信号指示灯
- (void)changeSignalStateWithSignal:(int)signal{
    
    if (signal < 0){
        signalState = SIGNAL_STATE_NOSIGNAL;
    }
    else if (signal == 0) {
        signalState = SIGNAL_STATE_VERYGOOD;
    }
    else if (signal > 0 && signal <= 70){
        signalState = SIGNAL_STATE_GOOD;
    }
    else if (signal > 70 && signal <= 140){
        signalState = SIGNAL_STATE_GENERAL;
    }
    else if (signal > 140){
        signalState = SIGNAL_STATE_WEAK;
    }
    switch (signalState) {
        case SIGNAL_STATE_NOSIGNAL:
            _signalImageView.image = [NSImage imageNamed:@"signal_zhengChang-1"];
            baseCount =0;
            break;
        case SIGNAL_STATE_WEAK:
            if (baseCount==0) {
                [self  updateAN ];
            }
            [self countdown3s];
            break;
        case SIGNAL_STATE_GENERAL:
            
            [self countdown3s];
            break;
        case SIGNAL_STATE_GOOD:
            
            [self countdown3s];
            break;
        case SIGNAL_STATE_VERYGOOD:
        {
            baseCount=0;
            _signalImageView.image = [NSImage imageNamed:@"signal_zhengChang"];
            
        }
            break;
        default:
            break;
    }
    
}
-(void)updateAN
{
    baseCount=3   ;
    
//    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    anima1.duration = 10.0;
//    //    anima1.delegate = self;
//    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(signalview.center.x,signalview.center.y)];
//    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(signalview.center.x -120, signalview.center.y)];
//    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(signalview.center.x -120, signalview.center.y)];
//    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(signalview.center.x,signalview.center.y)];
//    anima1.values = [NSArray arrayWithObjects:value0,value1,value3,value2, nil];
//    anima1.fillMode = kCAFillModeForwards;
//    anima1.removedOnCompletion = NO;
//    [signalview.layer addAnimation:anima1 forKey:nil];
}
- (void)countdown3s{
    if (timer == nil) {
        __block int timeout    = 3;//倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            timer                 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(self->timer);
                    self->timer = nil;
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (timeout == 3) {
                            self->_signalImageView.image = [NSImage imageNamed:@"signal1"];
                        }
                        else if (timeout == 2) {
                            self->_signalImageView.image = [NSImage imageNamed:@"signal2"];
                        }
                        else{
                            self->_signalImageView.image = [NSImage imageNamed:@"signal3"];
                        }
                        
                    });
                    timeout--;
                }
            });
            dispatch_resume(timer);
        }
    }
}


#pragma 断开蓝牙
- (void)viewWillDisappear
{
    if(isaccetable4)
    {
        [[Blue4Manager shareInstance] disConnectBlue4];
    }
    
}

@end
