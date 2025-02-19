import 'package:dart_connect_metro/dart_connect_metro.dart';
import 'package:test/test.dart';

import '../../../../api_repo.dart';

void main() {
  final String apiKey = ApiRepo.getApiKey();

  group(
    'fetchBusIncidents',
    () {
      test(
        'without routeId',
        () async {
          // ignore: unused_local_variable
          final List<BusIncident> result = await fetchBusIncidents(apiKey);

          // print(result);

          // Can't use [expect] here because the API is dynamic.
        },
      );

      test(
        'with routeId',
        () async {
          final List<BusIncident> allBusIncidents =
              await fetchBusIncidents(apiKey);

          if (allBusIncidents.isEmpty) return;

          final String routeId = allBusIncidents.first.affectedRoutes.first;

          final List<BusIncident> result = await fetchBusIncidents(
            apiKey,
            routeId: routeId,
          );

          int count = 0;

          for (BusIncident busIncident in allBusIncidents) {
            if (busIncident.affectedRoutes.contains(routeId)) {
              count++;
            }
          }

          expect(
            result.length,
            count,
          );
        },
      );
    },
  );
}
