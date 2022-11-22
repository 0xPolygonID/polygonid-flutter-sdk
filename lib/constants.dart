const POLYGONID_ACCESS_MESSAGE =
    'PrivadoId account access.\n\nSign this message if you are in a trusted application only.';
const API_VERSION = 'v1';

const STORAGE_VERSION_KEY = 'privadoIdStorageVersion';
const STORAGE_VERSION = 1;

///
/// Database
const databaseName = "polygonIdSdk.db";
const identityStoreName = "identityStore";

///
/// Identity Database
const identityDatabaseName = "polygonIdSdkIdentity";
const identityDatabasePrefix = "polygonIdSdkIdentity-";

/// Identity
const claimsTreeStoreName = "claimsTreeStore";
const revocationTreeStoreName = "revocationTreeStore";
const rootsTreeStoreName = "rootsTreeStore";

/// Credential
const claimStoreName = "claimStore";
