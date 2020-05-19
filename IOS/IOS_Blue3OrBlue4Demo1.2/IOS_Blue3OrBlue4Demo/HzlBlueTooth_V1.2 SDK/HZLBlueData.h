//
//  HZLBlueData.h
//
//
//  Created by macro macro on 2017/3/9.
//  Copyright © 2017年 macro macro. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    BlueType_NO = 0,
    BlueType_Lite,
    BlueType_Pro,
    BlueType_Jii,
}BlueType;

typedef NS_ENUM(NSUInteger,BLEDATATAYPE)
{
    BLEMIND  =   0,          //脑波数据
    BLEGRAVITY,              //重力数据
    BLERaw,                  //Raw 眨眼数据
};

@interface HZLBlueData : NSObject

//脑波数据 4.0/3.0都有
@property   (nonatomic,assign)    int signal;//信号值
@property   (nonatomic,assign)    int attention;//专注度
@property   (nonatomic,assign)    int meditation;//放松度

@property   (nonatomic,assign)    int delta;
@property   (nonatomic,assign)    int theta;
@property   (nonatomic,assign)    int lowAlpha;
@property   (nonatomic,assign)    int highAlpha;
@property   (nonatomic,assign)    int lowBeta;
@property   (nonatomic,assign)    int highBeta;
@property   (nonatomic,assign)    int lowGamma;
@property   (nonatomic,assign)    int highGamma;

@property   (nonatomic,assign)    int raw;
@property   (nonatomic,assign)    int blinkeye;

//4.0才有
@property   (nonatomic,assign)    int ap;  // 喜好度
@property   (nonatomic,assign)    int batteryCapacity;//电池电量百分比

@property   (nonatomic,assign)    int hardwareVersion;//硬件版本
@property   (nonatomic,assign)    int grind;//硬件版本

@property   (nonatomic,assign)    int xvlaue;//重力传感器X轴值  前后摆动  俯仰角
@property   (nonatomic,assign)    int yvlaue;//重力传感器Y轴值  左右摆动  偏航角
@property   (nonatomic,assign)    int zvlaue;//重力传感器Z轴值  翅膀摆动  滚转角

@property   (nonatomic,assign)     BLEDATATAYPE  bleDataType;//蓝牙数据类型

@property   (nonatomic,assign)    BlueType  blueType;//蓝牙设备类型 4.0 3.0

@end
