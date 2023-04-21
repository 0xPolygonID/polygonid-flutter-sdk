import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/push_notification_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/secure_storage_interaction_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/storage_interaction_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_id_filter_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_base_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/interaction_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';

class InteractionRepositoryImpl implements InteractionRepository {
  //final ChannelPushNotificationDataSource _channelPushNotificationDataSource;
  final SecureStorageInteractionDataSource _secureStorageInteractionDataSource;
  final StorageInteractionDataSource _storageInteractionDataSource;
  final InteractionMapper _interactionMapper;
  final FiltersMapper _filtersMapper;
  final InteractionIdFilterMapper _interactionIdFilterMapper;

  InteractionRepositoryImpl(
    //this._channelPushNotificationDataSource,
    this._secureStorageInteractionDataSource,
    this._storageInteractionDataSource,
    this._interactionMapper,
    this._filtersMapper,
    this._interactionIdFilterMapper,
  );

  /*@override
  Stream<NotificationEntity> get notifications =>
      _channelPushNotificationDataSource.notifications
              .map((event) => _interactionMapper.mapFrom(event))
              .where((interaction) =>
                  interaction.type != InteractionType.connection)
          as Stream<NotificationEntity>;*/

  @override
  Future<InteractionBaseEntity> addInteraction(
      {required InteractionBaseEntity interaction,
      String? genesisDid,
      String? privateKey}) {
    if (genesisDid != null && privateKey != null) {
      return _secureStorageInteractionDataSource.storeInteractions(
        interactions: [_interactionMapper.mapTo(interaction)],
        did: genesisDid,
        privateKey: privateKey,
      ).then((interactionDTOs) =>
          _interactionMapper.mapFrom(interactionDTOs.first));
    } else {
      return _storageInteractionDataSource.storeInteractions(
        interactions: [_interactionMapper.mapTo(interaction)],
      ).then((interactionDTOs) =>
          _interactionMapper.mapFrom(interactionDTOs.first));
    }
  }

  @override
  Future<List<InteractionBaseEntity>> getInteractions(
      {List<FilterEntity>? filters, String? genesisDid, String? privateKey}) {
    if (genesisDid != null && privateKey != null) {
      return _secureStorageInteractionDataSource
          .getInteractions(
              filter: filters == null ? null : _filtersMapper.mapTo(filters),
              did: genesisDid,
              privateKey: privateKey)
          .then((interactions) => interactions
              .map((interaction) => _interactionMapper.mapFrom(interaction))
              .toList());
    } else {
      return _storageInteractionDataSource
          .getInteractions(
              filter: filters == null ? null : _filtersMapper.mapTo(filters))
          .then((interactions) => interactions
              .map((interaction) => _interactionMapper.mapFrom(interaction))
              .toList());
    }
  }

  @override
  Future<InteractionBaseEntity> getInteraction(
      {required String id, String? genesisDid, String? privateKey}) {
    if (genesisDid != null && privateKey != null) {
      return _secureStorageInteractionDataSource
          .getInteractions(
              filter: _interactionIdFilterMapper.mapTo(id),
              did: genesisDid,
              privateKey: privateKey)
          .then((interactions) => interactions.isEmpty
              ? throw InteractionNotFoundException(id)
              : _interactionMapper.mapFrom(interactions.first));
    } else {
      return _storageInteractionDataSource
          .getInteractions(filter: _interactionIdFilterMapper.mapTo(id))
          .then((interactions) => interactions.isEmpty
              ? throw InteractionNotFoundException(id)
              : _interactionMapper.mapFrom(interactions.first));
    }
  }

  @override
  Future<void> removeInteractions(
      {required List<String> ids, String? genesisDid, String? privateKey}) {
    if (genesisDid != null && privateKey != null) {
      return _secureStorageInteractionDataSource.removeInteractions(
        ids: ids,
        did: genesisDid,
        privateKey: privateKey,
      );
    } else {
      return _storageInteractionDataSource.removeInteractions(ids: ids);
    }
  }
}
