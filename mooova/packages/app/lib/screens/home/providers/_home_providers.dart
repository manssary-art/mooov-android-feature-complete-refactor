import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../di/di.dart';
import '../../../../models/geo_point_model.dart';
import '../../../../services/location/location_utils.dart';
import '../../../../services/storage/key_value_storage_local_impl.dart';
import '../../../../core/ext/riverpod_ext.dart';

part 'home_banner_providers.dart';

part 'home_state_providers.dart';

part 'home_user_location_providers.dart';

const _name = 'Home';

final _scope = ProviderScopeContainer();

final placesRepositoryProvider = Provider((ref) => Di.placesRepository);

final locationServiceProvider = Provider((ref) => Di.locationService);

final firebaseDatabaseProvider = Provider((ref) => FirebaseDatabase.instance);
