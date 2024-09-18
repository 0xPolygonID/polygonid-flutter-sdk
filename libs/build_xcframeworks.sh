# This scripts creates merged library for arm64 only for both sim and ios, and then creates xcframework from it.

# Build libbabyjubjub

rm -rf ./libbabyjubjub/libbabyjubjub.xcframework

xcodebuild -create-xcframework \
-library libbabyjubjub/ios/libbabyjubjub.a \
-headers libbabyjubjub/headers \
-library libbabyjubjub/sim/libbabyjubjub.a \
-headers libbabyjubjub/headers \
-output libbabyjubjub/libbabyjubjub.xcframework \
&& \
cp -rf ./libbabyjubjub/libbabyjubjub.xcframework ../ios/Frameworks

# Build libpolygonid

rm -rf ./libpolygonid/libpolygonid.xcframework

xcodebuild -create-xcframework \
-library libpolygonid/ios/libpolygonid.a \
-headers libpolygonid/headers \
-library libpolygonid/sim/libpolygonid.a \
-headers libpolygonid/headers \
-output libpolygonid/libpolygonid.xcframework \
&& \
cp -rf ./libpolygonid/libpolygonid.xcframework ../ios/Frameworks

# Build libwitness

rm -rf ./libwitness/libwitness.xcframework

xcodebuild -create-xcframework \
-library libwitness/ios/libwitness.a \
-headers libwitness/headers \
-library libwitness/sim/libwitness.a \
-headers libwitness/headers \
-output libwitness/libwitness.xcframework \
&& \
cp -rf ./libwitness/libwitness.xcframework ../ios/Frameworks