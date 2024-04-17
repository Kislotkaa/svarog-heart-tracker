import 'package:url_launcher/url_launcher.dart';

void goToUrl(String url) {
  launchUrl(Uri.parse(url));
}
