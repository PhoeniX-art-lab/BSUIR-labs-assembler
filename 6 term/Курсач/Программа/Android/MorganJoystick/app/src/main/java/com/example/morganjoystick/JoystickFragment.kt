package com.example.morganjoystick

import android.annotation.SuppressLint
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.IOException
import kotlin.math.PI
import kotlin.math.cos
import kotlin.math.sin


class JoystickFragment : Fragment() {

    private lateinit var joystickView: JoystickView
    private lateinit var coordinatesTextView: TextView
    private lateinit var btStatusTextView: TextView
    private lateinit var bluetoothChecker: BluetoothChecker


    @SuppressLint("MissingInflatedId", "SetTextI18n")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view =  inflater.inflate(R.layout.fragment_joystick, container, false)
        val button = view.findViewById<Button>(R.id.button)

        joystickView = view.findViewById(R.id.joystick_view)
        coordinatesTextView = view.findViewById(R.id.coordinates_text_view)
        btStatusTextView = view.findViewById(R.id.bt_status_text_view)

        bluetoothChecker = BluetoothChecker()
        bluetoothChecker.start()

        button.setOnClickListener{
            findNavController().navigate(R.id.action_joystickFragment_to_settingsFragment)
        }

        joystickView.setOnMoveListener { angle, strength ->
            val x = (41 * cos(angle * PI / 180) * strength).toInt()
            val y = (41 * -sin(angle * PI / 180) * strength).toInt()
            coordinatesTextView.text = "($x, $y)"

            if (BluetoothConstant.connectedDevice != null) {
                CoroutineScope(Dispatchers.IO).launch {
                    sendCoordinates(x, y)
                    delay(50)
                }

                btStatusTextView.text = "Connected"
            }
            else
                btStatusTextView.text = "Not Connected"
        }

        return view
    }

    override fun onDestroy() {
        super.onDestroy()
        bluetoothChecker.stop()
    }

    private fun sendCoordinates(x: Int, y: Int) {
        try {
            val message = "$x,$y"
            val correctMessage = "$$x $y;"
            BluetoothConstant.outputStream?.write(correctMessage.toByteArray())
            Log.i(TAG, "Sending: ${message.toByteArray()})")
            Log.i(TAG, "RAW message: $correctMessage")
        } catch (e: IOException) {
            Log.e(TAG, "Failed to send coordinates to Bluetooth device", e)
        }
    }

    companion object {
        private const val TAG = "JoystickFragment"
    }

}
