#include "rapidsnark_module.h"

#define TAG "RapidsnarkExampleNative"
#define LOGI(...) __android_log_print(ANDROID_LOG_ERROR, TAG, __VA_ARGS__)

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT jint JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_groth16Prove(
        JNIEnv *env, jobject obj,
        jbyteArray zkeyBuffer, jlong zkeySize,
        jbyteArray wtnsBuffer, jlong wtnsSize,
        jbyteArray proofBuffer, jlongArray proofSize,
        jbyteArray publicBuffer, jlongArray publicSize,
        jbyteArray errorMsg, jlong errorMsgMaxSize
) {
    LOGI("groth16Prover native called");

    // Convert jbyteArray to native types
    void *nativeZkeyBuffer = env->GetByteArrayElements(zkeyBuffer, nullptr);
    void *nativeWtnsBuffer = env->GetByteArrayElements(wtnsBuffer, nullptr);

    char *nativeProofBuffer = (char *) env->GetByteArrayElements(proofBuffer, nullptr);
    char *nativePublicBuffer = (char *) env->GetByteArrayElements(publicBuffer, nullptr);
    char *nativeErrorMsg = (char *) env->GetByteArrayElements(errorMsg, nullptr);

    jlong *nativeProofSizeArr = env->GetLongArrayElements(proofSize, 0);
    jlong *nativePublicSizeArr = env->GetLongArrayElements(publicSize, 0);

    unsigned long nativeProofSize = nativeProofSizeArr[0];
    unsigned long nativePublicSize = nativePublicSizeArr[0];

    // Call the groth16_prover function
    int result = groth16_prover(
            nativeZkeyBuffer, zkeySize,
            nativeWtnsBuffer, wtnsSize,
            nativeProofBuffer, &nativeProofSize,
            nativePublicBuffer, &nativePublicSize,
            nativeErrorMsg, errorMsgMaxSize
    );

    // Convert the results back to JNI types
    nativeProofSizeArr[0] = nativeProofSize;
    nativePublicSizeArr[0] = nativePublicSize;

    env->SetLongArrayRegion(proofSize, 0, 1, (jlong *) nativeProofSizeArr);
    env->SetLongArrayRegion(publicSize, 0, 1, (jlong *) nativePublicSizeArr);

    // Release the native buffers
    env->ReleaseByteArrayElements(zkeyBuffer, (jbyte *) nativeZkeyBuffer, 0);
    env->ReleaseByteArrayElements(wtnsBuffer, (jbyte *) nativeWtnsBuffer, 0);
    env->ReleaseByteArrayElements(proofBuffer, (jbyte *) nativeProofBuffer, 0);
    env->ReleaseByteArrayElements(publicBuffer, (jbyte *) nativePublicBuffer, 0);
    env->ReleaseByteArrayElements(errorMsg, (jbyte *) nativeErrorMsg, 0);

    env->ReleaseLongArrayElements(proofSize, (jlong *) nativeProofSizeArr, 0);
    env->ReleaseLongArrayElements(publicSize, (jlong *) nativePublicSizeArr, 0);

    return result;
}

JNIEXPORT jint JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_groth16ProveWithZKeyFilePath(
        JNIEnv *env, jobject obj,
        jstring zkeyPath,
        jbyteArray wtnsBuffer, jlong wtnsSize,
        jbyteArray proofBuffer, jlongArray proofSize,
        jbyteArray publicBuffer, jlongArray publicSize,
        jbyteArray errorMsg, jlong errorMsgMaxSize
) {
    LOGI("groth16ProverZkeyFile native called");

    // Convert jbyteArray to native types
    const char *nativeZkeyPath = env->GetStringUTFChars(zkeyPath, nullptr);

    void *nativeWtnsBuffer = env->GetByteArrayElements(wtnsBuffer, nullptr);

    char *nativeProofBuffer = (char *) env->GetByteArrayElements(proofBuffer, nullptr);
    char *nativePublicBuffer = (char *) env->GetByteArrayElements(publicBuffer, nullptr);
    char *nativeErrorMsg = (char *) env->GetByteArrayElements(errorMsg, nullptr);

    jlong *nativeProofSizeArr = env->GetLongArrayElements(proofSize, 0);
    jlong *nativePublicSizeArr = env->GetLongArrayElements(publicSize, 0);

    unsigned long nativeProofSize = nativeProofSizeArr[0];
    unsigned long nativePublicSize = nativePublicSizeArr[0];

    // Call the groth16_prover function`
    int status_code = groth16_prover_zkey_file(
            nativeZkeyPath,
            nativeWtnsBuffer, wtnsSize,
            nativeProofBuffer, &nativeProofSize,
            nativePublicBuffer, &nativePublicSize,
            nativeErrorMsg, errorMsgMaxSize
    );

    // Convert the results back to JNI types
    nativeProofSizeArr[0] = nativeProofSize;
    nativePublicSizeArr[0] = nativePublicSize;

    env->SetLongArrayRegion(proofSize, 0, 1, (jlong *) nativeProofSizeArr);
    env->SetLongArrayRegion(publicSize, 0, 1, (jlong *) nativePublicSizeArr);

    // Release the native buffers
    env->ReleaseByteArrayElements(wtnsBuffer, (jbyte *) nativeWtnsBuffer, 0);
    env->ReleaseByteArrayElements(proofBuffer, (jbyte *) nativeProofBuffer, 0);
    env->ReleaseByteArrayElements(publicBuffer, (jbyte *) nativePublicBuffer, 0);
    env->ReleaseByteArrayElements(errorMsg, (jbyte *) nativeErrorMsg, 0);

    env->ReleaseLongArrayElements(proofSize, (jlong *) nativeProofSizeArr, 0);
    env->ReleaseLongArrayElements(publicSize, (jlong *) nativePublicSizeArr, 0);

    return status_code;
}

