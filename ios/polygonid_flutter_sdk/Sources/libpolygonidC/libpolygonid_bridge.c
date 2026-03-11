//
//  libpolygonid_bridge.c
//
//
//  Created by Yaroslav Moria on 28.10.2025.
//

#include "libpolygonid_bridge.h"
#ifdef __cplusplus
extern "C" {
#endif

// Forward declare all symbols if not already via included headers (libpolygonid.h should be included transitively).
// We create a global array marked used so the linker keeps these symbols even if otherwise unreferenced.
// Using const and attribute((used)) prevents dead-strip and LTO elimination.
static void* const __attribute__((used)) libpolygonid_force_link[] = {
    (void*)PLGNAuthV2InputsMarshal,
    (void*)PLGNCalculateGenesisID,
    (void*)PLGNNewGenesisID,
    (void*)PLGNNewGenesisIDFromEth,
    (void*)PLGNW3CCredentialToCoreClaim,
    (void*)PLGNCreateClaim,
    (void*)PLGNIDToInt,
    (void*)PLGNProofFromSmartContract,
    (void*)PLGNProfileID,
    (void*)PLGNAtomicQuerySigV2Inputs,
    (void*)PLGNSigV2Inputs,
    (void*)PLGNAtomicQueryMtpV2Inputs,
    (void*)PLGNMtpV2Inputs,
    (void*)PLGNAtomicQuerySigV2OnChainInputs,
    (void*)PLGNAtomicQueryMtpV2OnChainInputs,
    (void*)PLGNAtomicQueryV3Inputs,
    (void*)PLGNAtomicQueryV3OnChainInputs,
    (void*)PLGNALinkedMultiQueryInputs,
    (void*)PLGNAGenerateInputs,
    (void*)PLGNFreeStatus,
    (void*)PLGNCleanCache,
    (void*)PLGNCleanCache2,
    (void*)PLGNCacheCredentials,
    (void*)PLGNW3CCredentialFromOnchainHex,
    (void*)PLGNW3CCredentialFromAnonAadhaarInputs,
    (void*)PLGNW3CCredentialFromPassportInputs,
    (void*)PLGNDescribeID,
    (void*)PLGNBabyJubJubSignPoseidon,
    (void*)PLGNBabyJubJubVerifyPoseidon,
    (void*)PLGNBabyJubJubPrivate2Public,
    (void*)PLGNBabyJubJubPublicUncompress,
    (void*)PLGNBabyJubJubPublicCompress,
    (void*)PLGNValidateAttestationDocument,
    (void*)PLGNAAnonPack,
    (void*)PLGNAAnonUnpack,
    (void*)PLGNDecryptJWE,
    (void*)PLGNDecryptEncryptedCredential,
    (void*)PLGNVerifyProof,
    (void*)PLGNVerifyAnonAadhaarQR,
};

void libpolygonid_dummy(void) {
    // Touch the array so the compiler cannot optimize it away entirely.
    // The volatile read enforces a side-effect.
    volatile void* sink = libpolygonid_force_link[0];
    (void)sink;
}

#ifdef __cplusplus
}
#endif
