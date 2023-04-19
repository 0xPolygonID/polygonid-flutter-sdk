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
        
        // Prover bindings
        groth16_prover(nil, 0, nil, 0, nil, nil, nil, nil, nil, 0);
        
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
