package com.example.morganjoystick

import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothSocket
import java.io.InputStream
import java.io.OutputStream


object BluetoothConstant {
    var outputStream: OutputStream? = null
    var inputStream: InputStream? = null
    var connectedDevice: BluetoothDevice? = null
    var bluetoothSocket: BluetoothSocket? = null
}
