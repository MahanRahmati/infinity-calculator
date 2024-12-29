// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dbHash() => r'607062c96b540bd4bafd4b17041403dbbe1b1555';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [db].
@ProviderFor(db)
const dbProvider = DbFamily();

/// See also [db].
class DbFamily extends Family<AsyncValue<Database>> {
  /// See also [db].
  const DbFamily();

  /// See also [db].
  DbProvider call({
    required String dbName,
    required List<String> createStatements,
  }) {
    return DbProvider(
      dbName: dbName,
      createStatements: createStatements,
    );
  }

  @override
  DbProvider getProviderOverride(
    covariant DbProvider provider,
  ) {
    return call(
      dbName: provider.dbName,
      createStatements: provider.createStatements,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dbProvider';
}

/// See also [db].
class DbProvider extends AutoDisposeFutureProvider<Database> {
  /// See also [db].
  DbProvider({
    required String dbName,
    required List<String> createStatements,
  }) : this._internal(
          (ref) => db(
            ref as DbRef,
            dbName: dbName,
            createStatements: createStatements,
          ),
          from: dbProvider,
          name: r'dbProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$dbHash,
          dependencies: DbFamily._dependencies,
          allTransitiveDependencies: DbFamily._allTransitiveDependencies,
          dbName: dbName,
          createStatements: createStatements,
        );

  DbProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dbName,
    required this.createStatements,
  }) : super.internal();

  final String dbName;
  final List<String> createStatements;

  @override
  Override overrideWith(
    FutureOr<Database> Function(DbRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DbProvider._internal(
        (ref) => create(ref as DbRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dbName: dbName,
        createStatements: createStatements,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Database> createElement() {
    return _DbProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DbProvider &&
        other.dbName == dbName &&
        other.createStatements == createStatements;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dbName.hashCode);
    hash = _SystemHash.combine(hash, createStatements.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DbRef on AutoDisposeFutureProviderRef<Database> {
  /// The parameter `dbName` of this provider.
  String get dbName;

  /// The parameter `createStatements` of this provider.
  List<String> get createStatements;
}

class _DbProviderElement extends AutoDisposeFutureProviderElement<Database>
    with DbRef {
  _DbProviderElement(super.provider);

  @override
  String get dbName => (origin as DbProvider).dbName;
  @override
  List<String> get createStatements => (origin as DbProvider).createStatements;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
