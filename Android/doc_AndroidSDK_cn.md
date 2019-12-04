# Android MacrotellectLink_V1.0 开发指南

### 介绍

本指南将教你如何使用MacrotellectLink SDK从宏智力公司的硬件中获取脑电波数据。这将使您的Android应用程序能够接收和使用脑波数据，如BrainWave和Gravity，你可以通过蓝牙，宏智力公司的硬件和文件资源MacrotellectLink SDK来获取它们。

 

**功能:**

接收脑波数据。

**支持的硬件设备：**

-  蓝牙4.0 BLE

	-  BrainLink_Pro

-  蓝牙3.0

	-  BrainLink_Lite 

	-  Mind Link

 

**支持的Android版本：**

-  Android 4.3 +

### 你的第一个项目: MacrotellectLinkDemo（Android studio）

 1. 将 sdk 复制到项目的libs 文件夹中，并在build.gradle 中添加依赖。

 ```

       dependencies{
              ...
             implementation files('libs/ MacrotellectLink_V1.0.jar')
       }
       
 ```

 

2. 在AndroidMainifest.xml中添加权限
```
       <uses-permission android:name="android.permission.BLUETOOTH" />
       <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
      <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"      />
       <uses-permission  android:name="android.permission.ACCESS_COARSE_LOCATION" />
       <uses-feature
            android:name="android.hardware.bluetooth_le"
           android:required="true" />
```

3. 调用sdk 获取数据 
```java
  //先判断是否有访问位置权限
	if(( checkSelfPermission( Manifest.permission.ACCESS_COARSE_LOCATION)!=PackageM              anager.PERMISSION_GRANTED)||(checkSelfPermission(Manifest.permission.ACCESS_FI              NE_LOCATION) != PackageManager.PERMISSION_GRANTED)){

 //申请权限
	requestPermissions(new String[]{Manifest.permission.ACCESS_COARSE_LOCATION,Manifest.permission.ACCESS_FINE_LOCATION},LOCATION_PERMISSION_CODE);
 }

	bluemanage = LinkManager.init(this);
	bluemanage.setDebug(true);//是否打印日志

//设置脑波数据回调
 	bluemanage.setEegPowerDataListener(new EEGPowerDataListener() {
			@Override
			public void onBrainWavedata(String mac, BrainWave brainWave) {
               Log.e(mac, brainWave.toString() ); //获取脑波数据

           }
            @Override
            public void onRawData(String mac, int raw) {
                     //获取raw数据
            }
            @Override
            public void onGravity( String mac,  Gravity gravity) {
               //获取重力感应数据
            }
        });

              //连接状态回调
		bluemanage.setOnConnectListener(new OnConnectListener() {
           @Override
            public void onConnectionLost(BlueConnectDevice blueConnectDevice) {
                //已连接蓝牙丢失（断开）  
           }
             @Override
            public void onConnectStart(BlueConnectDevice blueConnectDevice) {
                //开始尝试连接
           }
            @Override
            public void onConnectting(BlueConnectDevice blueConnectDevice) {
              //连接中 
			}
            @Override
            public void onConnectFailed(BlueConnectDevice blueConnectDevice) {
               //连接失败
            }
            @Override

            public void onConectSuccess(BlueConnectDevice blueConnectDevice) {
                String mac = blueConnectDevice.getAddress();
                String connectType = blueConnectDevice.isBleConnect ? " 4.0 " : " 3.0 ";

                Log.e(TAG, "连接成功 name:" + blueConnectDevice.getName() + " mac: " +                          mac);
            }

             @Override
            public void onError(Exception e) {
                Log.e(TAG, "连接错误");
                e.printStackTrace();
            }
        });
       bluemanage.setMaxConnectSize(1);//设置最大连接数量
       bluemanage.setConnectType(LinkManager.ConnectType.ALLDEVICE);//设置连接类型
       bluemanage.setWhiteList("BrainLink_pro,BrainLink_Lite");//设置白名单
       bluemanage.startScan();//开始扫描连接

```

