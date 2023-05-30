package com.example.morganjoystick

import android.util.Log
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext


class BluetoothChecker {
    private var isChecking = false
    private val checkIntervalMillis = 5000L // 5 seconds

    private var job: Job? = null

    fun start() {
        isChecking = true
        job = GlobalScope.launch {
            while (isChecking) {
                if (!isBluetoothConnected()) {
                    closeConnections()
                    return@launch
                }
                delay(checkIntervalMillis)
            }
        }
    }

    fun stop() {
        isChecking = false
        job?.cancel()
    }

    private suspend fun isBluetoothConnected(): Boolean {
        return try {
            withContext(Dispatchers.IO) {
                BluetoothConstant.outputStream?.write(0)
            }
            true
        } catch (e: Exception) {
            false
        }
    }

    private suspend fun closeConnections() {
        withContext(Dispatchers.IO) {
            try {
                BluetoothConstant.outputStream?.close()
                BluetoothConstant.inputStream?.close()
                BluetoothConstant.bluetoothSocket?.close()
                BluetoothConstant.connectedDevice = null
            } catch (e: Exception) {
                Log.e(TAG, "$e")
            }
        }
    }

    companion object {
        private const val TAG = "BluetoothChecker"
    }
}