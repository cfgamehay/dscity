enum Flavor { dev, prod }

class AppConfig {
  final String appName;
  final String baseUrl;
  final String socketUrl;
  final String gRPCHost;
  final String gRPCHostFile;
  final int gRPCPort;
  final int gRPCPortChat;
  final int gRPCPortFile;
  final Flavor flavor;

  AppConfig(
    this.appName,
    this.baseUrl,
    this.socketUrl,
    this.gRPCHost,
    this.gRPCHostFile,
    this.gRPCPort,
    this.gRPCPortChat,
    this.gRPCPortFile,
    this.flavor,
  );

  factory AppConfig.create({
    String appName = '',
    String baseUrl = '',
    String socketUrl = '',
    String gRPCHost = '',
    String gRPCHostFile = '',
    int gRPCPort = 0,
    int gRPCPortChat = 0,
    int gRPCPortFile = 0,
    Flavor flavor = Flavor.dev,
  }) {
    return shared = AppConfig(
      appName,
      baseUrl,
      socketUrl,
      gRPCHost,
      gRPCHostFile,
      gRPCPort,
      gRPCPortChat,
      gRPCPortFile,
      flavor,
    );
  }

  static AppConfig shared = AppConfig.create();
}
