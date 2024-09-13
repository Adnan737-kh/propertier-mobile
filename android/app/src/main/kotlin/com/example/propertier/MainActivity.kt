package com.propertier.propertiercom

import android.os.Build
import android.view.Window
import android.view.WindowManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "splashcolor"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
       MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        .setMethodCallHandler { call, result ->
            if (call.method == "setSystemBarsColor") {
                val statusBarColor = call.argument<Long>("statusBarColor")?.toInt()
                val navigationBarColor = call.argument<Long>("navigationBarColor")?.toInt()
                if (statusBarColor != null && navigationBarColor != null) {
                    setSystemBarsColor(statusBarColor, navigationBarColor)
                    result.success(null)
                } else {
                    result.error("ARGUMENT_ERROR", "Invalid argument type", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun setSystemBarsColor(statusBarColor: Int, navigationBarColor: Int) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val window: Window = getWindow()
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
            window.statusBarColor = statusBarColor
            window.navigationBarColor = navigationBarColor
        }
    }
}

