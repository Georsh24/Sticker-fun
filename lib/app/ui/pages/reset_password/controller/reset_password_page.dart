import 'package:flutter/material.dart';


import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_stickers_internet/app/domain/responses/reset_passord_response.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/custom_input_field.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:flutter_stickers_internet/app/ui/global_widgets/dialogs/progres_dialog.dart';
import 'package:flutter_stickers_internet/app/ui/pages/reset_password/controller/reset_password_controller.dart';
import 'package:flutter_stickers_internet/app/utils/email_validator.dart';



final resetPasswordProvider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomInputField(
                      label: "Email",
                      onChanged: controller.onEmailChange,
                      inputType: TextInputType.emailAddress,  prefixIcon: Icons.alternate_email_sharp,
                    ),
                    ElevatedButton(
                      onPressed: () => _submit(context),
                      child: const Text('Send'),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _submit(BuildContext context) async {
    final controller = resetPasswordProvider.read;
    if (isValidEmail(controller.email)) {
      ProgressDialog.show(context);
      final response = await controller.submit();
      Navigator.pop(context);
      if (response == ResetPasswordResponse.ok) {
        Dialogs.alert(context, title: "Good", content: "Email Send");
      } else {
        String errorMessage = "";
        switch (response) {
          case ResetPasswordResponse.networkRequestFailed:
            errorMessage = "Network RequestFailed";
            break;
          case ResetPasswordResponse.userDisabled:
            errorMessage = "User Disabled";
            break;
          case ResetPasswordResponse.userNotFound:
            errorMessage = "User Not Found";
            break;
          case ResetPasswordResponse.tooManyRequest:
            errorMessage = "Too Many Request";
            break;
          case ResetPasswordResponse.unknown:
          default:
            errorMessage = "unknown error";
            break;
        }
        Dialogs.alert(context, title: "Error", content: errorMessage);
      }
    } else {
      Dialogs.alert(context, content: "invalid email");
    }
  }
}
