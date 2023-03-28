import 'dart:convert';

import 'package:event_sync/src/core/error/exception.dart';
import 'package:event_sync/src/core/network/network.dart';
import 'package:event_sync/src/core/network/response.dart';
import 'package:event_sync/src/feature/data/remote/data_sources/event_remote_data_source.dart';
import 'package:event_sync/src/feature/data/remote/models/remote_event_model.dart';
import 'package:event_sync/src/feature/data/remote/models/remote_new_event_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'event_remote_data_source_test.mocks.dart';

@GenerateMocks([Network])
void main() {
  late EventRemoteDataSourceImpl dataSource;
  late MockNetwork mockNetwork;

  setUp(() {
    mockNetwork = MockNetwork();
    dataSource = EventRemoteDataSourceImpl(network: mockNetwork);
  });

  group('createEvent', () {
    const tToken = 'token';
    final tHost = Uri.parse('https://example.com');
    final tEvent =
        RemoteEventModel.fromJson(json.decode(fixture('remote_event.json')));
    final tNewEvent = RemoteNewEventModel(
      streamId: tEvent.streamId,
      version: tEvent.version,
      name: tEvent.name,
      data: tEvent.data,
    );
    final tBody = fixture('remote_event.json');
    final tHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $tToken",
    };
    final tResponse = ResponseImpl(tBody, 201);

    test(
      'should create an event on the server',
      () async {
        // arrange
        final tCreateEventHost = Uri.parse('$tHost/events').normalizePath();
        when(mockNetwork.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => tResponse);
        // act
        final result = await dataSource.createEvent(
          tNewEvent,
          host: tHost,
          token: tToken,
        );
        // assert
        final tExpectedBody = json.encode({
          "event": tNewEvent.toJson(),
        });
        verify(mockNetwork.post(tCreateEventHost,
            headers: tHeaders, body: tExpectedBody));
        expect(result, RemoteEventModel.fromJson(json.decode(tBody)));
      },
    );

    test(
      'should throw ServerError if the event creation in fails',
      () async {
        // arrange
        final tFailedResponse = ResponseImpl(tBody, 400);
        when(mockNetwork.post(any, body: anyNamed('body')))
            .thenAnswer((_) async => tFailedResponse);
        // act
        final call = dataSource.createEvent;
        // assert
        expect(() => call(tNewEvent, host: tHost, token: tToken),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );

    test(
      'should throw ServerError if the network raises an error',
      () async {
        // arrange
        when(mockNetwork.post(any, body: anyNamed('body'))).thenThrow(Error());
        // act
        final call = dataSource.createEvent;
        // assert
        expect(() => call(tNewEvent, host: tHost, token: tToken),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('getEvents', () {
    const tToken = 'token';
    final tHost = Uri.parse('example.com');
    final tBody = fixture('remote_events.json');
    final tJsonEvents = json.decode(tBody);
    final tHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $tToken",
    };
    final tResponse = ResponseImpl(tBody, 200);

    test(
      'should get list of events from the server',
      () async {
        // arrange
        final tGetEventsHost = Uri.parse('$tHost/events').normalizePath();
        when(mockNetwork.get(
          any,
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => tResponse);
        // act
        final result = await dataSource.getEvents(host: tHost, token: tToken);
        // assert
        verify(mockNetwork.get(tGetEventsHost, headers: tHeaders));
        final expectedEvents = tJsonEvents['events'].map((e) {
          return RemoteEventModel.fromJson(e);
        }).toList();
        expect(result, expectedEvents);
      },
    );

    test(
      'should throw ServerError if getting events fails',
      () async {
        // arrange
        final tFailedResponse = ResponseImpl(tBody, 400);
        when(mockNetwork.get(any)).thenAnswer((_) async => tFailedResponse);
        // act
        final call = dataSource.getEvents;
        // assert
        expect(() => call(host: tHost, token: tToken),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );

    test(
      'should throw ServerError if the network raises an error',
      () async {
        // arrange
        when(mockNetwork.get(any)).thenThrow(Error());
        // act
        final call = dataSource.getEvents;
        // assert
        expect(() => call(host: tHost, token: tToken),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
