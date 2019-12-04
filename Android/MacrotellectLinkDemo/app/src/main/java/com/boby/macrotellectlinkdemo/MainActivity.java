package com.boby.macrotellectlinkdemo;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.boby.bluetoothconnect.LinkManager;
import com.boby.bluetoothconnect.bean.BrainWave;
import com.boby.bluetoothconnect.bean.Gravity;
import com.boby.bluetoothconnect.classic.bean.BlueConnectDevice;
import com.boby.bluetoothconnect.classic.listener.EEGPowerDataListener;
import com.boby.bluetoothconnect.classic.listener.OnConnectListener;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

public class MainActivity extends AppCompatActivity {
public static final  int LOCATION_PERMISSION_CODE=2019;
public static final String TAG="macrotellectLink";
private LinkManager bluemanage;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initMacrotellectLink();
    }

    void initMacrotellectLink() {
        //先判断是否有访问位置权限,某些设备还需要打开gps
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if ((checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) || (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED)) {
                //申请权限
                requestPermissions(new String[]{Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION}, LOCATION_PERMISSION_CODE);
                return;
            }
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
            public void onGravity(String mac, Gravity gravity) {
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
                Log.e(TAG, "连接成功 name:" + blueConnectDevice.getName() + " mac: " + mac);
            }

            @Override
            public void onError(Exception e) {
                Log.e(TAG, "连接错误");
                e.printStackTrace();

            }
        });
        bluemanage.setMaxConnectSize(1);//设置最大连接数量
        bluemanage.setConnectType(LinkManager.ConnectType.ONLYBLEBLUE);//设置连接类型
        bluemanage.setWhiteList("BrainLink_Pro,BrainLink_Lite");//设置白名单

    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode == LOCATION_PERMISSION_CODE) {
            if (grantResults.length>0) {
                initMacrotellectLink();
            } else {
                if (!ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.
                        permission.ACCESS_COARSE_LOCATION)) {
                    Toast.makeText(this,"获取权限失败",Toast.LENGTH_SHORT).show();
                    return;
                }
            }
        }
    }

    public void start(View view) {
        if(bluemanage!=null){
            bluemanage.startScan();//开始扫描连接
//            bluemanage.close();
        }

    }
}
