import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_master_course/src/repository/license_repository.dart';

class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  final LicenseRepository _licenseRepository;
  LicenseBloc(this._licenseRepository) : super(const LicenseState(false)) {
    on<BuyLicenseEvent>((event, emit) async {
      final result = await _licenseRepository.buyLicense();
      emit(LicenseState(result));
    });
  }
}

abstract class LicenseEvent extends Equatable {}

class BuyLicenseEvent extends LicenseEvent {
  @override
  List<Object?> get props => [];
}

class LicenseState extends Equatable {
  final bool hasLicense;
  const LicenseState(this.hasLicense);

  @override
  List<Object?> get props => [hasLicense];
}
