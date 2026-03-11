#if canImport(libpolygonidC)
import libpolygonidC
#endif

import Flutter
import UIKit

public class PolygonIdSdkPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        NSLog("PolygonIdSdkPlugin: register")
        let channel = FlutterMethodChannel(name: "polygonid_flutter_sdk", binaryMessenger: registrar.messenger())
        let instance = PolygonIdSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        NSLog("PolygonIdSdkPlugin: Method call received: %@", call.method)

        if (call.method == "verifyAuthResponse") {
            guard let args = call.arguments as? [String: Any],
                  let inParam = args["in"] as? String,
                  let cfg = args["cfg"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS",
                                    message: "Missing or invalid arguments",
                                    details: nil))
                return
            }
            verifyAuthResponse(in: inParam, cfg: cfg, result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    // Cached thread pool for background operations
    private static let backgroundQueue = DispatchQueue(label: "com.polygonid.sdk.background",
                                                       qos: .userInitiated,
                                                       attributes: .concurrent)
    
    public static func dummyMethodToEnforceBundling() {
        libpolygonid_dummy();
    }
    
    private func verifyAuthResponse(in inParam: String, cfg: String, _ result: @escaping FlutterResult) {
        // Execute on background thread pool
        PolygonIdSdkPlugin.backgroundQueue.async {
            var jsonResponsePtr: UnsafeMutablePointer<CChar>? = nil
            var statusPtr: UnsafeMutablePointer<PLGNStatus>? = nil
            
            // Convert Swift strings to C strings
            let inCString = strdup(inParam)
            let cfgCString = strdup(cfg)
            
            defer {
                // Clean up allocated C strings
                free(inCString)
                free(cfgCString)
                
                // Free C library allocated memory
                if jsonResponsePtr != nil {
                    free(jsonResponsePtr)
                }
                if statusPtr != nil {
                    PLGNFreeStatus(statusPtr)
                }
            }
            
            // Call the C function
            PLGNVerifyAuthResponse(&jsonResponsePtr, inCString, cfgCString, &statusPtr)
            
            // Check for errors in status
            // If statusPtr is not nil, an error occurred
            if let status = statusPtr?.pointee {
                // Error occurred
                let errorMessage = status.error_msg != nil ? String(cString: status.error_msg) : "Unknown error"
                DispatchQueue.main.async {
                    result(FlutterError(code: "VERIFY_AUTH_ERROR", message: errorMessage, details: nil))
                }
                return
            }
            
            // Success - convert response to Swift string
            let response: String
            if let jsonPtr = jsonResponsePtr {
                response = String(cString: jsonPtr)
            } else {
                response = ""
            }
            
            // Return result on main thread
            DispatchQueue.main.async {
                result(response)
            }
        }
    }
}
