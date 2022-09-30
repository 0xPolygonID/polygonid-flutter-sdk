// NOTE: Append the lines below to ios/Classes/<your>Plugin.h

extern char *pack_signature(const char *signature);

extern char *unpack_signature(const char *compressed_signature);

extern char *pack_point(const char *point_x, const char *point_y);

extern char *unpack_point(const char *compressed_point);

extern char *prv2pub(const char *private_key);

extern char *poseidon_hash(const char *input);

extern char *hash_poseidon(const char *claims_tree,
                    const char *revocation_tree,
                    const char *roots_tree_root);

extern char *sign_poseidon(const char *private_key, const char *msg);

extern char *verify_poseidon(const char *private_key,
                      const char *compressed_signature,
                      const char *message);

extern void cstring_free(char *str);
