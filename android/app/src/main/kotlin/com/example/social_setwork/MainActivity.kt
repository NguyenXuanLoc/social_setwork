package com.example.social_setwork

import android.os.Bundle
import android.os.PersistableBundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler {
    private val CHANNEL = "flutter.native/playerVideo"
    private val openBroswer = "openBroswer"
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        MethodChannel(getBinaryMessenger(), CHANNEL).setMethodCallHandler(this)
    }

    fun getBinaryMessenger(): BinaryMessenger? {
        return flutterEngine!!.dartExecutor.binaryMessenger
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Toast.makeText(this, "ok", Toast.LENGTH_SHORT).show()
        when (call.method) {
            openBroswer -> {
                Toast.makeText(this, "ok", Toast.LENGTH_SHORT).show()
            }
        }
    }
}