##     MacrotellectLink  API 参考

## BrainWave参考
脑波信息实体类,实时解析芯片传给软件的脑波数据得到详细的脑波信息及电量值  
**注：**
连接BrainLink_Lite、Mind Link，只有signal，att，med，delta，theta，lowAlpha，highAlpha，lowBeta，highBeta, lowGamma, middleGamma

**字段**

-  **signal**设备佩戴质量，当值为200表示硬件和手机通过蓝牙已经连接，当值为0表示已经戴好
- **att** 专注度
- **med** 放松度
- **delta**
- **theta**
- **lowAlpha**,
- **highAlpha**
- **lowBeta**
- **highBeta**
- **lowGamma**
- **middleGamma**
- **ap** 喜好度
- **batteryCapacity** 电池电量百分比

## Gravity参考

重力信息实体类, 实时解析芯片传给软件的重力数据得到详细的重力信息值。

**注：**

连接BrainLink_Lite没有重力信息

**字段**

- X, 重力传感器X轴值前后摆动俯仰角 

- Y, 重力传感器Y轴值左右摆动偏航角

- Z，重力传感器Z轴值翅膀摆动滚转角
      
## EEGPowerDataListener参考

接收实时解析芯片数据结果接口类,需要用户实现，可获取到脑波、重力、原始raw值信息。在`Linkmanager类的 setEegPowerDataListener  ( OnConnectListener onConnectListener )`设置数据解析结果回调。

### Method

**void onBrainWavedata(String mac,BrainWave brainWave);**
接收解析的脑波信息。
- mac: 脑波设备的mac地址
- brainWave: 脑波信息

**void onGravity(String mac,Gravity gravity);**
接收解析的重力信息
- mac: 脑波设备的mac地址
- gravity: 重力信息

**void onRawData(String mac,int raw);**
接收原始raw值
-  mac: 脑波设备的mac地址
-  raw: 原始raw值

## OnConnectListener 参考

手机蓝牙与脑波检测设备的连接状态监听接口类，需要用户实现。在Linkmanager 的setOnConnectListener ( OnConnectListener onConnectListener )设置连接监听。

### Method

**oid onConnectStart(BlueConnectDevice blueConnectDevice);**
开始尝试连接
**void onConnectting(BlueConnectDevice blueConnectDevice);**
连接中
**void onConnectFailed(BlueConnectDevice blueConnectDevice);**
连接失败
**void onConectSuccess(BlueConnectDevice blueConnectDevice);**
连接成功
**void onConnectionLost(BlueConnectDevice blueConnectDevice);**
连接丢失（从已连接状态断开连接）
**void onError(Exception e);**
连接错误

## LinkManager参考

该类处理宏智力硬件与蓝牙设备之间的交互

### Method

**public static LinkManager init(Context context)**
初始化(单例)
**public void setDebug(boolean isDebug)**
是否打印log  默认不打印
**public void setMaxConnectSize(int count)**
设置最大连接数量,默认一个
**public void setConnectType(ConnectType connectType);**
设置连接类型
- **ConnectType. ONLYCLASSBLUE** 只通过3.0蓝牙连接设备，需要先手动配对
- **ConnectType. ONLYBLEBLUE**只通过低功耗蓝牙连接设备，无需要先手动配对
- **ConnectType. ALLDEVICE** 允许两种方式连接设备

**getConnectSize();**
获取已连接的数量
**public void setWhiteList(String whiteList)**
设置白名单，只允许连接白名单内的设备名，多个设备之间用 ' , '分隔
**public void setOnConnectListener(OnConnectListener onConnectListener)**
设置蓝牙连接状态回调
**public void setEegPowerDataListener(EEGPowerDataListener eegPowerDataListener)** 
设置脑波数据接收回调
**public void startScan()**
开始扫描连接
**public void disconnectDevice(String mac)**
断开蓝牙连接