import Flutter
import UIKit
import CryptoSwift

enum HexConvertError: Error {
    case wrongInputStringLength
    case wrongInputStringCharacters
}

extension StringProtocol {
    func asHexArrayFromNonValidatedSource() -> [UInt8] {
        var startIndex = self.startIndex
        return stride(from: 0, to: count, by: 2).compactMap { _ in
            let endIndex = index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }

    func asHexArray() throws -> [UInt8] {
        if count % 2 != 0 { throw HexConvertError.wrongInputStringLength }
        let characterSet = "0123456789ABCDEFabcdef"
        let wrongCharacter = first { return !characterSet.contains($0) }
        if wrongCharacter != nil { throw HexConvertError.wrongInputStringCharacters }
        return asHexArrayFromNonValidatedSource()
    }
}

public class SwiftPrivadoidPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        // We are not using Flutter channels here
        let channel = FlutterMethodChannel(name: "privadoid_sdk", binaryMessenger: registrar.messenger())
        let instance = SwiftPrivadoidPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    if (call.method == "getPlatformVersion") {
        let res =  testNewClaim()
        result("new claim: " + res)
    } else if (call.method == "createNewIdentity") {
        let arguments : [String] = call.arguments as! [String]
        let res = createNewIdentity(pubX: arguments[0], pubY: arguments[1])
        result(res)
    } else if (call.method == "getGenesisId") {
        let arguments : [String] = call.arguments as! [String]
        let res = getGenesisId(idenState: arguments[0])
        result(res)
    } else if (call.method == "getMerkleTreeRoot") {
        let arguments : [String] = call.arguments as! [String]
        let res = getMerkleTreeRoot(pubX: arguments[0], pubY: arguments[1])
        result(res)
    } else if (call.method == "getAuthClaimTreeEntry") {
        let arguments : [String] = call.arguments as! [String]
        let res = getAuthClaimTreeEntry(pubX: arguments[0], pubY: arguments[1])
        result(res)
    }
    //let str = "string"
    //let unsafePointer = UnsafeMutablePointer<Int8>(mutating: (str as NSString).utf8String)
    //let str2 = reverse(unsafePointer)
    //let str3 = String.init(cString: str2!, encoding: .utf8)!
    //result("String in reverse: " + str3)//UIDevice.current.systemVersion)
    //UIDevice.current.systemVersion)
      
