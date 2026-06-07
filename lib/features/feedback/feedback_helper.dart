import 'package:url_launcher/url_launcher.dart';

const _supportEmail = 'support@otejlink.dz';

Future<bool> launchFeedbackEmail({String? eventTitle, String? eventId}) async {
  final subject = eventTitle != null
      ? 'OTEJ Link — Problème : $eventTitle'
      : 'OTEJ Link — Feedback';

  final bodyLines = <String>[
    if (eventTitle != null) 'Événement : $eventTitle',
    if (eventId != null) 'ID : $eventId',
    '',
    '',
  ];

  final uri = Uri(
    scheme: 'mailto',
    path: _supportEmail,
    queryParameters: {'subject': subject, 'body': bodyLines.join('\n')},
  );

  return launchUrl(uri);
}
