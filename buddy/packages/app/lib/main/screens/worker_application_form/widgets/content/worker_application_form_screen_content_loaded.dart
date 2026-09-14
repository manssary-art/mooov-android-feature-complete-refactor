part of 'worker_application_form_screen_content.dart';

class WorkerApplicationFormScreenContentLoaded extends HookWidget {
  final ApplicationStatus status;
  final bool isSubmitButtonEnabled;
  final VoidCallback onNavBackClicked;

  final String firstName;
  final void Function(String) onFirstNameChanged;

  final String lastName;
  final void Function(String) onLastNameChanged;

  final String email;
  final void Function(String) onEmailChanged;

  final String streetAddress;
  final void Function(String) onStreetAddressChanged;

  final String zipCode;
  final void Function(String) onZipCodeChanged;

  final String city;
  final void Function(String) onCityChanged;

  final String vehiclePlate;
  final void Function(String) onVehiclePlateChanged;

  final String iban;
  final void Function(String) onIbanChanged;

  final String companyName;
  final void Function(String) onCompanyNameChanged;

  final String companyAddress;
  final void Function(String) onCompanyAddressChanged;

  final String companyVat;
  final void Function(String) onCompanyVatChanged;

  final bool companyTrafficPermit;
  final void Function(bool) onCompanyTrafficPermitChanged;

  final Country? country;
  final void Function() onCountryClicked;

  final DateTime? birthday;
  final void Function() onBirthdayClicked;

  final (XFile?, String?) idFront;
  final void Function() onIdFrontClicked;

  final (XFile?, String?) idBack;
  final void Function() onIdBackClicked;

  final (XFile?, String?) selfie;
  final void Function() onSelfieClicked;

  final (XFile?, String?) vehicle;
  final void Function() onVehicleClicked;

  final void Function() onSubmitClicked;

  const WorkerApplicationFormScreenContentLoaded({
    super.key,
    required this.onNavBackClicked,
    required this.status,
    required this.isSubmitButtonEnabled,
    required this.firstName,
    required this.onFirstNameChanged,
    required this.lastName,
    required this.onLastNameChanged,
    required this.email,
    required this.onEmailChanged,
    required this.streetAddress,
    required this.onStreetAddressChanged,
    required this.zipCode,
    required this.onZipCodeChanged,
    required this.city,
    required this.onCityChanged,
    required this.vehiclePlate,
    required this.onVehiclePlateChanged,
    required this.iban,
    required this.onIbanChanged,
    required this.companyName,
    required this.onCompanyNameChanged,
    required this.companyAddress,
    required this.onCompanyAddressChanged,
    required this.companyVat,
    required this.onCompanyVatChanged,
    required this.companyTrafficPermit,
    required this.onCompanyTrafficPermitChanged,
    required this.country,
    required this.onCountryClicked,
    required this.birthday,
    required this.onBirthdayClicked,
    required this.idFront,
    required this.onIdFrontClicked,
    required this.idBack,
    required this.onIdBackClicked,
    required this.selfie,
    required this.onSelfieClicked,
    required this.vehicle,
    required this.onVehicleClicked,
    required this.onSubmitClicked,
  });

  @override
  Widget build(BuildContext context) {
    return _WorkerApplicationFormScreenScaffold(
      onNavBackClicked: onNavBackClicked,
      body: SingleChildScrollView(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  ApplicationFormPageStatus(
                    status: status,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildFirstName(context),
                          buildLastName(context),
                          buildEmail(context),
                          buildBirthday(context),
                          buildStreetAddress(context),
                          buildZipCode(context),
                          buildCity(context),
                          buildCountry(context),
                          buildVehiclePlate(context),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: buildIban(context),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildCompanyDisclaimer(context),
                          const SizedBox(height: 8),
                          buildCompanyName(context),
                          buildCompanyVat(context),
                          buildCompanyAddress(context),
                          const SizedBox(height: 8),
                          buildCompanyTrafficPermit(context),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildSelfie(context),
                          const SizedBox(height: 8),
                          buildIdFrontBack(context),
                          const SizedBox(height: 8),
                          buildVehicleImage(context),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: onSubmitClicked.takeIf((it) => isSubmitButtonEnabled),
                    child: Text(LocaleKeys.SubmitUpdate.tr()),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFirstName(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.Firstname.tr(),
      isValid: firstName.isNotEmpty,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        hint: LocaleKeys.Firstname.tr(),
        textCapitalization: TextCapitalization.words,
        value: firstName,
        onValueChanged: onFirstNameChanged,
      ),
    );
  }

  Widget buildLastName(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.Lastname.tr(),
      isValid: lastName.isNotEmpty,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        hint: LocaleKeys.Firstname.tr(),
        textCapitalization: TextCapitalization.words,
        value: lastName,
        onValueChanged: onLastNameChanged,
      ),
    );
  }

