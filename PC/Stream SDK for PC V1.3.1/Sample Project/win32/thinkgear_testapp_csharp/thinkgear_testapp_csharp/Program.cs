using libStreamSDK;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace thinkgear_testapp_csharp
{
    class Program
    {
        static void Main(string[] args)
        {
       
            NativeThinkgear thinkgear = new NativeThinkgear();

            /* Print driver version number */
            Console.WriteLine("Version: " + NativeThinkgear.TG_GetVersion());

            /* Get a connection ID handle to ThinkGear */
            int connectionID = NativeThinkgear.TG_GetNewConnectionId();
            Console.WriteLine("Connection ID: " + connectionID);

            if (connectionID < 0)
            {
                Console.WriteLine("ERROR: TG_GetNewConnectionId() returned: " + connectionID);
                return;
            }

            int errCode = 0;
            /* Set/open stream (raw bytes) log file for connection */
            errCode = NativeThinkgear.TG_SetStreamLog(connectionID, "streamLog.txt");
            Console.WriteLine("errCode for TG_SetStreamLog : " + errCode);
            if (errCode < 0)
            {
                Console.WriteLine("ERROR: TG_SetStreamLog() returned: " + errCode);
                return;
            }

            /* Set/open data (ThinkGear values) log file for connection */
            errCode = NativeThinkgear.TG_SetDataLog(connectionID, "dataLog.txt");
            Console.WriteLine("errCode for TG_SetDataLog : " + errCode);
            if (errCode < 0)
            {
                Console.WriteLine("ERROR: TG_SetDataLog() returned: " + errCode);
                return;
            }

            /* Attempt to connect the connection ID handle to serial port "COM5" */
            string comPortName = "\\\\.\\COM40";

            errCode = NativeThinkgear.TG_Connect(connectionID,
                          comPortName,
                          NativeThinkgear.Baudrate.TG_BAUD_57600,
                          NativeThinkgear.SerialDataFormat.TG_STREAM_PACKETS);
            if (errCode < 0)
            {
                Console.WriteLine("ERROR: TG_Connect() returned: " + errCode);
                return;
            }

            /* Read 10 ThinkGear Packets from the connection, 1 Packet at a time */
            int packetsRead = 0;
            while (packetsRead < 10)
            {

                /* Attempt to read a Packet of data from the connection */
                errCode = NativeThinkgear.TG_ReadPackets(connectionID, 1);
                Console.WriteLine("TG_ReadPackets returned: " + errCode);
                /* If TG_ReadPackets() was able to read a complete Packet of data... */
                if (errCode == 1)
                {
                    packetsRead++;

                    /* If attention value has been updated by TG_ReadPackets()... */
                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.TG_DATA_RAW) != 0)
                    {

                        /* Get and print out the updated attention value */
                        Console.WriteLine("New RAW value: : " + (int)NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.TG_DATA_RAW));

                    } /* end "If attention value has been updated..." */

                } /* end "If a Packet of data was read..." */

            } /* end "Read 10 Packets of data from connection..." */

            Console.WriteLine("auto read test begin:" );

            errCode = NativeThinkgear.TG_EnableAutoRead(connectionID, 1);

            int reset_data_count = 0;
            int conOut3 = 0;
            int conOut4 = 0;
            if (errCode == 0)
            {
                packetsRead = 0;
                //NativeThinkgear.MWM15_setFilterType(connectionID, NativeThinkgear.FilterType.MWM15_FILTER_TYPE_50HZ);
                while (packetsRead < 15000)
                {
                    /* If raw value has been updated ... */
                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_DATA_RAW) != 0)
                    {

                        /* Get and print out the updated raw value */
                        if (packetsRead % 200 == 0)
                        {
                            Console.WriteLine("New RAW value: : " + (int)NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_RAW));
                        }else{
                            NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_RAW);
                        }
                        packetsRead++;
                        /*
                        if (packetsRead == 800 || packetsRead == 1600)
                        {
                            NativeThinkgear.MWM15_getFilterType(connectionID);
                            Console.WriteLine(" MWM15_getFilterType called");
                        }*/
                    }

                        

                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_DATA_POOR_QUALITY) != 0)
                    {

                        Console.WriteLine("BMD200_DATA_POOR_QUALITY: : " + (int)NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_POOR_QUALITY));

                    }
                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_DATA_HEART_RATE) != 0)
                    {

                        Console.WriteLine("BMD200_DATA_HEART_RATE: : " + (int)NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_HEART_RATE));

                    }
                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_DATA_SQS_LAST) != 0)
                    {

                        Console.WriteLine("BMD200_DATA_SQS_LAST: : " + (int)NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_SQS_LAST));

                    }
                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_DATA_SQS_OVERALL) != 0)
                    {

                        Console.WriteLine("BMD200_DATA_SQS_OVERALL: : " + NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_SQS_OVERALL));

                    }

                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_DATA_RR_INTERVAL) != 0)
                    {

                        Console.WriteLine("BMD200_DATA_RR_INTERVAL: : " + (int)NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_RR_INTERVAL));

                    }
                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_1_RAW_FLAG) != 0)
                    {

                        Console.WriteLine("BMD200_1_RAW_FLAG: : ");
                        NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_1_RAW_FLAG);
                    }

                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_DATA_ConOut4) != 0)
                    {
                        conOut4 = (int)NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_ConOut4);
                        Console.WriteLine("BMD200_DATA_ConOut4: : " + conOut4);

                    }

                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_DATA_ConOut3) != 0)
                    {
                        conOut3 = (int)NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_ConOut3);
                        Console.WriteLine("BMD200_DATA_ConOut3:  " + conOut3 + " BMD200_DATA_ConOut4:  " + conOut4);
                        reset_data_count++;
                        if (reset_data_count == 2)
                        {
                            Console.WriteLine("BMD200_set8PacketMode: : ");
                            NativeThinkgear.BMD200_set8PacketMode(connectionID, conOut4, conOut3);
                                
                        }
                        else if (reset_data_count == 15)
                        {
                            NativeThinkgear.BMD200_set1PacketMode(connectionID, conOut4, conOut3);
                            Console.WriteLine("BMD200_set1PacketMode: : ");
                        }

                    }

                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_DATA_RAW_8B_1) != 0)
                    {
                        if (packetsRead % 100 == 0)
                        {
                            Console.WriteLine("BMD200_DATA_RAW_8B_1: : " + (int)NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_RAW_8B_1));
                        }
                        else
                        {
                            NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_DATA_RAW_8B_1);
                        }
                        packetsRead += 8;
                    }


                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.BMD200_8_RAW_FLAG) != 0)
                    {
                        Console.WriteLine("BMD200_8_RAW_FLAG: : " );
                        NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.BMD200_8_RAW_FLAG);

                    }



                    
                    /*
                    if (NativeThinkgear.TG_GetValueStatus(connectionID, NativeThinkgear.DataType.MWM15_DATA_FILTER_TYPE) != 0)
                    {
                        Console.WriteLine(" Find Filter Type:  " + NativeThinkgear.TG_GetValue(connectionID, NativeThinkgear.DataType.MWM15_DATA_FILTER_TYPE));
                        break;
                    }*/


                }

                errCode = NativeThinkgear.TG_EnableAutoRead(connectionID, 0); //stop
                Console.WriteLine("auto read test stoped: "+ errCode);
            }
            else
            {
                Console.WriteLine("auto read test failed: " + errCode);
            }

            NativeThinkgear.TG_Disconnect(connectionID); // disconnect test

            /* Clean up */
            NativeThinkgear.TG_FreeConnection(connectionID);

            /* End program */
            Console.ReadLine();

        }
    }
}
