package com.boby.macrotellectlinkdemo;

import android.content.Context;
import android.graphics.Color;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import com.boby.bluetoothconnect.bean.BrainWave;
import com.boby.bluetoothconnect.bean.Gravity;
import com.github.mikephil.charting.charts.LineChart;

import androidx.constraintlayout.widget.ConstraintLayout;

public class BlueItemView extends ConstraintLayout {
    private TextView att, med, sign, theta, delta, lowAlpha, highAlpha, lowBete, higBete, lowGamma, midGamma, ele, pre, tv_gravity, tv_name, hardVision, grind;
    private LineChart mLineChart;
    private TextView tv_connectType, tv_mac;
    private long startTime;



    public BlueItemView(Context context) {
        super(context);
        init(context);
    }

    public BlueItemView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    public BlueItemView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context);

    }

    void init(Context context) {
        View root = LayoutInflater.from(context).inflate(R.layout.item_blue, this);
        att = root.findViewById(R.id.att);
        med = root.findViewById(R.id.med);
        sign = root.findViewById(R.id.sign);
        theta = root.findViewById(R.id.theta);
        delta = root.findViewById(R.id.delta);
        lowAlpha = root.findViewById(R.id.lowAlpha);
        highAlpha = root.findViewById(R.id.highAlpha);
        lowBete = root.findViewById(R.id.lowBete);
        higBete = root.findViewById(R.id.higBete);
        lowGamma = root.findViewById(R.id.lowGamma);
        midGamma = root.findViewById(R.id.midGamma);
        ele = root.findViewById(R.id.ele);
        pre = root.findViewById(R.id.pre);
        tv_connectType = root.findViewById(R.id.connectType);
        tv_mac = root.findViewById(R.id.mac);
        mLineChart = root.findViewById(R.id.lineChart);
        tv_gravity = root.findViewById(R.id.gravity);
        grind = root.findViewById(R.id.grind);
        hardVision = root.findViewById(R.id.hardVision);
        tv_name = root.findViewById(R.id.tv_name);

        LineChartUtil.setLineChart(mLineChart);


    }


    public void addData(BrainWave brainWave, boolean isAttCheck, boolean isMedCheck) {
        att.setText("" + brainWave.att);
        med.setText("" + brainWave.med);
        theta.setText("" + brainWave.theta);
        delta.setText("" + brainWave.delta);
        lowAlpha.setText("" + brainWave.lowAlpha);
        highAlpha.setText("" + brainWave.highAlpha);
        lowBete.setText("" + brainWave.lowBeta);
        higBete.setText("" + brainWave.highBeta);
        lowGamma.setText("" + brainWave.lowGamma);
        midGamma.setText("" + brainWave.middleGamma);
        ele.setText("" + brainWave.batteryCapacity);
        pre.setText("" + brainWave.ap);
        sign.setText("" + brainWave.signal);
        grind.setText("" + brainWave.grind);
        hardVision.setText("" + brainWave.hardwareversion);
        addData(mLineChart, brainWave.att, brainWave.med, (System.currentTimeMillis() - startTime) / 1000f, isAttCheck, isMedCheck);
    }

    public void setMac(String mac, String connectType, String name) {
        tv_mac.setText(mac);
        tv_connectType.setText(connectType);
        tv_name.setText(name);
        if (!TextUtils.isEmpty(mac) && startTime ==0L) {
            startTime = System.currentTimeMillis() ;
        }
//        mLineChart.clearValues();
    }

    public void setGravity(final Gravity gravity) {
        post(new Runnable() {
            @Override
            public void run() {
                tv_gravity.setText(gravity.X + "," + gravity.Y + "," + gravity.Z);
            }
        });

    }

    public void addData(LineChart lineChart, int att, int meds, float time, boolean isAttCheck, boolean isMedCheck) {

        if (isAttCheck && isMedCheck) {
            LineChartUtil.addEntry(lineChart, "", Color.parseColor("#ff9c9c"), att, Color.parseColor("#71c2f8"), meds, time);
        } else if (isAttCheck) {
            LineChartUtil.addEntry(lineChart, "", Color.parseColor("#ff9c9c"), att, null, null, time);
        } else if (isMedCheck) {
            LineChartUtil.addEntry(lineChart, "", null, null, Color.parseColor("#71c2f8"), meds, time);
        }
    }


}