  Widget buildEmail(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.Email.tr(),
      isValid: email.isNotEmpty && email.isValidEmail,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        inputFormatters: [
          TextInputFormatter.withFunction(
            (oldValue, newValue) => TextEditingValue(
              text: newValue.text.toLowerCase().replaceAll(' ', ''),
              selection: newValue.selection,
            ),
          )
        ],
        hint: 'hello@mooova.io',
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        value: email,
        onValueChanged: onEmailChanged,
      ),
    );
  }

  static final _dateOfBirthFormatter = DateFormat().addPattern('yyyy-MM-dd');

  Widget buildBirthday(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.DateOfBirth.tr(),
      isValid: birthday != null,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Clickable(
        onTap: onBirthdayClicked,
        child: Text(
          birthday != null ? _dateOfBirthFormatter.format(birthday!) : 'yyyy-mm-dd',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget buildStreetAddress(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.Address.tr(),
      isValid: streetAddress.isNotEmpty,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        hint: LocaleKeys.Address.tr(),
        textCapitalization: TextCapitalization.words,
        value: streetAddress,
        onValueChanged: onStreetAddressChanged,
      ),
    );
  }

  Widget buildZipCode(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.PostalCode.tr(),
      isValid: zipCode.isNotEmpty,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        hint: LocaleKeys.PostalCode.tr(),
        textCapitalization: TextCapitalization.words,
        value: zipCode,
        onValueChanged: onZipCodeChanged,
      ),
    );
  }

  Widget buildCity(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.City.tr(),
      isValid: city.isNotEmpty,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        hint: LocaleKeys.City.tr(),
        textCapitalization: TextCapitalization.words,
        value: city,
        onValueChanged: onCityChanged,
      ),
    );
  }

  Widget buildCountry(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.Country.tr(),
      isValid: country != null,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Clickable(
        onTap: onCountryClicked,
        child: Text(
          country != null ? country!.code : LocaleKeys.Country.tr(),
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget buildVehiclePlate(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.VehiclePlate.tr(),
      isValid: true,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        hint: LocaleKeys.IfYouHaveCar.tr(),
        textCapitalization: TextCapitalization.words,
        value: vehiclePlate,
        onValueChanged: onVehiclePlateChanged,
      ),
    );
  }

  Widget buildIban(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.IBAN.tr(),
      isValid: iban.isNotEmpty && iban.isValidIban,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        hint: LocaleKeys.IBAN.tr(),
        textCapitalization: TextCapitalization.characters,
        value: iban,
        onValueChanged: onIbanChanged,
      ),
    );
  }

  Widget buildCompanyDisclaimer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              LocaleKeys.HaveCompany.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(LocaleKeys.CompanyBenefit.tr()),
        ],
      ),
    );
  }

  Widget buildCompanyName(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.CompanyName.tr(),
      isValid: (companyName.isEmpty && companyVat.isEmpty && companyAddress.isEmpty) || companyName.isNotEmpty,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        hint: LocaleKeys.CompanyName.tr(),
        textCapitalization: TextCapitalization.words,
        value: companyName,
        onValueChanged: onCompanyNameChanged,
      ),
    );
  }

  Widget buildCompanyVat(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.CompanyVAT.tr(),
      isValid: (companyName.isEmpty && companyVat.isEmpty && companyAddress.isEmpty) || companyVat.isNotEmpty,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        hint: LocaleKeys.CompanyVAT.tr(),
        textCapitalization: TextCapitalization.words,
        value: companyVat,
        onValueChanged: onCompanyVatChanged,
      ),
    );
  }

  Widget buildCompanyAddress(BuildContext context) {
    return WorkerApplicationFormInputContainer(
      title: LocaleKeys.CompanyAddress.tr(),
      isValid: (companyName.isEmpty && companyVat.isEmpty && companyAddress.isEmpty) || companyAddress.isNotEmpty,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: WorkerApplicationFormInputField(
        hint: LocaleKeys.CompanyAddress.tr(),
        textCapitalization: TextCapitalization.words,
        value: companyAddress,
        onValueChanged: onCompanyAddressChanged,
      ),
    );
  }

  Widget buildCompanyTrafficPermit(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(LocaleKeys.HaveTrafficPermit.tr()),
          Switch(
            value: companyTrafficPermit,
            activeTrackColor: ColorName.success,
            onChanged: onCompanyTrafficPermitChanged,
          )
        ],
      ),
    );
  }

  Widget buildSelfie(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.TakeASelfie.tr()),
        const SizedBox(height: 8),
        WorkerApplicationFormImageField(
          value: selfie,
          onTap: onSelfieClicked,
          placeholder: Assets.images.imageAddSelfie,
        ),
      ],
    );
  }

  Widget buildIdFrontBack(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.IDPhoto.tr()),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WorkerApplicationFormImageField(
                  value: idFront,
                  onTap: onIdFrontClicked,
                  placeholder: Assets.images.imageAddIdCard,
                ),
                Text(LocaleKeys.Front.tr()),
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WorkerApplicationFormImageField(
                  value: idBack,
                  onTap: onIdBackClicked,
                  placeholder: Assets.images.imageAddIdCard,
                ),
                Text(LocaleKeys.BackSide.tr()),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget buildVehicleImage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.UploadCarPhoto.tr()),
        Container(height: 8),
        WorkerApplicationFormImageField(
          value: vehicle,
          onTap: onVehicleClicked,
          placeholder: Assets.images.imageAddSelfie,
        ),
      ],
    );
  }
}
