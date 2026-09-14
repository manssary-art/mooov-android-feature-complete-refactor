import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:generated_assets/generated_assets.dart';

import '../../../../models/places_auto_complete_model.dart';
import '../../../../models/places_details_model.dart';

class AddressPickerScreen extends HookWidget {
  final ValueSetter<PlacesDetailsModel?> onValuePicked;

  final Future<Result<List<PlacesAutoCompleteModel>>> Function({
    required String input,
    Country? country,
  }) getPlacesAutoComplete;

  final Future<Result<PlacesDetailsModel>> Function({
    required String placeId,
  }) getPlacesDetailsByPlaceId;

  const AddressPickerScreen({
    super.key,
    required this.onValuePicked,
    required this.getPlacesAutoComplete,
    required this.getPlacesDetailsByPlaceId,
  });

  @override
  Widget build(BuildContext context) {
    final autocomplete = useState(<PlacesAutoCompleteModel>[]);
    final isWorking = useState(false);
    final fetchingCount = useState(0);
    final timer = useValueNotifier<Timer?>(null);
    final shouldFetchDetails = useState(false);
    final controller = useTextEditingController();
    final editValue = useValueListenable(controller);

    useValueChanged<String, void>(editValue.text, (_, __) {
      final inputValue = editValue.text;
      if (inputValue.length < 3) return;
      timer.value?.cancel();
      timer.value = Timer(const Duration(milliseconds: 500), () async {
        fetchingCount.value = fetchingCount.value + 1;
        getPlacesAutoComplete(input: inputValue).onValue((value) {
          if (editValue.text != inputValue) return;
          autocomplete.value = value;
        }).onFinally(() {
          fetchingCount.value = fetchingCount.value - 1;
        });
      });
    });

    final onAutoCompleteClicked =
        useCallback((PlacesAutoCompleteModel value) async {
      if (!shouldFetchDetails.value) {
        controller.text = value.mainText ?? value.description;
        controller.selection =
            TextSelection.collapsed(offset: controller.text.length);
        shouldFetchDetails.value = true;
        return;
      }

      try {
        isWorking.value = true;
        await getPlacesDetailsByPlaceId(placeId: value.placeId!)
            .onValue(onValuePicked);
      } finally {
        isWorking.value = false;
      }
    }, [onValuePicked]);

    return LoadingOverlay(
      isVisible: isWorking.value,
      child: _AddressPickerScreenContent(
        controller: controller,
        autocomplete: autocomplete.value,
        isLoading: fetchingCount.value > 0,
        onAutoCompleteClicked: onAutoCompleteClicked,
      ),
    );
  }
}

class _AddressPickerScreenContent extends HookWidget {
  final TextEditingController controller;
  final List<PlacesAutoCompleteModel> autocomplete;
  final bool isLoading;
  final void Function(PlacesAutoCompleteModel value) onAutoCompleteClicked;

  const _AddressPickerScreenContent({
    super.key,
    required this.controller,
    required this.autocomplete,
    required this.isLoading,
    required this.onAutoCompleteClicked,
  });

  @override
  Widget build(BuildContext context) {
    final inputFocusNode = useFocusNode();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  controller: controller,
                  focusNode: inputFocusNode,
                  autofocus: true,
                  initialValue: null,
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    hintMaxLines: 1,
                    hintText: LocaleKeys.SearchAddress.tr(),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  maxLines: 1,
                  name: '_AddressPickerScreenContent.input',
                ),
              ),
              Container(width: 16),
              SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    AnimatedOpacity(
                      opacity: isLoading ? 0 : 1,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(Icons.search),
                    ),
                    AnimatedOpacity(
                      opacity: isLoading ? 1 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const LoadingIndicator(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: autocomplete.length,
              itemBuilder: (context, index) {
                final item = autocomplete[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Clickable(
                      onTap: () {
                        onAutoCompleteClicked(item);
                        inputFocusNode.requestFocus();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(item.description),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
