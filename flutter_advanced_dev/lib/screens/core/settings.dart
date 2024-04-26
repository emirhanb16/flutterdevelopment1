import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/core/localizations.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String camResult = "";
  String locationResult = "";
  String locationAlwaysResult = "";

  controlPermission() async {
    var status = await Permission.camera.status;

    switch (status) {
      case (PermissionStatus.granted):
        setState(() {
          camResult = "Yetki Alindi";
        });
        break;
      case (PermissionStatus.denied):
        setState(() {
          camResult = "Yetki Verme reddedildi";
        });
        break;
      case PermissionStatus.restricted:
        setState(() {
          camResult = "Kisitlanmis yetki.Geri alinmaz";
        });
        break;
      case PermissionStatus.limited:
        setState(() {
          camResult = "Kullanici kisitli yetki secmis";
        });
        break;
      case PermissionStatus.permanentlyDenied:
        setState(() {
          camResult = "Yetki vermesin diye istemis kullanici";
        });
        break;
      case PermissionStatus.provisional:
        setState(() {
          camResult = "Provisional";
        });
        break;
    }

    await Permission.locationAlways.onDeniedCallback(() {
      setState(() {
        locationResult = "Yetki vermeyi reddetti";
      });
    }).onGrantedCallback(() async {
      setState(() {
        locationResult = "Yetki verildi";
      });
      await Permission.camera.onDeniedCallback(() {
        setState(() {
          locationAlwaysResult =
              "Her zaman konum erişim yetki vermeyi reddetti" +
                  status.toString();
        });
      }).onGrantedCallback(() {
        setState(() {
          locationAlwaysResult =
              "Her zaman konum erişim yetki verdi" + status.toString();
        });
      }).onPermanentlyDeniedCallback(() {
        setState(() {
          locationAlwaysResult =
              "Her zaman konum erişim yetki verdi" + status.toString();
        });
      }).onRestrictedCallback(() {
        setState(() {
          locationAlwaysResult =
              "Her zaman konum erişim yetki verdi" + status.toString();
        });
      }).onLimitedCallback(() {
        setState(() {
          locationAlwaysResult =
              "Her zaman konum erişim yetki verdi" + status.toString();
        });
      }).onProvisionalCallback(() {
        setState(() {
          locationAlwaysResult =
              "Her zaman konum erişim yetki verdi" + status.toString();
        });
      }).request();
    }).onPermanentlyDeniedCallback(() {
      setState(() {
        locationResult = "Her zaman için engellendi";
      });
    }).onRestrictedCallback(() {
      setState(() {
        locationResult = "Kisitlanmis ve alinamaz";
      });
    }).onLimitedCallback(() {
      setState(() {
        locationResult = "Kullanici kisitlanmis yetki vermis";
      });
    }).onProvisionalCallback(() {
      setState(() {
        locationResult = "Provisional";
      });
    }).request();
  }

  @override
  void initState() {
    super.initState();
    controlPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).getTranslate("settings"))),
      body: SizedBox.expand(
        child: ListView(
          children: [
            ExpansionTile(title: Text("Camera Permission"), children: [
              Text(camResult),
              Gap(20),
              ElevatedButton(
                onPressed: () async {
                  print("cam perm");
                  final status = await Permission.camera.request();
                },
                child: Text("Yetki iste"),
              ),
            ]),
            ExpansionTile(title: Text("Location Permission"), children: [
              Text(locationResult),
              Divider(),
              Text("Always Status"),
              Text(locationAlwaysResult),
              Gap(20),
              ElevatedButton(
                onPressed: () async {
                  print("loc perm");
                  final status = await Permission.location.request();
                },
                child: Text("Yetki iste"),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