JNIEXPORT jint JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_groth16Verify(
        JNIEnv *env, jobject obj,
        jstring proof, jstring inputs, jstring verificationKey,
        jbyteArray errorMsg, jlong errorMsgMaxSize
) {
    LOGI("groth16Verifier native called");

    // Convert jstring to native types
    const char *nativeInputs = env->GetStringUTFChars(inputs, nullptr);
    const char *nativeProof = env->GetStringUTFChars(proof, nullptr);
    const char *nativeVerificationKey = env->GetStringUTFChars(verificationKey, nullptr);

    char *nativeErrorMsg = (char *) env->GetByteArrayElements(errorMsg, nullptr);

    // Call the groth16_verify function
    int status_code = groth16_verify(
            nativeProof,
            nativeInputs,
            nativeVerificationKey,
            nativeErrorMsg, errorMsgMaxSize
    );

    // Release the native buffers
    env->ReleaseStringUTFChars(inputs, nativeInputs);
    env->ReleaseStringUTFChars(proof, nativeProof);
    env->ReleaseStringUTFChars(verificationKey, nativeVerificationKey);

    env->ReleaseByteArrayElements(errorMsg, (jbyte *) nativeErrorMsg, 0);

    return status_code;
}

JNIEXPORT jlong JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_groth16PublicSizeForZkeyBuf(
        JNIEnv *env, jobject obj,
        jbyteArray zkeyBuffer, jlong zkeySize,
        jbyteArray errorMsg, jlong errorMsgMaxSize
) {
    LOGI("groth16_public_size_for_zkey_buf native called");

    void *nativeZkeyBuffer = env->GetByteArrayElements(zkeyBuffer, nullptr);
    char *nativeErrorMsg = (char *) env->GetByteArrayElements(errorMsg, nullptr);

    jlong nativePublicSize = 0;

    // Call the groth16_public_size_for_zkey_buf function
    int status_code = groth16_public_size_for_zkey_buf(
            nativeZkeyBuffer, zkeySize,
            (size_t *) &nativePublicSize,
            nativeErrorMsg, errorMsgMaxSize
    );

    LOGI("groth16_public_size_for_zkey_buf:%lu", nativePublicSize);

    // Release the native buffers
    env->ReleaseByteArrayElements(zkeyBuffer, (jbyte *) nativeZkeyBuffer, 0);
    env->ReleaseByteArrayElements(errorMsg, (jbyte *) nativeErrorMsg, 0);

    return nativePublicSize;
}

JNIEXPORT jlong JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_groth16PublicSizeForZkeyFile(
        JNIEnv *env, jobject obj,
        jstring zkeyPath,
        jbyteArray errorMsg, jlong errorMsgMaxSize
) {
    LOGI("groth16_public_size_for_zkey_file native called");

    const char *nativeZkeyPath = env->GetStringUTFChars(zkeyPath, nullptr);

    char *nativeErrorMsg = (char *) env->GetByteArrayElements(errorMsg, nullptr);

    jlong nativePublicSize = 0;

    // Call the groth16_public_size_for_zkey_file function
    int status_code = groth16_public_size_for_zkey_file(
            nativeZkeyPath,
            (unsigned long *) &nativePublicSize,
            nativeErrorMsg, errorMsgMaxSize
    );

    LOGI("groth16_public_size_for_zkey_file:%lu", nativePublicSize);

    // Release the native buffers
    env->ReleaseStringUTFChars(zkeyPath, nativeZkeyPath);
    env->ReleaseByteArrayElements(errorMsg, (jbyte *) nativeErrorMsg, 0);

    return nativePublicSize;
}

JNIEXPORT jstring JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_PLGNAuthV2InputsMarshal(
        JNIEnv *env, jobject obj,
        jstring input,
        jbyteArray response,
        jbyteArray errorMsg
) {
    LOGI("PLGNAuthV2InputsMarshal native called");

//    const char *constNativeInput = env->GetStringUTFChars(input, nullptr);
//    char *nativeInput = strcpy(new char[strlen(constNativeInput) + 1], constNativeInput);

//    char** responseBuffer = new char*[1];

//    PLGNStatus** status = NULL;

    // Call the PLGNAuthV2InputsMarshal function
//    PLGNAuthV2InputsMarshal(responseBuffer, nativeInput, status);

    // Release the native buffers
//    env->ReleaseStringUTFChars(input, constNativeInput);

    return NULL;
}


#ifdef __cplusplus
}
#endif
