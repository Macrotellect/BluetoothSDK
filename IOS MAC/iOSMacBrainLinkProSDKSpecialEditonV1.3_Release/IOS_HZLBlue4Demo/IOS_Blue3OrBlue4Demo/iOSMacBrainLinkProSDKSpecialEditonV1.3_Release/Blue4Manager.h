//
//  Blue4Manager.h
//  NewneuroMonitor
//
//  Created by 方亮 on 2018/7/25.
//  Copyright © 2018年 Macrotellect-iOSDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZLBlueData.h"

typedef void(^Blue4DataBlock)(HZLBlueData *blueData,BlueType conBT,BOOL isFalseCon);
typedef void(^Blue4Connect)(NSString *markKey);
typedef void(^Blue4DisConnect)(NSString *markKey);

@interface Blue4Manager : NSObject

//蓝牙连接成功的回调
@property (nonatomic,copy) Blue4Connect blueConBlock;
//蓝牙断开回调
@property (nonatomic,copy) Blue4DisConnect blueDisBlock;

// 蓝牙设备按照连接顺序依次为 A B C D E F
/*使用如上方式，比如有6个数据回调( hzlblueDataBlock_A,hzlblueDataBlock_B .....)，是为了保证数据的独立性，各个设备间的数据可以同时接受，互不影响
蓝牙4.0设备最多可以连接6个，可以连接6个但是连接成功比较难*/
 /*如果要使用单连接，ableDeviceSum传入参数为1，只调用hzlblueDataBlock_A即可*/
//各个设备的数据回调
@property (nonatomic,copy)Blue4DataBlock  hzlblueDataBlock_A;
@property (nonatomic,copy)Blue4DataBlock  hzlblueDataBlock_B;
@property (nonatomic,copy)Blue4DataBlock  hzlblueDataBlock_C;
@property (nonatomic,copy)Blue4DataBlock  hzlblueDataBlock_D;
@property (nonatomic,copy)Blue4DataBlock  hzlblueDataBlock_E;
@property (nonatomic,copy)Blue4DataBlock  hzlblueDataBlock_F;
//各个设备连接状态
@property (nonatomic,assign)BOOL  connected_A;
@property (nonatomic,assign)BOOL  connected_B;
@property (nonatomic,assign)BOOL  connected_C;
@property (nonatomic,assign)BOOL  connected_D;
@property (nonatomic,assign)BOOL  connected_E;
@property (nonatomic,assign)BOOL  connected_F;

/*! @brief 是否打印log  默认不打印
 */
+ (void)logEnable:(BOOL)enable;

/*! @brief 初始化(单例)
 */
+ (instancetype)shareInstance;

/*! @brief 连接配置 
   blueNames: 可以连接的设备名(4.0指设备名称如BrainLink_Pro)
   ableDeviceSum: 可以连接的蓝牙设备个数
*/
-(void)configureBlueNames:(NSArray *)blueNames  ableDeviceSum:(int)ableDeviceSum;

/*! @brief 连接蓝牙设备
 */
-(void)connectBlue4;

/*! @brief 断开蓝牙设备
 */
-(void)disConnectBlue4;


/*! @brief 手动测试假连接（假连接定义：当signal = 0的时候，attention和medition的连续10个值不变，认为是假连接，断开当前设备的蓝牙连接，再次自动连接）
 */

-(void)testAFalseCon:(BOOL)isTest;//手动测试A设备假连接
-(void)setTestToZero;//取消所有手动测试假连接
@end
