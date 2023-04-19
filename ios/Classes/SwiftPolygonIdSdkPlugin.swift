import Flutter
import UIKit

public class SwiftPolygonIdSdkPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "polygonid_flutter_sdk", binaryMessenger: registrar.messenger())
        let instance = PolygonIdSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }

    public static func dummyMethodToEnforceBundling() {
        // LibBabyjubjub bindings
        pack_signature("16727755406458403965916091816756284515992637653800319054951151706132152331811672775540645840396591609181675628451599263765380031");
        unpack_signature("16727755406458403965916091816756284515992637653800319054951151706132152331811672775540645840396591609181675628451599263765380031");
        pack_point("17777552123799933955779906779655732241715742912184938656739573121738514868268", "2626589144620713026669568689430873010625803728049924121243784502389097019475");
        unpack_point("53b81ed5bffe9545b54016234682e7b2f699bd42a5e9eae27ff4051bc698ce85");
        prv2pub("0001020304050607080900010203040506070809000102030405060708090001");
        poseidon_hash("");
        poseidon_hash2("", "");
        poseidon_hash3("", "", "");
        poseidon_hash4("", "", "", "");
        hash_poseidon("", "", "");
        sign_poseidon("", "");
        verify_poseidon("", "", "");
        let str = "string"
        let unsafePointer = UnsafeMutablePointer<Int8>(mutating: (str as NSString).utf8String)
        cstring_free(unsafePointer);
    }
}
