#import <Flutter/Flutter.h>

@interface PrivadoidPlugin : NSObject<FlutterPlugin>
@end

// NOTE: Append the lines below to ios/Classes/<your>Plugin.h

char *pack_signature(const char *signature);

char *unpack_signature(const char *compressed_signature);

char *pack_point(const char *point_x, const char *point_y);

char *unpack_point(const char *compressed_point);

char *prv2pub(const char *private_key);

char *hash_poseidon(const char *claims_tree,
                    const char *revocation_tree,
                    const char *roots_tree_root);

char *sign_poseidon(const char *private_key, const char *msg);

char *verify_poseidon(const char *private_key,
                      const char *compressed_signature,
                      const char *message);

void cstring_free(char *str);