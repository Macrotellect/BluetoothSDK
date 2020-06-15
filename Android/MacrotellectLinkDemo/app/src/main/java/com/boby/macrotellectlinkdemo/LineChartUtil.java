package com.boby.macrotellectlinkdemo;

import android.graphics.Color;

import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.components.AxisBase;
import com.github.mikephil.charting.components.Legend;
import com.github.mikephil.charting.components.XAxis;
import com.github.mikephil.charting.components.YAxis;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.github.mikephil.charting.formatter.ValueFormatter;
import com.github.mikephil.charting.interfaces.datasets.ILineDataSet;

import java.text.DecimalFormat;

public class LineChartUtil {


    public static void addEntry(LineChart lineChart, String type1, Integer color1, Integer sdata1,  Integer color2, Integer sdata2, float time) {
        LineData data = lineChart.getData();
        if (data == null) {
            data = new LineData();
            data.setValueTextColor(Color.parseColor("#f36a6a"));
            lineChart.setData(data);
        }
        if (color1 != null && sdata1 != null) {
            ILineDataSet set = data.getDataSetByIndex(0);
            if (set == null) {
                set = createSet(type1, color1);
                data.addDataSet(set);
            }

            set.addEntry(new Entry( time,sdata1));
        }
        if (color2 != null && sdata2 != null) {
            ILineDataSet set2 = data.getDataSetByIndex(1);
            if (set2 == null) {
                set2 = createSet("type2", color2);
                data.addDataSet(set2);
            }
            set2.addEntry(new Entry( time, sdata2));
        }
//         data.addXValue(getTime(time));


        data.notifyDataChanged();

        lineChart.notifyDataSetChanged();
        lineChart.setVisibleXRangeMaximum(25);
        lineChart.moveViewToX(data.getEntryCount() - 7);


    }

    //曲线设置
    public static void setLineChart(LineChart lineChart) {
        lineChart.setTouchEnabled(true);
        lineChart.getDescription().setEnabled(false);

        lineChart.setDragXEnabled(true);
        lineChart.setScaleXEnabled(true);

        lineChart.setScaleYEnabled(false);
        lineChart.setDrawGridBackground(false);
        lineChart.setPinchZoom(true);

        Legend l = lineChart.getLegend();
//        l.setForm(Legend.LegendForm.SQUARE);
//        l.setTextColor(Color.parseColor("#f36a6a"));
//        l.setPosition(Legend.LegendPosition.BELOW_CHART_CENTER);
        l.setEnabled(false);

        // x轴
        XAxis xl = lineChart.getXAxis();
        xl.setTextColor(Color.parseColor("#c9c9c6"));

        xl.setDrawGridLines(true);//是否画网格线
//        xl.setGridGradientColors(new int[]{Color.parseColor("#fafafa"),Color.parseColor("#000000"),Color.parseColor("#000000"),Color.parseColor("#fafafa")});
//        xl.setGridGradientPositions(new float[]{0f,0.2f,0.8f,1f});
        xl.setGridLineWidth(0.6f);
        xl.setGridColor(Color.parseColor("#c8c8c8"));
        xl.setAxisLineColor(Color.parseColor("#c8c8c8"));
        xl.setPosition(XAxis.XAxisPosition.BOTTOM);
        xl.setEnabled(true);//是否画底部数据
        xl.setGranularity(1);
        xl.setValueFormatter(new ValueFormatter() {
            @Override
            public String getFormattedValue(float value) {
                return getTime((int) value);
            }
        });


        YAxis leftAxis = lineChart.getAxisLeft();
        leftAxis.setTextColor(Color.parseColor("#c9c9c6"));
        leftAxis.setAxisMaximum(112);
        leftAxis.setAxisMinimum(0);
        leftAxis.setDrawGridLines(true);
        leftAxis.enableGridDashedLine(11, 15, 15);
        leftAxis.setAxisLineColor(Color.parseColor("#c8c8c8"));
        leftAxis.setValueFormatter(new MyYValueFormatter());
        YAxis rightAxis = lineChart.getAxisRight();
        rightAxis.setEnabled(false);
        lineChart.notifyDataSetChanged();

        lineChart.invalidate();

    }





    public static LineDataSet createSet(String type, int color) {
        LineDataSet set = new LineDataSet(null, type);
        set.setAxisDependency(YAxis.AxisDependency.LEFT);
        set.setColor(color);
        set.setLineWidth(1f);
        set.setDrawCircles(true);
        set.setCircleRadius(3f);
        set.setCircleHoleColor(color);
        set.setCircleColor(color);


        set.setDrawCircleHole(true);
//        set.setDrawFilled(true);
//        if ("type2".equals(type)) {
//            set.setFillColor(Color.parseColor("#d7faff"));
//        } else {
//            set.setFillColor(Color.parseColor("#fdd4d4"));
//        }

        set.setHighlightEnabled(false);

        set.setValueTextColor(color);
        set.setValueTextSize(10f);
        set.setDrawValues(true);
        set.setValueFormatter(new MyValueFormatter());
        set.setHighLightColor(Color.rgb(190, 190, 190));
        return set;
    }

    //根据秒数转化为时分秒   00:00:00
    public static String getTime(int second) {
        if (second < 10) {
            return "00:0" + second;
        }
        if (second < 60) {
            return "00:" + second;
        }
        if (second < 3600) {
            int minute =  (second / 60);
            second = second - minute * 60;
            if (minute < 10) {
                if (second < 10) {
                    return "0" + minute + ":0" + second;
                }
                return "0" + minute + ":" + second;
            }
            if (second < 10) {
                return minute + ":0" + second;
            }
            return minute + ":" + second;
        }
        int hour = second / 3600;
        int minute = (second - hour * 3600) / 60;
        second = second - hour * 3600 - minute * 60;
        if (hour < 10) {
            if (minute < 10) {
                if (second < 10) {
                    return "0" + hour + ":0" + minute + ":0" + second;
                }
                return "0" + hour + ":0" + minute + ":" + second;
            }
            if (second < 10) {
                return "0" + hour + minute + ":0" + second;
            }
            return "0" + hour + minute + ":" + second;
        }
        if (minute < 10) {
            if (second < 10) {
                return hour + ":0" + minute + ":0" + second;
            }
            return hour + ":0" + minute + ":" + second;
        }
        if (second < 10) {
            return hour + minute + ":0" + second;
        }
        return hour + minute + ":" + second;
    }

    public static class MyValueFormatter extends ValueFormatter {

        @Override
        public String getFormattedValue(float value) {
            return "" + (int)value;
        }
    }

    public static class MyYValueFormatter extends ValueFormatter {

        private DecimalFormat mFormat;

        public MyYValueFormatter() {
            mFormat = new DecimalFormat("###,###,##0.#");
        }

        public String getFormattedValue(float value, AxisBase axis) {
            return mFormat.format(value);
        }

    }

}
