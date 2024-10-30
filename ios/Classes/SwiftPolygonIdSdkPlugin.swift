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
        pack_point("17777552123799933955779906779655732241715742912184938656739573121738514868268", "2626589144620713026669568689430873010625803728049924121243784502389097019475");
        unpack_point("53b81ed5bffe9545b54016234682e7b2f699bd42a5e9eae27ff4051bc698ce85");
        prv2pub("0001020304050607080900010203040506070809000102030405060708090001");
        sign_poseidon("", "");
        verify_poseidon("", "", "");
        let str = "string"
        let unsafePointer = UnsafeMutablePointer<Int8>(mutating: (str as NSString).utf8String)
        cstring_free(unsafePointer);
        
        // LibPolygonid bindings
        PLGNAuthV2InputsMarshal(nil, nil, nil);
        PLGNCalculateGenesisID(nil, nil, nil);
        PLGNCreateClaim(nil, nil, nil);
        PLGNIDToInt(nil, nil, nil);
        PLGNProofFromSmartContract(nil, nil, nil);
        PLGNProfileID(nil, nil, nil);
        PLGNAtomicQuerySigV2Inputs(nil, nil, nil, nil);
        PLGNSigV2Inputs(nil, nil, nil);
        PLGNAtomicQueryMtpV2Inputs(nil, nil, nil, nil);
        PLGNMtpV2Inputs(nil, nil, nil);
        PLGNAtomicQuerySigV2OnChainInputs(nil, nil, nil, nil);
        PLGNAtomicQueryMtpV2OnChainInputs(nil, nil, nil, nil);
        PLGNFreeStatus(nil);
        
        // witnesscalc authv2 bindings
        witnesscalc_authV2(nil, 0, nil, 0, nil, nil, nil, 0);
        
        // witnesscalc sigv2 bindings
        witnesscalc_credentialAtomicQuerySigV2(nil, 0, nil, 0, nil, nil, nil, 0);
        
        // witnesscalc sigv2 onchain bindings
        witnesscalc_credentialAtomicQuerySigV2OnChain(nil, 0, nil, 0, nil, nil, nil, 0);
        
        // witnesscalc mtpv2 bindings
        witnesscalc_credentialAtomicQueryMTPV2(nil, 0, nil, 0, nil, nil, nil, 0);
        
        // witnesscalc mtpv2 onchain bindings
        witnesscalc_credentialAtomicQueryMTPV2OnChain(nil, 0, nil, 0, nil, nil, nil, 0);
    }
}
