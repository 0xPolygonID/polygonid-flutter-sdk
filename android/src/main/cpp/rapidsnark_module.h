#ifndef ANDROID_CMAKE_RAPIDSNARK_MODULE_H
#define ANDROID_CMAKE_RAPIDSNARK_MODULE_H

#include <jni.h>
#include <sys/mman.h>
#include <android/log.h>
//#include "libpolygonid.h"
#include "prover.h"
#include "verifier.h"

extern "C" {

JNIEXPORT jint JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_groth16Prove(
        JNIEnv *env, jobject obj,
        jbyteArray zkeyBuffer, jlong zkeySize,
        jbyteArray wtnsBuffer, jlong wtnsSize,
        jbyteArray proofBuffer, jlongArray proofSize,
        jbyteArray publicBuffer, jlongArray publicSize,
        jbyteArray errorMsg, jlong errorMsgMaxSize
);

JNIEXPORT jint JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_groth16ProveWithZKeyFilePath(
        JNIEnv *env, jobject obj,
        jstring zkeyPath,
        jbyteArray wtnsBuffer, jlong wtnsSize,
        jbyteArray proofBuffer, jlongArray proofSize,
        jbyteArray publicBuffer, jlongArray publicSize,
        jbyteArray errorMsg, jlong errorMsgMaxSize
);

JNIEXPORT jint JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_groth16Verify(
        JNIEnv *env, jobject obj,
        jstring proof, jstring inputs, jstring verificationKey,
        jbyteArray errorMsg, jlong errorMsgMaxSize
);

JNIEXPORT jlong JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_groth16PublicSizeForZkeyBuf(
        JNIEnv *env, jobject obj,
        jbyteArray zkeyBuffer, jlong zkeySize,
        jbyteArray errorMsg, jlong errorMsgMaxSize
);

JNIEXPORT jlong JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_groth16PublicSizeForZkeyFile(
        JNIEnv *env, jobject obj,
        jstring zkeyPath,
        jbyteArray errorMsg, jlong errorMsgMaxSize
);

JNIEXPORT jstring JNICALL Java_io_iden3_polygonid_1flutter_1sdk_RapidsnarkJniBridge_PLGNAuthV2InputsMarshal(
        JNIEnv *env, jobject obj,
        jstring input,
        jbyteArray response,
        jbyteArray errorMsg
);

}

#endif //ANDROID_CMAKE_RAPIDSNARK_MODULE_H




