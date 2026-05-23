
import '../../models/sharing/share_detail.dart';

abstract class ShareDetailRepository {
  Future<ShareDetail> getShareDetail(String locationId);
}