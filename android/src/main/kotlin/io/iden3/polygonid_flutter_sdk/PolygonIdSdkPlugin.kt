package io.iden3.polygonid_flutter_sdk

import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** PolygonIdSdkPlugin */
class PolygonIdSdkPlugin : FlutterPlugin, MethodCallHandler {

    init {
        System.loadLibrary("polygonid")
        System.loadLibrary("gmp")
        System.loadLibrary("witnesscalc_authV2")
        System.loadLibrary("witnesscalc_credentialAtomicQuerySigV2")
        System.loadLibrary("witnesscalc_credentialAtomicQueryMTPV2")
        System.loadLibrary("witnesscalc_credentialAtomicQuerySigV2OnChain")
        System.loadLibrary("witnesscalc_credentialAtomicQueryMTPV2OnChain")
    }

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "polygonid_flutter_sdk")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        result.notImplemented()
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
