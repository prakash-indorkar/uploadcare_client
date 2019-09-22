import 'package:dotenv/dotenv.dart';
import 'package:test/test.dart';
import 'package:uploadcare_client/src/entities/group.dart';
import 'package:uploadcare_client/uploadcare_client.dart';

void main() {
  UploadcareClient client;

  setUpAll(() {
    load();

    client = UploadcareClient(
      options: ClientOptions(
        authorizationScheme: AuthSchemeRegular(
          apiVersion: 'v0.5',
          publicKey: env['UPLOADCARE_PUBLIC_KEY'],
          privateKey: env['UPLOADCARE_PRIVATE_KEY'],
        ),
      ),
    );
  });

  test('create group', () async {
    final response = await client.groups.create({
      'aca02b0a-2db1-42a3-ae53-a290d6b6b0a0': [],
    });
    expect(response, TypeMatcher<GroupInfoEntity>());
  });

  test('list group', () async {
    final response = await client.groups.list();
    expect(response, TypeMatcher<ListEntity<GroupInfoEntity>>());
  });
}
