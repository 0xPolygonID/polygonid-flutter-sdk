import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/dependency_injection/dependencies_provider.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/sign/sign_bloc.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/sign/sign_event.dart';
import 'package:polygonid_flutter_sdk_example/src/presentation/ui/sign/sign_state.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_button_style.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_text_styles.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_widgets_keys.dart';

class SignWidget extends StatefulWidget {
  final SignBloc _bloc;

  SignWidget({Key? key})
      : _bloc = getIt<SignBloc>(),
        super(key: key);

  @override
  State<SignWidget> createState() => _SignWidgetState();
}

class _SignWidgetState extends State<SignWidget> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSignDescription(),
          _buildForm(),
        ],
      ),
    );
  }

  ///
  Widget _buildSignDescription() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Sign a message',
          style: CustomTextStyles.descriptionTextStyle.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 8),
        const Text(
          'With your identity you can sign a message (only hex or int), returning a unique signature.',
          textAlign: TextAlign.center,
          style: CustomTextStyles.descriptionTextStyle,
        ),
      ],
    );
  }

  ///
  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      key: const Key("form"),
      children: [
        const SizedBox(height: 24),
        _buildMessageField(),
        const SizedBox(height: 8),
        _buildSignMessageButton(),
        const SizedBox(height: 12),
        _buildSignature(),
        const SizedBox(height: 12),
        _buildErrorSection(),
      ],
    );
  }

  ///
  Widget _buildMessageField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        key: _formKey,
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Message',
          labelStyle: CustomTextStyles.descriptionTextStyle,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.primaryButton)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.primaryButton)),
          hintText: '0xFF8247E5',
        ),
        cursorColor: CustomColors.primaryButton,
        style: CustomTextStyles.descriptionTextStyle,
        maxLines: 1,
        minLines: 1,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  ///
  Widget _buildSignMessageButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        key: CustomWidgetsKeys.signScreenButtonSignMessage,
        style: CustomButtonStyle.primaryButtonStyleSmall,
        onPressed: () {
          widget._bloc.add(SignEvent.signMessage(_controller.text));
        },
        child: Text(
          'Sign message',
          style: CustomTextStyles.primaryButtonTextStyle.copyWith(fontSize: 14),
        ),
      ),
    );
  }

  ///
  Widget _buildSignature() {
    return BlocBuilder(
      bloc: widget._bloc,
      builder: (BuildContext context, SignState state) {
        return Text(
          state.signature ?? CustomStrings.signMessageResultPlaceHolder,
          key: const Key('signed_message'),
          style: CustomTextStyles.descriptionTextStyle
              .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
        );
      },
      buildWhen: (previous, currentState) {
        return currentState is LoadedSignState;
      },
    );
  }

  ///
  Widget _buildErrorSection() {
    return BlocBuilder(
      bloc: widget._bloc,
      builder: (BuildContext context, SignState state) {
        if (state is! ErrorSignState) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            state.message,
            style: CustomTextStyles.descriptionTextStyle
                .copyWith(color: CustomColors.redError),
          ),
        );
      },
    );
  }

  ///
  _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: CustomColors.background,
    );
  }
}
