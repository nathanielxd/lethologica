part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.lastDeleted,
  });

  final Word lastDeleted;

  @override
  List<Object?> get props => [lastDeleted];
}
