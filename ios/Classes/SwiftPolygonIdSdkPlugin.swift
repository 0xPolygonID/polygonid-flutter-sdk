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
        // libpolygonid bindings
        PLGNAuthV2InputsMarshal(nil, nil, nil);
        PLGNCalculateGenesisID(nil, nil, nil);
        PLGNNewGenesisID(nil, nil, nil, nil);
        PLGNNewGenesisIDFromEth(nil, nil, nil, nil);
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
        PLGNAtomicQueryV3Inputs(nil, nil, nil, nil);
        PLGNAtomicQueryV3OnChainInputs(nil, nil, nil, nil);
        PLGNALinkedMultiQueryInputs(nil, nil, nil, nil);
        PLGNFreeStatus(nil);

        PLGNCleanCache(nil);
        PLGNCleanCache2(nil, nil);
        PLGNCacheCredentials(nil, nil, nil);

        PLGNW3CCredentialFromOnchainHex(nil, nil, nil, nil);

        PLGNDescribeID(nil, nil, nil, nil);
        PLGNBabyJubJubSignPoseidon(nil, nil, nil, nil);
        PLGNBabyJubJubVerifyPoseidon(nil, nil, nil, nil);
        PLGNBabyJubJubPrivate2Public(nil, nil, nil, nil);
        PLGNBabyJubJubPublicUncompress(nil, nil, nil, nil);
        PLGNBabyJubJubPublicCompress(nil, nil, nil, nil);
        
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

        // witnesscalc v3 bindings
        witnesscalc_credentialAtomicQueryV3(nil, 0, nil, 0, nil, nil, nil, 0);

        // witnesscalc v3 onchain bindings
        witnesscalc_credentialAtomicQueryV3OnChain(nil, 0, nil, 0, nil, nil, nil, 0);

        // witnesscalc linked multi query 10 bindings
        witnesscalc_linkedMultiQuery10(nil, 0, nil, 0, nil, nil, nil, 0);
    }
}
