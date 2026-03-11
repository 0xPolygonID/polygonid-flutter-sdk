#include <jni.h>
#include <string>
#include <stdlib.h>
#include <dlfcn.h>
#include <android/log.h>
#include "../jniLibs/libpolygonid.h"

#define LOG_TAG "PolygonIdJNI"
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)

// Function pointer types for the C library functions
typedef GoUint8 (*PLGNVerifyAuthResponseFunc)(char**, char*, char*, PLGNStatus**);
typedef void (*PLGNFreeStatusFunc)(PLGNStatus*);

// Global function pointers
static PLGNVerifyAuthResponseFunc g_PLGNVerifyAuthResponse = nullptr;
static PLGNFreeStatusFunc g_PLGNFreeStatus = nullptr;

// Load the function pointers from libpolygonid.so
static bool loadLibraryFunctions() {
    if (g_PLGNVerifyAuthResponse != nullptr && g_PLGNFreeStatus != nullptr) {
        return true; // Already loaded
    }

    // Open libpolygonid.so explicitly
    // RTLD_NOW | RTLD_GLOBAL makes symbols available for later symbol resolution
    void* handle = dlopen("libpolygonid.so", RTLD_NOW | RTLD_GLOBAL);
    if (handle == nullptr) {
        LOGE("Failed to dlopen libpolygonid.so: %s", dlerror());
        return false;
    }

    LOGI("Successfully opened libpolygonid.so");

    g_PLGNVerifyAuthResponse = (PLGNVerifyAuthResponseFunc)dlsym(handle, "PLGNVerifyAuthResponse");
    if (g_PLGNVerifyAuthResponse == nullptr) {
        LOGE("Failed to find PLGNVerifyAuthResponse: %s", dlerror());
        dlclose(handle);
        return false;
    }

    g_PLGNFreeStatus = (PLGNFreeStatusFunc)dlsym(handle, "PLGNFreeStatus");
    if (g_PLGNFreeStatus == nullptr) {
        LOGE("Failed to find PLGNFreeStatus: %s", dlerror());
        dlclose(handle);
        return false;
    }

    LOGI("Successfully loaded libpolygonid.so functions");
    // Don't close the handle - we need to keep the library loaded
    return true;
}

extern "C" {

JNIEXPORT jstring JNICALL
Java_io_iden3_polygonid_1flutter_1sdk_PolygonIdSdkPlugin_nativeVerifyAuthResponse(
        JNIEnv *env,
        jobject /* this */,
        jstring inParam,
        jstring cfg) {

    // Load library functions if not already loaded
    if (!loadLibraryFunctions()) {
        jclass exceptionClass = env->FindClass("java/lang/Exception");
        env->ThrowNew(exceptionClass, "Failed to load libpolygonid.so functions");
        return nullptr;
    }

    // Convert Java strings to C strings
    const char *inCStr = env->GetStringUTFChars(inParam, nullptr);
    const char *cfgCStr = env->GetStringUTFChars(cfg, nullptr);

    // Make mutable copies for the C function
    char *inCopy = strdup(inCStr);
    char *cfgCopy = strdup(cfgCStr);

    // Release Java string references
    env->ReleaseStringUTFChars(inParam, inCStr);
    env->ReleaseStringUTFChars(cfg, cfgCStr);

    // Prepare output parameters
    char *jsonResponse = nullptr;
    PLGNStatus *status = nullptr;

    // Call the C library function via function pointer
    g_PLGNVerifyAuthResponse(&jsonResponse, inCopy, cfgCopy, &status);

    // Clean up input copies
    free(inCopy);
    free(cfgCopy);

    // Check for errors
    if (status != nullptr) {
        // Extract error message
        std::string errorMsg = "Unknown error";
        if (status->error_msg != nullptr) {
            errorMsg = std::string(status->error_msg);
        }

        // Free status
        g_PLGNFreeStatus(status);

        // Free response if allocated
        if (jsonResponse != nullptr) {
            free(jsonResponse);
        }

        // Throw exception back to Java
        jclass exceptionClass = env->FindClass("java/lang/Exception");
        env->ThrowNew(exceptionClass, errorMsg.c_str());
        return nullptr;
    }

    // Success - convert response to Java string
    jstring result = nullptr;
    if (jsonResponse != nullptr) {
        result = env->NewStringUTF(jsonResponse);
        free(jsonResponse);
    } else {
        result = env->NewStringUTF("");
    }

    return result;
}

} // extern "C"

