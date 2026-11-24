class PostShareConfig {
  const PostShareConfig._();

  static const String postUrlBase = 'https://YOUR_DOMAIN/post';

  static String postUrl(String recordId) => '$postUrlBase/$recordId';
}
