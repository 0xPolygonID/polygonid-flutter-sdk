import Flutter
import UIKit

public class SwiftPrivadoidPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // We are not using Flutter channels here
    let channel = FlutterMethodChannel(name: "privadoid_sdk", binaryMessenger: registrar.messenger())
    let instance = SwiftPrivadoidPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    //let str = "string"
    //let unsafePointer = UnsafeMutablePointer<Int8>(mutating: (str as NSString).utf8String)
    //let str2 = reverse(unsafePointer)
    //let str3 = String.init(cString: str2!, encoding: .utf8)!
    //result("String in reverse: " + str3)//UIDevice.current.systemVersion)
    let res =  testNewClaim()
    result("new claim: " + res)//UIDevice.current.systemVersion)
      
    //result(nil)
  }
    
    public func testNewClaim() -> String {
        let schemaHash : [UInt8] = [0x52, 0xFD, 0xFC, 0x07, 0x21, 0x82, 0x65, 0x4F, 0x16, 0x3F, 0x5F, 0x0F, 0x9A, 0x62, 0x1D, 0x72]
        let unsafePointerSchemaHash : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: schemaHash)
        
        let XVal : [UInt8] = [0x66, 0x41, 0x8C, 0x4D, 0x7F, 0x25, 0x2C, 0xC2, 0x3E, 0xDF, 0x63, 0xE4, 0x5D, 0xBD, 0x98, 0x45, 0x57, 0xD8, 0xA4, 0xDA, 0x41, 0x2C, 0xC8, 0x12, 0x64, 0x16, 0xE0, 0xA4, 0xF8, 0x1B, 0x33, 0x22]
        let unsafePointerX : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: XVal)
        var keyX = Int()
        keyX.value = unsafePointerX
        keyX.len = 32
        
        let YVal : [UInt8] = [0x66, 0x41, 0x8C, 0x4D, 0x7F, 0x25, 0x2C, 0xC2, 0x3E, 0xDF, 0x63, 0xE4, 0x5D, 0xBD, 0x98, 0x45, 0x57, 0xD8, 0xA4, 0xDA, 0x41, 0x2C, 0xC8, 0x12, 0x64, 0x16, 0xE0, 0xA4, 0xF8, 0x1B, 0x33, 0x22];
        let unsafePointerY = UnsafeMutablePointer<UInt8>(mutating: YVal)
        var keyY = Int()
        keyY.value = unsafePointerY
        keyY.len = 32
        
        let revNonce = UInt64(13260572831089785859)
        
        let entryRes = IDENauthClaimTreeEntry(unsafePointerSchemaHash, keyX, keyY, revNonce)
        
        if (entryRes ==  nil) {
            print("unable to allocate tree entry\n")
            return "ERROR"
        }
        
        if (entryRes?.pointee.status != IDENTREEENTRY_OK) {
            print("error creating tree entry\n")
            if (entryRes?.pointee.error_msg != nil) {
                print("error message: " + (entryRes?.pointee.error_msg.debugDescription)!)
            }
            return "ERROR"
        }
        
        if (entryRes?.pointee.data_len != 8 * 32) {
            print("unexpected data length\n")
            return "ERROR"
        }
        
        for i in 1...8 {
            print("%i:", i)
            for j in 1...32 {
                print(" %02X", entryRes?.pointee.data[32*i+j])
            }
            print("\n")
        }
        
        // expected tree entry
        let expected : [UInt8] = [
          0x52, 0xFD, 0xFC, 0x07, 0x21, 0x82, 0x65, 0x4F, 0x16, 0x3F, 0x5F, 0x0F, 0x9A, 0x62, 0x1D, 0x72, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x66, 0x41, 0x8C, 0x4D, 0x7F, 0x25, 0x2C, 0xC2, 0x3E, 0xDF, 0x63, 0xE4, 0x5D, 0xBD, 0x98, 0x45, 0x57, 0xD8, 0xA4, 0xDA, 0x41, 0x2C, 0xC8, 0x12, 0x64, 0x16, 0xE0, 0xA4, 0xF8, 0x1B, 0x33, 0x22,
          0xEE, 0xCB, 0x05, 0xCF, 0xDD, 0x4F, 0x4D, 0x8A, 0x7B, 0xC1, 0x00, 0xD9, 0x60, 0x62, 0xC0, 0xBA, 0x00, 0x0F, 0x98, 0xBC, 0x6D, 0x99, 0xEA, 0xB2, 0x54, 0xEC, 0x46, 0xC3, 0x66, 0x0B, 0x5B, 0x17,
          0x03, 0x7C, 0x4D, 0x7B, 0xBB, 0x04, 0x07, 0xB8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        ]
        let unsafePointerExpected : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: expected)
       
        if (unsafePointerExpected == entryRes?.pointee.data) {
          IDENFreeTreeEntryResult(entryRes)
          print("unexpected tree entry\n")
          return "ERROR"
        }
        
        print("generated Tree Entry IS CORRECT")
        
        /*
         * Test merkle tree
         */
        
        let mt = IDENnewMerkleTree(40)
        
        if (mt == nil) {
            print("unable to allocate merkle tree\n")
            IDENFreeTreeEntryResult(entryRes)
            return "ERROR"
        }
        
        if (mt?.pointee.status != IDENTMERKLETREE_OK) {
            print("error creating merkle tree, code: " + (mt?.pointee.status.rawValue.description)!)
            if (mt?.pointee.error_msg != nil) {
                print("error message: " + (mt?.pointee.error_msg.debugDescription)!)
            }
            IDENFreeMerkleTree(mt)
            IDENFreeTreeEntryResult(entryRes)
            return "ERROR"
        }
        
        print("merkle tree successfuly created\n")
        
        let addStatus = IDENmerkleTreeAddClaim(mt, entryRes)
        
        // tree entry is not needed anymore
        IDENFreeTreeEntryResult(entryRes);
        
        if (addStatus == nil) {
            IDENFreeMerkleTree(mt)
            print("unable to allocate result to add entry to merkle tree")
            return "ERROR"
        }
        
        if (addStatus?.pointee.status != IDENSTATUSCODE_OK) {
            print("error add entry to merkle tree, code %i", addStatus?.pointee.status)
            if (addStatus?.pointee.error_msg != nil) {
                print(", error message: %s", addStatus?.pointee.error_msg)
            };
            print("\n")
            IDENFreeMerkleTree(mt)
            IDENFreeStatus(addStatus)
            return "ERROR"
        }
        
        // addStatus is not needed anymore
        IDENFreeStatus(addStatus)
        print("add status successfuly freed\n")
        
        let mtRoot = IDENmerkleTreeRoot(mt)
        if (mtRoot == nil) {
          IDENFreeMerkleTree(mt)
          print("unable to get merkle tree root\n")
          return "ERROR"
        }
        
        print("Root:")
        for i in 1...32 {
            print(" %02X", mtRoot?[i])
        }
        print("\n")
        
        let expectedRoot : [UInt8] = [
          0x49, 0x18, 0x67, 0x79, 0x66, 0x47, 0x21, 0xf1,
          0x2e, 0xd2, 0xeb, 0xea, 0x79, 0xab, 0x80, 0x9c,
          0xe7, 0x50, 0xb4, 0x6a, 0x39, 0xab, 0x7e, 0x6f,
          0xb9, 0x4e, 0xe5, 0xe5, 0x25, 0x3b, 0x2b, 0x1f]
        
        let unsafePointerExpectedRoot : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: expectedRoot)
       
        if (unsafePointerExpectedRoot == mtRoot) {
          print("Generated Tree Root IS CORRECT\n")
        }
        
        free(mtRoot)
        print("tree root successfuly freed\n")
        
        IDENFreeMerkleTree(mt)
        print("merkle tree successfuly freed\n")
        
        return "ALL GOOD";
    }
    
    public func testMerkleTree() {
        let mt = IDENnewMerkleTree(40)
        
        if (mt == nil) {
            print("unable to allocate merkle tree\n")
            
        }
        
        if (mt?.pointee.status != IDENTMERKLETREE_OK) {
            print("error creating merkle tree, code: " + (mt?.pointee.status.rawValue.description)!)
            if (mt?.pointee.error_msg != nil) {
                print("error message: " + (mt?.pointee.error_msg.debugDescription)!)
            }
            IDENFreeMerkleTree(mt)
            //IDENFreeTreeEntryResult(entryRes)
            //result("New MerkleTree: OK!!")
        } else {
            print("merkle tree successfuly created\n")
            //result("New MerkleTree: WRONG!!")
        }
        
        
    }

  public func dummyMethodToEnforceBundling() {
      pack_signature("16727755406458403965916091816756284515992637653800319054951151706132152331811672775540645840396591609181675628451599263765380031");
      unpack_signature("16727755406458403965916091816756284515992637653800319054951151706132152331811672775540645840396591609181675628451599263765380031");
      pack_point("17777552123799933955779906779655732241715742912184938656739573121738514868268", "2626589144620713026669568689430873010625803728049924121243784502389097019475");
      unpack_point("53b81ed5bffe9545b54016234682e7b2f699bd42a5e9eae27ff4051bc698ce85");
      prv2pub("0001020304050607080900010203040506070809000102030405060708090001");
      hash_poseidon("", "", "", "", "", "");
      sign_poseidon("", "");
      verify_poseidon("", "", "");
      let str = "string"
      let unsafePointer = UnsafeMutablePointer<Int8>(mutating: (str as NSString).utf8String)
      let str2 = reverse(unsafePointer)
      cstring_free(unsafePointer);
    }
}
