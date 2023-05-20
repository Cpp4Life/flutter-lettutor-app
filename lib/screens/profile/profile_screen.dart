import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../constants/index.dart';
import '../../core/assets/index.dart';
import '../../core/styles/index.dart';
import '../../helpers/index.dart';
import '../../models/index.dart' as model;
import '../../providers/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final List<model.LearnTopic> _allTopics = [];
  final List<model.TestPreparation> _allTests = [];
  final FocusNode _nameFocusNode = FocusNode();
  final List<DropdownMenuItem<String>> _countriesList = [];
  final List<DropdownMenuItem<String>> _levelsList = [];
  model.User _user = model.User(
    id: '',
    name: '',
    email: '',
    birthday: null,
    phone: '',
    isPhoneActivated: false,
    country: null,
    level: null,
    learnTopics: [],
    testPreparations: [],
  );
  bool _isInit = true;
  late model.Language _lang;
  DateTime _birthday = DateTime.now();

  @override
  void initState() {
    _lang = Provider.of<AppProvider>(context, listen: false).language;
    _initData();
    super.initState();
  }

  void _initData() {
    _nameFocusNode.addListener(_updateName);
    _countriesList.insert(
        0, DropdownMenuItem(value: 'UN', child: Text(_lang.countryHint)));
    _levelsList.insert(0, DropdownMenuItem(value: 'UN', child: Text(_lang.levelHint)));
    _countriesList.addAll(countries.entries
        .map((item) => DropdownMenuItem(
              value: item.key,
              child: Text(item.value),
            ))
        .toList());
    _levelsList.addAll(levels.entries
        .map(
          (item) => DropdownMenuItem(
            value: item.key,
            child: Text(item.value),
          ),
        )
        .toList());
  }

  void _updateName() {
    if (!_nameFocusNode.hasFocus) {
      setState(() {
        _user.name = _nameCtrl.text;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<UserProvider>(context, listen: false).getUserInfo().then((value) {
        setState(() {
          _user = value;
          _nameCtrl.text = _user.name ?? '';
          _phoneCtrl.text = _user.phone ?? '';
          _birthday =
              _user.birthday != null ? DateTime.parse(_user.birthday!) : DateTime.now();
        });
      });
      Provider.of<LearnTopicProvider>(context, listen: false)
          .fetchAndSetLearnTopics()
          .then((value) {
        setState(() {
          _allTopics.addAll(value);
        });
      });
      Provider.of<TestPreparationProvider>(context, listen: false)
          .fetchAndSetTests()
          .then((value) {
        setState(() {
          _allTests.addAll(value);
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _nameFocusNode.removeListener(_updateName);
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('PROFILE_SCREEN');
    void onSave() async {
      if (!mounted) {
        return;
      }
      try {
        if (_nameCtrl.text.isEmpty) {
          TopSnackBar.showError(context, 'Username cannot be empty!');
          return;
        }

        if (_phoneCtrl.text.isEmpty) {
          TopSnackBar.showError(context, 'Phone number cannot be empty!');
          return;
        }

        if (!RegEx.isValidPhone(_phoneCtrl.text)) {
          TopSnackBar.showError(context, 'Enter a valid phone number!');
          return;
        }

        await Provider.of<UserProvider>(context, listen: false).updateUserInfo(
          name: _nameCtrl.text,
          country: _user.country,
          birthday: _user.birthday,
          level: _user.level,
          phone: _phoneCtrl.text,
          learnTopics: _user.learnTopics!.map((e) => e.id.toString()).toList(),
          testPreparations: _user.testPreparations!.map((e) => e.id.toString()).toList(),
          callback: () =>
              TopSnackBar.showSuccess(context, 'Successfully updated profile! Oh-hoo~~'),
        );
      } on model.HttpException catch (e) {
        TopSnackBar.showError(context, e.toString());
        await Analytics.crashEvent(
          'onSave',
          exception: e.toString(),
        );
      } catch (error) {
        debugPrint(error.toString());
        TopSnackBar.showError(
            context, 'Failed to update user\'s profile! Please try again later');
        await Analytics.crashEvent(
          'onSave',
          exception: error.toString(),
        );
      }
    }

    void pickImageFromGallery() async {
      final picker = ImagePicker();
      final imageFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (imageFile == null) {
        return;
      }
      if (!mounted) {
        return;
      }
      try {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final fileName = path.basename(imageFile.path);
        await userProvider.uploadAvatar(
          imageFile.path,
          fileName,
          () => TopSnackBar.showSuccess(context, 'Successfully updated avatar! Oh-hoo~~'),
        );
        userProvider.getUserInfo().then((value) {
          setState(() {
            _user = value;
            _nameCtrl.text = _user.name ?? '';
            _phoneCtrl.text = _user.phone ?? '';
          });
        });
      } on model.HttpException catch (e) {
        TopSnackBar.showError(context, e.toString());
        await Analytics.crashEvent(
          'pickImageFromGallery',
          exception: e.toString(),
        );
      } catch (error) {
        debugPrint(error.toString());
        TopSnackBar.showError(
            context, 'Failed to update your avatar! Please try again later');
        await Analytics.crashEvent(
          'pickImageFromGallery',
          exception: error.toString(),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(_lang.profileTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      margin: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: _user.avatar ?? 'https://picsum.photos/200/300',
                          fit: BoxFit.cover,
                          width: 75,
                          height: 75,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Image.asset(
                            LetTutorImages.avatar,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 0,
                      child: GestureDetector(
                        onTap: pickImageFromGallery,
                        child: CircleAvatar(
                          backgroundColor: LetTutorColors.greyScaleDarkGrey,
                          radius: 10,
                          child: SvgPicture.asset(
                            LetTutorSvg.camera,
                            width: 15,
                            height: 15,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _nameCtrl,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    focusNode: _nameFocusNode,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: LetTutorColors.greyScaleMediumGrey,
                      ),
                    ),
                    style: const TextStyle(fontSize: LetTutorFontSizes.px14),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  child: Text(
                    _user.email as String,
                    style: const TextStyle(
                      color: LetTutorColors.greyScaleDarkGrey,
                      fontWeight: LetTutorFontWeights.medium,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(_lang.birthday),
                ),
                Container(
                  height: 48,
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    border: Border.all(color: LetTutorColors.greyScaleLightGrey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 110,
                    margin: const EdgeInsets.all(5),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerRight,
                        backgroundColor: LetTutorColors.greyScaleLightGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        BottomModalSheet.show(
                          context: context,
                          title: _lang.birthday,
                          widget: ScrollDatePicker(
                            selectedDate: _birthday,
                            minimumDate: DateTime(1950, 1, 1),
                            maximumDate: DateTime(2030, 12, 31),
                            locale: Locale(_lang.locale.name),
                            options: const DatePickerOptions(
                              itemExtent: 40.0,
                              isLoop: false,
                            ),
                            scrollViewOptions: const DatePickerScrollViewOptions(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                            onDateTimeChanged: (DateTime value) {
                              setState(() {
                                _birthday = value;
                                _user.birthday =
                                    DateFormat('yyyy-MM-dd').format(_birthday);
                              });
                            },
                          ),
                        );
                      },
                      child: Text(
                        DateFormat('d MMM yyyy').format(
                          _user.birthday != null
                              ? DateTime.parse(_user.birthday!)
                              : DateTime.now(),
                        ),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: LetTutorFontSizes.px14,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(_lang.phone),
                      ),
                      TextField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        enabled: _user.isPhoneActivated == null
                            ? true
                            : !_user.isPhoneActivated!,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: _lang.phoneHint,
                          hintStyle: const TextStyle(
                            color: LetTutorColors.greyScaleMediumGrey,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: LetTutorColors.greyScaleLightGrey),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: LetTutorColors.greyScaleLightGrey),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: LetTutorColors.greyScaleLightGrey),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: const TextStyle(fontSize: LetTutorFontSizes.px14),
                      ),
                    ],
                  ),
                ),
                dropdownItems(
                  title: _lang.country,
                  items: _countriesList,
                  value: _user.country ?? 'UN',
                  onChanged: (String? val) {
                    if (val != 'UN') {
                      setState(() {
                        _user.country = val;
                      });
                    }
                  },
                ),
                dropdownItems(
                  title: _lang.level,
                  items: _levelsList,
                  value: _user.level ?? 'UN',
                  onChanged: (String? val) {
                    if (val != 'UN') {
                      setState(() {
                        _user.level = val;
                      });
                    }
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(_lang.wantToLearn),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 2, left: 5),
                              child: const Text(
                                'Subject',
                                style: TextStyle(
                                  fontSize: LetTutorFontSizes.px14,
                                ),
                              ),
                            ),
                            skillsAndLevels<model.LearnTopic>(
                              allTypes: _allTopics,
                              userTypes: _user.learnTopics!,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 2, top: 10, left: 5),
                              child: const Text(
                                'Test Preparation',
                                style: TextStyle(
                                  fontSize: LetTutorFontSizes.px14,
                                ),
                              ),
                            ),
                            skillsAndLevels<model.TestPreparation>(
                              allTypes: _allTests,
                              userTypes: _user.testPreparations!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSave,
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      padding: const EdgeInsets.all(10),
                      backgroundColor: LetTutorColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: LetTutorFontWeights.medium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropdownItems({
    required String title,
    required List<DropdownMenuItem<String>>? items,
    required String value,
    required Function(String?) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(title),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: LetTutorColors.greyScaleLightGrey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              menuMaxHeight: 300,
              style: const TextStyle(
                fontSize: LetTutorFontSizes.px14,
                color: Colors.black,
              ),
              elevation: 8,
              decoration: const InputDecoration(border: InputBorder.none),
              value: value,
              isExpanded: true,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget skillsAndLevels<T>({
    required List<T> allTypes,
    required List<T> userTypes,
  }) {
    return SizedBox(
      child: Wrap(
        children: allTypes.map<Widget>(
          (type) {
            final selected =
                userTypes.any((t) => (t as dynamic).id == (type as dynamic).id);
            return GestureDetector(
              onTap: () {
                final index =
                    userTypes.indexWhere((element) => (element as dynamic).id == type.id);
                index != -1
                    ? setState(() {
                        userTypes.removeAt(index);
                      })
                    : setState(() {
                        userTypes.add(type);
                      });
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: selected ? Colors.blue[100] : LetTutorColors.paleGrey,
                ),
                child: selected
                    ? Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              (type as dynamic).name,
                              style: const TextStyle(
                                fontSize: LetTutorFontSizes.px12,
                                color: LetTutorColors.primaryBlue,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.done_rounded,
                            color: LetTutorColors.primaryBlue,
                            size: LetTutorFontSizes.px16,
                          ),
                        ],
                      )
                    : Text(
                        (type as dynamic).name as String,
                        style: const TextStyle(
                          fontSize: LetTutorFontSizes.px12,
                        ),
                      ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
