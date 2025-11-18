package io.iden3.polygonid_flutter_sdk

import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.concurrent.Executors

/** PolygonIdSdkPlugin */
class PolygonIdSdkPlugin : FlutterPlugin, MethodCallHandler {

    companion object {
        private const val TAG = "PolygonIdSdkPlugin"

        // Cached thread pool for background operations
        private val backgroundExecutor = Executors.newCachedThreadPool()

        // Handler for main thread operations
        private val mainHandler = Handler(Looper.getMainLooper())

        init {
            System.loadLibrary("polygonid")
            System.loadLibrary("polygonid_module")
        }
    }

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.i(TAG, "onAttachedToEngine")

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "polygonid_flutter_sdk")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.i(TAG, "Method call received: ${call.method}")

        when (call.method) {
            "verifyAuthResponse" -> {
                val input = call.argument<String>("in")!!
                val cfg = call.argument<String>("cfg")!!

                verifyAuthResponse(input, cfg, result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun verifyAuthResponse(inParam: String, cfg: String, result: Result) {
        // Execute on background thread pool
        backgroundExecutor.execute {
            try {
                // Call native C function
                val response = nativeVerifyAuthResponse(inParam, cfg)

                // Return result on main thread
                mainHandler.post {
                    result.success(response)
                }
            } catch (e: Exception) {
                // Return error on main thread
                mainHandler.post {
                    result.error("VERIFY_AUTH_ERROR", e.message ?: "Unknown error", null)
                }
            }
        }
    }

    private external fun nativeVerifyAuthResponse(inParam: String, cfg: String): String
}
