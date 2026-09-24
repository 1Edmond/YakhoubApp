import 'package:multishop_tchad/features/vault/auction_dashboard_summary/domain/repository/auction_dashboard_summary_repository_interface.dart';
import 'package:multishop_tchad/features/vault/auction_dashboard_summary/domain/services/auction_dashboard_summary_service_interface.dart';

class AuctionDashboardSummaryService implements AuctionDashboardSummaryServiceInterface {
  final AuctionDashboardSummaryRepositoryInterface repositoryInterface;
  AuctionDashboardSummaryService({required this.repositoryInterface});

  @override
  Future<dynamic> getAuctionDashboardSummary() async {
    return await repositoryInterface.getAuctionDashboardSummary();
  }
}
