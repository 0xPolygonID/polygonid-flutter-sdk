/// Both DevEnv and Env must implement all these values
abstract class SdkEnv {
  abstract final String polygonIdAccessMessage;
  abstract final String networkName;
  abstract final String networkEnv;
  abstract final String infuraUrl;
  abstract final String infuraRdpUrl;
  abstract final String infuraApiKey;
  abstract final String reverseHashServiceUrl;
  abstract final String idStateContractAddress;
  abstract final String pushUrl;
}
