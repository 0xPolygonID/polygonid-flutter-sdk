const AUTH_CLAIM_SCHEMA = "cca3371a6cb1b715004407e325bd993c";
const API_VERSION = 'v1';
const CHANNEL_NAME = 'technology.polygon.polygonid_flutter_sdk';
// TODO Change depending on new identity and auth enabled
var DEFAULT_AUTH_CLAIM_NONCE = '15930428023331155902';

/// Database
const databaseName = "polygonIdSdk.db";
//const sembastCodecName = "sembastCodec";

/// Key value Database
const keyValueStoreName = "keyValueStore";

/// Identity Database
const identityStoreName = "identityStore";
const identityDatabaseName = "polygonIdSdkIdentity";
const identityDatabasePrefix = "polygonIdSdkIdentity-";

/// Identity state
const identityStateStoreName = "identityStateStore";

/// Identity state trees
const claimsTreeStoreName = "claimsTreeStore";
const revocationTreeStoreName = "revocationTreeStore";
const rootsTreeStoreName = "rootsTreeStore";

/// Credential
const claimStoreName = "claimStore";

/// Iden3comm
const interactionStoreName = "interactionStore";

/// DID profile info
const didProfileInfoStoreName = "didProfileInfoStore";

/// profiles store
const profilesStoreName = "profilesStore";
