//
//  Blue3OrBlue4Manager.h
//  NewneuroMonitor
//
//  Created by 方亮 on 2018/7/25.
//  Copyright © 2018年 Macrotellect-iOSDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZLBlueData.h"

typedef void(^Blue3OrBlue4DataBlock)(HZLBlueData *blueData,BlueType conBT);
typedef void(^Blue3OrBlue4Connect)(BlueType conBT);
typedef void(^Blue3OrBlue4DisConnect)(BlueType disBT);

@interface Blue3OrBlue4Manager : NSObject

//蓝牙连接成功的回调
@property (nonatomic,copy) Blue3OrBlue4Connect blueConBlock;
//蓝牙断开回调
@property (nonatomic,copy) Blue3OrBlue4DisConnect blueDisBlock;

//设备的数据回调
@property (nonatomic,copy)Blue3OrBlue4DataBlock  hzlblueDataBlock;
//设备连接状态
@property (nonatomic,assign)BOOL  connected4;
@property (nonatomic,assign)BOOL  connected3;
/*! @brief 是否打印log  默认不打印
 */
+ (void)logEnable:(BOOL)enable;

/*! @brief 初始化(单例)
 */
+ (instancetype)shareInstance;

/*! @brief 连接配置
    blue3MFiOrBlue4Names: 可以连接的蓝牙4.0设备名称 蓝牙3.0设备MFi
    只能连接一个
 */
-(void)configureBlue3MFiOrBlue4Names:(NSArray *)blue3MFiOrBlue4Names;

/*! @brief 连接蓝牙设备
 */
-(void)connectBlue3OrBlue4;

/*! @brief 断开蓝牙设备
 */
-(void)disConnectBlue3OrBlue4;

@end
