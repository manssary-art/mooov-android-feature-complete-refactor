import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../bootstrap/bootstrap.dart';
import '../models/worker_application_form_status.dart';

class ApplicationFormPageStatus extends StatelessWidget {
  final ApplicationStatus status;

  const ApplicationFormPageStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Bullet(
                color: switch (status) {
                  ApplicationStatus.approved => ColorName.success,
                  ApplicationStatus.submitted => ColorName.warning,
                  ApplicationStatus.notSubmitted => ColorName.warning,
                },
                size: 16,
              ),
              Container(width: 8),
              Text(
                switch (status) {
                  ApplicationStatus.notSubmitted => LocaleKeys.NewApplication.tr(),
                  ApplicationStatus.submitted => LocaleKeys.PendingApplication.tr(),
                  ApplicationStatus.approved => LocaleKeys.ApprovedApplication.tr(),
                },
              ),
            ],
          ),
        ),
        Clickable(
          onTap: () async {
            try {
              await launchUrl(Uri.parse(Env.workerInfoUrl));
            } catch (ignore) {
              // Nothing to do
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            decoration: const BoxDecoration(
              color: ColorName.error,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              LocaleKeys.Info.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
