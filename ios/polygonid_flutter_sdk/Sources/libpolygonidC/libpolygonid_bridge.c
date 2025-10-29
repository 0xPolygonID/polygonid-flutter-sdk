//
//  libpolygonid_bridge.c
//
//
//  Created by Yaroslav Moria on 28.10.2025.
//

#include "libpolygonid_bridge.h"

void libpolygonid_dummy(void) {
    // Reference libpolygonid exported symbols to prevent dead stripping.
    // We do this by taking their addresses instead of calling them with NULL arguments.
    // Cast to void* then void to silence any warnings about unused values.
    (void)(void*)PLGNAuthV2InputsMarshal;
    (void)(void*)PLGNCalculateGenesisID;
    (void)(void*)PLGNNewGenesisID;
    (void)(void*)PLGNNewGenesisIDFromEth;
    (void)(void*)PLGNW3CCredentialToCoreClaim;
    (void)(void*)PLGNCreateClaim;
    (void)(void*)PLGNIDToInt;
    (void)(void*)PLGNProofFromSmartContract;
    (void)(void*)PLGNProfileID;
    (void)(void*)PLGNAtomicQuerySigV2Inputs;
    (void)(void*)PLGNSigV2Inputs;
    (void)(void*)PLGNAtomicQueryMtpV2Inputs;
    (void)(void*)PLGNMtpV2Inputs;
    (void)(void*)PLGNAtomicQuerySigV2OnChainInputs;
    (void)(void*)PLGNAtomicQueryMtpV2OnChainInputs;
    (void)(void*)PLGNAtomicQueryV3Inputs;
    (void)(void*)PLGNAtomicQueryV3OnChainInputs;
    (void)(void*)PLGNALinkedMultiQueryInputs;
    (void)(void*)PLGNAGenerateInputs;
    (void)(void*)PLGNFreeStatus;

    (void)(void*)PLGNCleanCache;
    (void)(void*)PLGNCleanCache2;
    (void)(void*)PLGNCacheCredentials;

    (void)(void*)PLGNW3CCredentialFromOnchainHex;
    (void)(void*)PLGNW3CCredentialFromAnonAadhaarInputs;
    (void)(void*)PLGNW3CCredentialFromPassportInputs;

    (void)(void*)PLGNDescribeID;
    (void)(void*)PLGNBabyJubJubSignPoseidon;
    (void)(void*)PLGNBabyJubJubVerifyPoseidon;
    (void)(void*)PLGNBabyJubJubPrivate2Public;
    (void)(void*)PLGNBabyJubJubPublicUncompress;
    (void)(void*)PLGNBabyJubJubPublicCompress;
    (void)(void*)PLGNValidateAttestationDocument;

    (void)(void*)PLGNAAnonPack;
    (void)(void*)PLGNAAnonUnpack;
    (void)(void*)PLGNDecryptJWE;
    (void)(void*)PLGNDecryptEncryptedCredential;
    (void)(void*)PLGNVerifyProof;
}