    //result(nil)
  }
    
  public func getMerkleTreeRoot(pubX: String, pubY: String) -> String {
        
    //let schemaHash : [UInt8] = [0x52, 0xFD, 0xFC, 0x07, 0x21, 0x82, 0x65, 0x4F, 0x16, 0x3F, 0x5F, 0x0F, 0x9A, 0x62, 0x1D, 0x72]
    let schemaHash : [UInt8] = [0x7C, 0x08, 0x44, 0xA0, 0x75, 0xA9, 0xDD, 0xC7, 0xFC, 0xBD, 0xFB, 0x4F, 0x88, 0xAC, 0xD9, 0xBC]
    let unsafePointerSchemaHash : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: schemaHash)
        
        /*let pubXBigInt = pubX
        var XVal = pubXBigInt.asHexArrayFromNonValidatedSource()
        XVal = XVal.reversed()
        let unsafePointerX : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: XVal)
        var keyX = IDENBigInt()
        keyX.data = unsafePointerX
        keyX.data_len = 32
        print(XVal)*/
        
        let pubXBigInt = pubX
        let xBytes = pubXBigInt.cString(using: String.Encoding.utf8)!
        let unsafePointerX : UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>(mutating: xBytes)
        let keyX = IDENBigIntFromString(unsafePointerX)
        
        let pubYBigInt = pubY
        let yBytes = pubYBigInt.cString(using: String.Encoding.utf8)!
        let unsafePointerY : UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>(mutating: yBytes)
        let keyY = IDENBigIntFromString(unsafePointerY)
        /*
         var YVal = pubYBigInt.asHexArrayFromNonValidatedSource()
         YVal = YVal.reversed()
         var keyY = IDENBigInt()
         keyY.data = unsafePointerY
         keyY.data_len = 32*/
        //print(YVal)
        
        //let revNonce = UInt64(13260572831089785859)
        let revNonce = UInt64(0)
        
        let entryRes = IDENauthClaimTreeEntry(unsafePointerSchemaHash, keyX, keyY, revNonce)
        
        if (entryRes ==  nil) {
            print("unable to allocate tree entry\n")
            return "ERROR"
        }
        
        if (entryRes?.pointee.status != IDENTREEENTRY_OK) {
            print("error creating tree entry\n")
            if (entryRes?.pointee.error_msg != nil) {
                let msg = String.init(cString: (entryRes?.pointee.error_msg)!)
                print("error message: " + msg)
            }
            return "ERROR"
        }
        
        if (entryRes?.pointee.data_len != 8 * 32) {
            print("unexpected data length\n")
            return "ERROR"
        }
        
        for i in 1...8 {
            print("%i:", i)
            for j in 0...31 {
                print(String(format:"%02X", entryRes!.pointee.data[32*i+j]))
            }
        }
        
        print("generated Tree Entry IS CORRECT")
        
        /*
         * Test merkle tree
         */
        
        let mt = createCorrectMT()
        if (mt == nil) {
            return "ERROR"
        }
        
        let res = addClaimToMT(mt: mt, entryRes: entryRes)
        if (res != 0) {
            return "ERROR"
        }
        
        let mtRoot = IDENmerkleTreeRoot(mt)
        if (mtRoot == nil) {
          print("unable to get merkle tree root\n")
          return "ERROR"
        }
        
        print("Root:")
        var result = String()
        for i in 0...31 {
            result.append(String(format: "%02x",  mtRoot![i]))
        }
        
        if (mtRoot != nil) {
            free(mtRoot)
            print("tree root successfuly freed\n")
        }
    
        if (mt != nil) {
            IDENFreeMerkleTree(mt)
            print("merkle tree successfuly freed\n")
        }
            
        if (entryRes != nil) {
            IDENFreeTreeEntry(entryRes)
            print("tree entry successfuly freed")
        }
        
        return result;
    }
    
  public func getGenesisId(idenState: String) -> String {
    
        var state = idenState.asHexArrayFromNonValidatedSource()
        state = state.reversed()
        let unsafePointerState : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: state)
        
        let idGenesis = IDENidGenesisFromIdenState(unsafePointerState)
        if (idGenesis == nil) {
            print("unable to get genesis id from iden state\n")
            return "ERROR"
        }
        
        print("Genesis ID:")
        var result = String()
        for i in 0...30 {
            result.append(String(format: "%02x", idGenesis![i]))
        }
        
        if (idGenesis != nil) {
            free(idGenesis)
            print("id genesis successfully freed")
        }
        
        return result;
  }
    
  public func getAuthClaimTreeEntry(pubX: String, pubY: String) -> [String] {
        
        //let schemaHash : [UInt8] = [0x52, 0xFD, 0xFC, 0x07, 0x21, 0x82, 0x65, 0x4F, 0x16, 0x3F, 0x5F, 0x0F, 0x9A, 0x62, 0x1D, 0x72]
        let schemaHash : [UInt8] = [0x7C, 0x08, 0x44, 0xA0, 0x75, 0xA9, 0xDD, 0xC7, 0xFC, 0xBD, 0xFB, 0x4F, 0x88, 0xAC, 0xD9, 0xBC]
        let unsafePointerSchemaHash : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: schemaHash)
        
        
        let pubXBigInt = pubX
        let xBytes = pubXBigInt.cString(using: String.Encoding.utf8)!
        let unsafePointerX : UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>(mutating: xBytes)
        let keyX = IDENBigIntFromString(unsafePointerX)
        
        let pubYBigInt = pubY
        let yBytes = pubYBigInt.cString(using: String.Encoding.utf8)!
        let unsafePointerY : UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>(mutating: yBytes)
        let keyY = IDENBigIntFromString(unsafePointerY)
        /*
         var YVal = pubYBigInt.asHexArrayFromNonValidatedSource()
         YVal = YVal.reversed()
         var keyY = IDENBigInt()
         keyY.data = unsafePointerY
         keyY.data_len = 32*/
        //print(YVal)
        
        //let revNonce = UInt64(13260572831089785859)
        let revNonce = UInt64(0)
        
        let entryRes = IDENauthClaimTreeEntry(unsafePointerSchemaHash, keyX, keyY, revNonce)
        
        if (entryRes ==  nil) {
            print("unable to allocate tree entry\n")
            return ["ERROR"]
        }
        
        if (entryRes?.pointee.status != IDENTREEENTRY_OK) {
            print("error creating tree entry\n")
            if (entryRes?.pointee.error_msg != nil) {
                let msg = String.init(cString: (entryRes?.pointee.error_msg)!)
                print("error message: " + msg)
            }
            return ["ERROR"]
        }
        
        if (entryRes?.pointee.data_len != 8 * 32) {
            print("unexpected data length\n")
            return ["ERROR"]
        }
        var result = [String]()
        for i in 0...7 {
            print("%i:", i)
            var resultString = String()
            for j in 0...31 {
                resultString.append(String(format: "%02x",  entryRes!.pointee.data[32*i+j]))
                //print(String(format:"%02X", entryRes!.pointee.data[32*i+j]))
            }
            result.append(resultString)
        }
        
        print("generated Tree Entry IS CORRECT")
        
        /*
         * Test merkle tree
         */
        
        /*let mt = createCorrectMT()
        if (mt == nil) {
            return "ERROR"
        }
        
        let res = addClaimToMT(mt: mt, entryRes: entryRes)
        if (res != 0) {
            return "ERROR"
        }
        
        let mtRoot = IDENmerkleTreeRoot(mt)
        if (mtRoot == nil) {
          print("unable to get merkle tree root\n")
          return "ERROR"
        }
        
        print("Root:")
        var result = String()
        for i in 0...31 {
            result.append(String(format: "%02x",  mtRoot![i]))
        }
        
        if (mtRoot != nil) {
            free(mtRoot)
            print("tree root successfuly freed\n")
        }
    
        if (mt != nil) {
            IDENFreeMerkleTree(mt)
            print("merkle tree successfuly freed\n")
        }*/
            
        if (entryRes != nil) {
            IDENFreeTreeEntry(entryRes)
            print("tree entry successfuly freed")
        }
        
        return result;
  }
    
  public func createNewIdentity(pubX: String, pubY: String) -> String {
        
        //let schemaHash : [UInt8] = [0x52, 0xFD, 0xFC, 0x07, 0x21, 0x82, 0x65, 0x4F, 0x16, 0x3F, 0x5F, 0x0F, 0x9A, 0x62, 0x1D, 0x72]
        let schemaHash : [UInt8] = [0x7C, 0x08, 0x44, 0xA0, 0x75, 0xA9, 0xDD, 0xC7, 0xFC, 0xBD, 0xFB, 0x4F, 0x88, 0xAC, 0xD9, 0xBC]
        let unsafePointerSchemaHash : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: schemaHash)
        
        let pubXBigInt = pubX
        let xBytes = pubXBigInt.cString(using: String.Encoding.utf8)!
        let unsafePointerX : UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>(mutating: xBytes)
        let keyX = IDENBigIntFromString(unsafePointerX)
        
        let pubYBigInt = pubY
        let yBytes = pubYBigInt.cString(using: String.Encoding.utf8)!
        let unsafePointerY : UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>(mutating: yBytes)
        let keyY = IDENBigIntFromString(unsafePointerY)
        
        /*let pubXBigInt = "152f5044240ef872cf7e6742fe202b9e07ed6188e9e734c09b06939704852358"
        var XVal = pubXBigInt.asHexArrayFromNonValidatedSource()
        XVal = XVal.reversed()
        let unsafePointerX : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: XVal)
        /*var keyX = BigInt()
        keyX.value = unsafePointerX
        keyX.len = 32*/
        print(XVal)*/
        
        /*let pubYBigInt = "2865441cd3e276643c84e55004ad259dff282c8c47c6e8c151afacdadf6f6db3"
        var YVal = pubYBigInt.asHexArrayFromNonValidatedSource()
        YVal = YVal.reversed()
        let unsafePointerY : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: YVal)
        /*var keyY = BigInt()
        keyY.value = unsafePointerY
        keyY.len = 32*/
        var keyY =
        print(YVal)*/
        
        let revNonce = UInt64(13260572831089785859)
        
        let entryRes = IDENauthClaimTreeEntry(unsafePointerSchemaHash, keyX, keyY, revNonce)
        
        if (entryRes ==  nil) {
            print("unable to allocate tree entry\n")
            return "ERROR"
        }
        
        if (entryRes?.pointee.status != IDENTREEENTRY_OK) {
            print("error creating tree entry\n")
            if (entryRes?.pointee.error_msg != nil) {
                let msg = String.init(cString: (entryRes?.pointee.error_msg)!)
                print("error message: " + msg)
            }
            return "ERROR"
        }
        
        if (entryRes?.pointee.data_len != 8 * 32) {
            print("unexpected data length\n")
            return "ERROR"
        }
        
           /* for (int i = 0; i < dataLength; ++i)
            {
                [hexString appendFormat:@"%02x", (unsigned int)dataBuffer[i]];
            }

            return [NSString stringWithString:hexString];*/
        
        for i in 0...7 {
            print("%i:", i)
            for j in 0...31 {
                print(String(format:"%02X", entryRes!.pointee.data[32*i+j]))
            }
            //print("\n")
        }
        
        print("generated Tree Entry IS CORRECT")
        
        /*
         * Test merkle tree
         */
        
        let mt = createCorrectMT()
        if (mt == nil) {
            return "ERROR"
        }
        
        let res = addClaimToMT(mt: mt, entryRes: entryRes)
        if (res != 0) {
            return "ERROR"
        }
        
        let mtRoot = IDENmerkleTreeRoot(mt)
        if (mtRoot == nil) {
          print("unable to get merkle tree root\n")
          return "ERROR"
        }
        
        print("Root:")
        for i in 0...31 {
            print(String(format:"%02X", mtRoot![i]))
        }
        print("\n")
        
        let idGenesis = IDENidGenesisFromIdenState(mtRoot)
        if (idGenesis == nil) {
            print("unable to get genesis id from iden state\n")
            return "ERROR"
        }
        
        //let expectedGenesisID : [UInt8] = [
        /*    0x00, 0x00, 0x47, 0x21, 0xF1, 0x2E, 0xD2, 0xEB,
            0xEA, 0x79, 0xAB, 0x80, 0x9C, 0xE7, 0x50, 0xB4,
            0x6A, 0x39, 0xAB, 0x7E, 0x6F, 0xB9, 0x4E, 0xE5,
            0xE5, 0x25, 0x3B, 0x2B, 0x1F, 0x0E, 0x0F]*/
        
        print("Genesis ID:")
        for i in 0...30 {
            print(String(format:"%02X", idGenesis![i]))
        }
        print("\n")
        
        let indexHash = IDENTreeEntryIndexHash(entryRes)
        if (indexHash == nil) {
            print("unable to allocate index hash\n")
            return "ERROR"
        }
        
        if (indexHash?.pointee.status != IDENHASHSTATUS_OK) {
            print("cant calc index hash: " + (indexHash?.pointee.status.rawValue.description)!)
            if (indexHash?.pointee.error_msg != nil) {
                let msg = String.init(cString: (indexHash?.pointee.error_msg)!)
                print("error message: " + msg)
            }
            return "ERROR"
        }
        
        /*print("Index Hash:")
        var indexHashInt = BigInt()
        indexHashInt.value =  indexHash!.pointee.data
        indexHashInt.len = Int32(indexHash!.pointee.data_len)
        for i in 0...(indexHash?.pointee.data_len)! {
            print(indexHashInt)
        }
        print("\n")*/
        
        let proof = IDENmerkleTreeGenerateProof(mt, indexHash)
        if (proof == nil) {
            print("unable to allocate proof\n")
            return "ERROR"
        }
        if (proof?.pointee.status != IDENPROOFSTATUS_OK) {
            print("error generate proof: " + (proof?.pointee.status.rawValue.description)!)
            if (proof?.pointee.error_msg != nil) {
                print("error message: " + (proof?.pointee.error_msg.debugDescription)!)
            }
            return "ERROR"
        }
        
        print("proof existence: ", proof?.pointee.existence ?? false)
        if (proof?.pointee.existence == false) {
            return "ERROR"
        }
        
        if (proof != nil) {
            IDENFreeProof(proof)
            print("proof successfully freed")
        }
        
        if (indexHash != nil) {
            IDENFreeHash(indexHash)
            print("index hash successfully freed")
        }
        
        if (idGenesis != nil) {
            free(idGenesis)
            print("id genesis successfully freed")
        }
        
        if (mtRoot != nil) {
            free(mtRoot)
            print("tree root successfuly freed\n")
        }
    
        if (mt != nil) {
            IDENFreeMerkleTree(mt)
            print("merkle tree successfuly freed\n")
        }
            
        if (entryRes != nil) {
            IDENFreeTreeEntry(entryRes)
            print("tree entry successfuly freed")
        }
        
        return "ALL GOOD";
  }
    
  public func testNewClaim() -> String {
        // var mtRoot = nil
        // var idGenesis = nil
        
        let schemaHash : [UInt8] = [0x52, 0xFD, 0xFC, 0x07, 0x21, 0x82, 0x65, 0x4F, 0x16, 0x3F, 0x5F, 0x0F, 0x9A, 0x62, 0x1D, 0x72]
        let unsafePointerSchemaHash : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: schemaHash)
        
        // X = 15468939102716291673743744296736132867654217747684906302563904432835075522918
        let pubXBigInt = "15468939102716291673743744296736132867654217747684906302563904432835075522918"
        let xBytes = pubXBigInt.cString(using: String.Encoding.utf8)!
        let unsafePointerX : UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>(mutating: xBytes)
        let keyX = IDENBigIntFromString(unsafePointerX)
        
        // Y = 10564057289999407626309237453457578977834988122411075958351091519856342060014
        let pubYBigInt = "10564057289999407626309237453457578977834988122411075958351091519856342060014"
        let yBytes = pubYBigInt.cString(using: String.Encoding.utf8)!
        let unsafePointerY : UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>(mutating: yBytes)
        let keyY = IDENBigIntFromString(unsafePointerY)
        
        
        /*let XVal : [UInt8] = [0x66, 0x41, 0x8C, 0x4D, 0x7F, 0x25, 0x2C, 0xC2, 0x3E, 0xDF, 0x63, 0xE4, 0x5D, 0xBD, 0x98, 0x45, 0x57, 0xD8, 0xA4, 0xDA, 0x41, 0x2C, 0xC8, 0x12, 0x64, 0x16, 0xE0, 0xA4, 0xF8, 0x1B, 0x33, 0x22]
        
        let unsafePointerX : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: XVal)
        var keyX = BigInt()
        keyX.value = unsafePointerX
        keyX.len = 32
        
        // Y = 10564057289999407626309237453457578977834988122411075958351091519856342060014
        let YVal : [UInt8] = [0xEE, 0xCB, 0x05, 0xCF, 0xDD, 0x4F, 0x4D, 0x8A, 0x7B, 0xC1, 0x00, 0xD9, 0x60, 0x62, 0xC0, 0xBA, 0x00, 0x0F, 0x98, 0xBC, 0x6D, 0x99, 0xEA, 0xB2, 0x54, 0xEC, 0x46, 0xC3, 0x66, 0x0B, 0x5B, 0x17];
        let unsafePointerY = UnsafeMutablePointer<UInt8>(mutating: YVal)
        var keyY = BigInt()
        keyY.value = unsafePointerY
        keyY.len = 32*/
        
        let revNonce = UInt64(13260572831089785859)
        
        let entryRes = IDENauthClaimTreeEntry(unsafePointerSchemaHash, keyX, keyY, revNonce)
        
        if (entryRes ==  nil) {
            print("unable to allocate tree entry\n")
            return "ERROR"
        }
        
        if (entryRes?.pointee.status != IDENTREEENTRY_OK) {
            print("error creating tree entry\n")
            if (entryRes?.pointee.error_msg != nil) {
                let msg = String.init(cString: (entryRes?.pointee.error_msg)!)
                print("error message: " + msg)
            }
            return "ERROR"
        }
        
        if (entryRes?.pointee.data_len != 8 * 32) {
            print("unexpected data length\n")
            return "ERROR"
        }
        
        for i in 0...7 {
            print("%i:", i)
            for j in 0...31 {
                print(String(format:"%02X", entryRes!.pointee.data[32*i+j]))
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
          IDENFreeTreeEntry(entryRes)
          print("unexpected tree entry\n")
          return "ERROR"
        }
        
        print("generated Tree Entry IS CORRECT")
        
        /*
         * Test merkle tree
         */
        
        let mt = createCorrectMT()
        if (mt == nil) {
            return "ERROR"
        }
        
        let res = addClaimToMT(mt: mt, entryRes: entryRes)
        if (res != 0) {
            return "ERROR"
        }
        
        let mtRoot = IDENmerkleTreeRoot(mt)
        if (mtRoot == nil) {
          print("unable to get merkle tree root\n")
          return "ERROR"
        }
        
        print("Root:")
        for i in 0...31 {
            print(String(format:"%02X", mtRoot![i]))
        }
        print("\n")
        
        let expectedRoot : [UInt8] = [
          0x49, 0x18, 0x67, 0x79, 0x66, 0x47, 0x21, 0xf1,
          0x2e, 0xd2, 0xeb, 0xea, 0x79, 0xab, 0x80, 0x9c,
          0xe7, 0x50, 0xb4, 0x6a, 0x39, 0xab, 0x7e, 0x6f,
          0xb9, 0x4e, 0xe5, 0xe5, 0x25, 0x3b, 0x2b, 0x1f]
        
        let unsafePointerExpectedRoot : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: expectedRoot)
       
        if (memcmp(unsafePointerExpectedRoot, mtRoot, 32) == 0) {
          print("Generated Tree Root IS CORRECT\n")
        } else {
          print("Generated Tree Root IS WRONG\n")
        }
        
        let idGenesis = IDENidGenesisFromIdenState(mtRoot)
        if (idGenesis == nil) {
            print("unable to get genesis id from iden state\n")
            return "ERROR"
        }
        
        let expectedGenesisID : [UInt8] = [
            0x00, 0x00, 0x47, 0x21, 0xF1, 0x2E, 0xD2, 0xEB,
            0xEA, 0x79, 0xAB, 0x80, 0x9C, 0xE7, 0x50, 0xB4,
            0x6A, 0x39, 0xAB, 0x7E, 0x6F, 0xB9, 0x4E, 0xE5,
            0xE5, 0x25, 0x3B, 0x2B, 0x1F, 0x0E, 0x0F]
        
        print("Genesis ID:")
        for i in 0...30 {
            print(String(format:"%02X", idGenesis![i]))
        }
        print("\n")
        
        let unsafePointerExpectedGenesisID : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: expectedGenesisID)
        
        if ((memcmp(unsafePointerExpectedGenesisID, idGenesis, 31)) == 0) {
            print("Genesis ID IS CORRECT\n")
          } else {
            print("Genesis ID IS WRONG\n")
          }
        
        let indexHash = IDENTreeEntryIndexHash(entryRes)
        if (indexHash == nil) {
            print("unable to allocate index hash\n")
            return "ERROR"
        }
        
        if (indexHash?.pointee.status != IDENHASHSTATUS_OK) {
            print("cant calc index hash: " + (indexHash?.pointee.status.rawValue.description)!)
            if (indexHash?.pointee.error_msg != nil) {
                let msg = String.init(cString: (indexHash?.pointee.error_msg)!)
                print("error message: " + msg)
            }
            return "ERROR"
        }
        
        let expectedIndexHash: [UInt8] = [
            0x87, 0xC3, 0x3F, 0xF5, 0xFD, 0x0A, 0xAC, 0x5F,
                0xF0, 0x25, 0x47, 0x36, 0x07, 0x27, 0xD2, 0x2A,
                0x2B, 0xB5, 0x26, 0x5A, 0x4B, 0xAB, 0x4A, 0x8C,
                0xD3, 0xED, 0x13, 0xF1, 0xF8, 0xDB, 0xC1, 0x15]
        
        let unsafePointerExpectedIndexHash : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: expectedIndexHash)
        
        if (memcmp(unsafePointerExpectedIndexHash, indexHash?.pointee.data, (indexHash?.pointee.data_len)!) == 0) {
            print("Index Hash IS CORRECT\n")
        } else {
            print("Index Hash IS WRONG\n")
        }
        
        let proof = IDENmerkleTreeGenerateProof(mt, indexHash)
        if (proof == nil) {
            print("unable to allocate proof\n")
            return "ERROR"
        }
        if (proof?.pointee.status != IDENPROOFSTATUS_OK) {
            print("error generate proof: " + (proof?.pointee.status.rawValue.description)!)
            if (proof?.pointee.error_msg != nil) {
                print("error message: " + (proof?.pointee.error_msg.debugDescription)!)
            }
            return "ERROR"
        }
        
        print("proof existence: ", proof?.pointee.existence)
        if (proof?.pointee.existence == false) {
            return "ERROR"
        }
        
        if (proof != nil) {
            IDENFreeProof(proof)
            print("proof successfully freed")
        }
        
        if (indexHash != nil) {
            IDENFreeHash(indexHash)
            print("index hash successfully freed")
        }
        
        if (idGenesis != nil) {
            free(idGenesis)
            print("id genesis successfully freed")
        }
        
        if (mtRoot != nil) {
            free(mtRoot)
            print("tree root successfuly freed\n")
        }
    
        if (mt != nil) {
            IDENFreeMerkleTree(mt)
            print("merkle tree successfuly freed\n")
        }
            
        if (entryRes != nil) {
            IDENFreeTreeEntry(entryRes)
            print("tree entry successfuly freed")
        }
        
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
    
  public func createCorrectMT() -> UnsafeMutablePointer<IDENmerkleTree>? {
        let mt = IDENnewMerkleTree(40)
        
        if (mt == nil) {
            print("unable to allocate merkle tree\n")
            return nil
        }
        
        if (mt?.pointee.status != IDENTMERKLETREE_OK) {
            print("error creating merkle tree, code: " + (mt?.pointee.status.rawValue.description)!)
            if (mt?.pointee.error_msg != nil) {
                print("error message: " + (mt?.pointee.error_msg.debugDescription)!)
            }
            IDENFreeMerkleTree(mt)
            return nil
        }
        
        print("merkle tree successfuly created\n")
        return mt
  }
    
  public func addClaimToMT(mt: UnsafeMutablePointer<IDENmerkleTree>?, entryRes: UnsafeMutablePointer<IDENTreeEntry>?) -> Int {
        let addStatus = IDENmerkleTreeAddClaim(mt, entryRes)
        
        if (addStatus == nil) {
            print("unable to allocate result to add entry to merkle tree")
            return 1
        }
        
        if (addStatus?.pointee.status != IDENSTATUSCODE_OK) {
            print("error add entry to merkle tree, code %i", addStatus?.pointee.status)
            if (addStatus?.pointee.error_msg != nil) {
                print(", error message: %s", addStatus?.pointee.error_msg)
            };
            print("\n")
            IDENFreeStatus(addStatus)
            return 1
        }
        
        IDENFreeStatus(addStatus)
        return 0
  }

  public static func dummyMethodToEnforceBundling() {
      // Iden3 Core
      /*let schemaHash : [UInt8] = [0x52, 0xFD, 0xFC, 0x07, 0x21, 0x82, 0x65, 0x4F, 0x16, 0x3F, 0x5F, 0x0F, 0x9A, 0x62, 0x1D, 0x72]
      let unsafePointerSchemaHash : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(mutating: schemaHash)
      let xBytes = "pubXBigInt".cString(using: String.Encoding.utf8)!
      let unsafePointerX : UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>(mutating: xBytes)
      let keyX = IDENBigIntFromString(unsafePointerX)
      let revNonce = UInt64(13260572831089785859)
      let entryRes = IDENauthClaimTreeEntry(unsafePointerSchemaHash, keyX, keyX, revNonce)
      let mt = IDENnewMerkleTree(40)
      let mtRoot = IDENmerkleTreeRoot(mt)
      let idGenesis = IDENidGenesisFromIdenState(mtRoot)
      let addStatus = IDENmerkleTreeAddClaim(mt, entryRes)
      let indexHash = IDENTreeEntryIndexHash(entryRes)
      let proof = IDENmerkleTreeGenerateProof(mt, indexHash)
      IDENFreeProof(proof)
      IDENFreeHash(indexHash)
      IDENFreeStatus(addStatus)
      free(idGenesis)
      free(mtRoot)
      IDENFreeMerkleTree(mt)
      IDENFreeTreeEntry(entryRes)*/
      // PrivadoID Plugin
      pack_signature("16727755406458403965916091816756284515992637653800319054951151706132152331811672775540645840396591609181675628451599263765380031");
      unpack_signature("16727755406458403965916091816756284515992637653800319054951151706132152331811672775540645840396591609181675628451599263765380031");
      pack_point("17777552123799933955779906779655732241715742912184938656739573121738514868268", "2626589144620713026669568689430873010625803728049924121243784502389097019475");
      unpack_point("53b81ed5bffe9545b54016234682e7b2f699bd42a5e9eae27ff4051bc698ce85");
      prv2pub("0001020304050607080900010203040506070809000102030405060708090001");
      hash_poseidon("", "", "");
      sign_poseidon("", "");
      verify_poseidon("", "", "");
      let str = "string"
      let unsafePointer = UnsafeMutablePointer<Int8>(mutating: (str as NSString).utf8String)
      let str2 = reverse(unsafePointer)
      cstring_free(unsafePointer);
    }
}
