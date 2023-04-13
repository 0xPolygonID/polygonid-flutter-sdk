import 'package:polygonid_flutter_sdk/common/data/data_sources/mappers/filters_mapper.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/filter_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/push_notification_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/data_sources/secure_storage_interaction_data_source.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/interaction_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/data/mappers/notification_mapper.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/interaction_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/interaction/notification_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/repositories/interaction_repository.dart';

class InteractionRepositoryImpl implements InteractionRepository {
  final ChannelPushNotificationDataSource _channelPushNotificationDataSource;
  final SecureStorageInteractionDataSource _storageInteractionDataSource;
  final NotificationMapper _notificationMapper;
  final InteractionMapper _interactionMapper;
  final FiltersMapper _filtersMapper;

  InteractionRepositoryImpl(
    this._channelPushNotificationDataSource,
    this._storageInteractionDataSource,
    this._notificationMapper,
    this._interactionMapper,
    this._filtersMapper,
  );

  @override
  Stream<NotificationEntity> get notifications =>
      _channelPushNotificationDataSource.notifications
          .map((event) => _notificationMapper.mapFrom(event));

  @override
  Future<InteractionEntity> storeInteraction(
      {required InteractionEntity interaction,
      required String did,
      required String privateKey}) {
    return _storageInteractionDataSource.storeInteractions(
      interactions: [_interactionMapper.mapTo(interaction)],
      did: did,
      privateKey: privateKey,
    ).then(
        (interactionDTOs) => _interactionMapper.mapFrom(interactionDTOs.first));
  }

  @override
  Future<List<InteractionEntity>> getInteractions(
      {List<FilterEntity>? filters,
      required String did,
      required String privateKey}) {
    return _storageInteractionDataSource
        .getInteractions(
            filter: filters == null ? null : _filtersMapper.mapTo(filters),
            did: did,
            privateKey: privateKey)
        .then((interactions) => interactions
            .map((interaction) => _interactionMapper.mapFrom(interaction))
            .toList());
  }
}
