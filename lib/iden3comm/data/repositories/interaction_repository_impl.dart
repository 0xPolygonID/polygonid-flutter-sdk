import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/push_notification_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/secure_storage_interaction_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_id_filter_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/notification_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/interaction_exception.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';

class InteractionRepositoryImpl implements InteractionRepository {
  //final ChannelPushNotificationDataSource _channelPushNotificationDataSource;
  final SecureStorageInteractionDataSource _storageInteractionDataSource;
  final InteractionMapper _interactionMapper;
  final FiltersMapper _filtersMapper;
  final InteractionIdFilterMapper _interactionIdFilterMapper;

  InteractionRepositoryImpl(
    //this._channelPushNotificationDataSource,
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
  Future<InteractionEntity> addInteraction(
      {required InteractionEntity interaction,
      required String genesisDid,
      required String privateKey}) {
    return _storageInteractionDataSource.storeInteractions(
      interactions: [_interactionMapper.mapTo(interaction)],
      did: genesisDid,
      privateKey: privateKey,
    ).then(
        (interactionDTOs) => _interactionMapper.mapFrom(interactionDTOs.first));
  }

  @override
  Future<List<InteractionEntity>> getInteractions(
      {List<FilterEntity>? filters,
      required String genesisDid,
      required String privateKey}) {
    return _storageInteractionDataSource
        .getInteractions(
            filter: filters == null ? null : _filtersMapper.mapTo(filters),
            did: genesisDid,
            privateKey: privateKey)
        .then((interactions) => interactions
            .map((interaction) => _interactionMapper.mapFrom(interaction))
            .toList());
  }

  @override
  Future<InteractionEntity> getInteraction(
      {required String id,
      required String genesisDid,
      required String privateKey}) {
    return _storageInteractionDataSource
        .getInteractions(
            filter: _interactionIdFilterMapper.mapTo(id),
            did: genesisDid,
            privateKey: privateKey)
        .then((interactions) => interactions.isEmpty
            ? throw InteractionNotFoundException(id)
            : _interactionMapper.mapFrom(interactions.first));
  }

  @override
  Future<void> removeInteractions(
      {required List<String> ids,
      required String genesisDid,
      required String privateKey}) {
    return _storageInteractionDataSource.removeInteractions(
      ids: ids,
      did: genesisDid,
      privateKey: privateKey,
    );
  }
}
