package com.example.morganjoystick

import android.Manifest
import android.annotation.SuppressLint
import android.bluetooth.BluetoothAdapter
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.ListView
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.fragment.app.Fragment
import java.util.UUID
import java.lang.Exception


class SettingsFragment : Fragment() {

    private lateinit var bluetoothAdapter: BluetoothAdapter

    @SuppressLint("MissingInflatedId")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val view = inflater.inflate(R.layout.fragment_settings, container, false)
        // Get a reference to the BluetoothAdapter
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()

        // Check if Bluetooth is supported and enabled
        if (!bluetoothAdapter.isEnabled) {
            // Bluetooth is not supported or not enabled, do nothing
            return view
        }

        // Query the paired devices
        if (ActivityCompat.checkSelfPermission(
                requireContext(),
                Manifest.permission.BLUETOOTH_CONNECT
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            return view
        }
        val pairedDevices = bluetoothAdapter.bondedDevices

        // Create a list of device names and MAC addresses
        val deviceList = ArrayList<String>()
        for (device in pairedDevices) {
            deviceList.add(device.name + "\n" + device.address)
        }

        // Display the list in a ListView
        val listView = view.findViewById<ListView>(R.id.device_list_view)
        val adapter = ArrayAdapter(requireContext(), android.R.layout.simple_list_item_1, deviceList)
        listView.adapter = adapter

        // Set a click listener for the list items
        listView.setOnItemClickListener { parent, view, position, id ->
            val deviceInfo = deviceList[position].split("\n")
            val deviceName = deviceInfo[0]
            val deviceAddress = deviceInfo[1]

            try {
                connectToBluetoothDevice(deviceAddress)
                Toast.makeText(requireContext(), "Selected device: $deviceName ($deviceAddress)", Toast.LENGTH_SHORT).show()
            }
            catch (exception: Exception) {
                Toast.makeText(requireContext(), "Can't connected to device", Toast.LENGTH_SHORT).show()
                Log.e(TAG, "!!!!!!!!!!!!!!!!!$exception!!!!!!!!!!!!!!!!!!!!")
            }
        }
        return view
    }

    private fun connectToBluetoothDevice(deviceAddress: String) {
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()

        val hc06Device = bluetoothAdapter.getRemoteDevice(deviceAddress)
        Log.i(TAG, "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$hc06Device!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        val uuid = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")
        if (ActivityCompat.checkSelfPermission(
                requireContext(),
                Manifest.permission.    BLUETOOTH_CONNECT
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            Log.e(TAG, "No permissions to connect BT")
            return
        }
        val bluetoothSocket = hc06Device.createInsecureRfcommSocketToServiceRecord(uuid)
        bluetoothSocket.connect()
        BluetoothConstant.outputStream = bluetoothSocket.outputStream
        BluetoothConstant.inputStream = bluetoothSocket.inputStream
        BluetoothConstant.connectedDevice = hc06Device
        BluetoothConstant.bluetoothSocket = bluetoothSocket
    }

    companion object {
        private const val TAG = "SettingsFragment"
    }
}