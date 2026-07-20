import 'package:equatable/equatable.dart';

/// Base entity class for all domain entities
/// All entities should extend this class to ensure consistency
abstract class BaseEntity extends Equatable {
  const BaseEntity();
}
