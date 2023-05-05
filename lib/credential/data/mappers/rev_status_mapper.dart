import 'package:polygonid_flutter_sdk/common/mappers/mapper.dart';
import 'package:polygonid_flutter_sdk/credential/domain/entities/rev_status_entity.dart';
import 'package:polygonid_flutter_sdk/identity/data/dtos/tree_state_dto.dart';
import 'package:polygonid_flutter_sdk/identity/data/mappers/tree_state_mapper.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/tree_state_entity.dart';
import 'package:polygonid_flutter_sdk/proof/data/data_sources/mappers/proof_mapper.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/proof_dto.dart';

class RevStatusMapper extends Mapper<Map<String, dynamic>, RevStatusEntity> {
  final TreeStateMapper _treeStateMapper;
  final ProofMapper _proofMapper;

  RevStatusMapper(this._treeStateMapper, this._proofMapper);

  @override
  RevStatusEntity mapFrom(Map<String, dynamic> from) {
    return RevStatusEntity(
      issuer: _treeStateMapper.mapFrom(TreeStateDTO.fromJson(from['issuer'])),
      mtp: _proofMapper.mapFrom(ProofDTO.fromJson(from['mtp'])),
    );
  }

  @override
  Map<String, dynamic> mapTo(RevStatusEntity to) {
    return to.toJson();
  }
}
