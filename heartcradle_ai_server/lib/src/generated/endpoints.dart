/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../audit/audit_endpoint.dart' as _iw8u6495;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../mission/mission_endpoint.dart' as _ijdna360;
import '../sync/sync_endpoint.dart' as _imb49tzk;
import '../telemetry/triage_endpoint.dart' as _i7wei2f9;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'audit': _iw8u6495.AuditEndpoint()
        ..initialize(
          server,
          'audit',
          null,
        ),
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'mission': _ijdna360.MissionEndpoint()
        ..initialize(
          server,
          'mission',
          null,
        ),
      'sync': _imb49tzk.SyncEndpoint()
        ..initialize(
          server,
          'sync',
          null,
        ),
      'triage': _i7wei2f9.TriageEndpoint()
        ..initialize(
          server,
          'triage',
          null,
        ),
    };
    connectors['audit'] = _is.EndpointConnector(
      name: 'audit',
      endpoint: endpoints['audit']!,
      methodConnectors: {
        'recordEvent': _is.MethodConnector(
          name: 'recordEvent',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'missionId': _is.ParameterDescription(
              name: 'missionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'event': _is.ParameterDescription(
              name: 'event',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fromState': _is.ParameterDescription(
              name: 'fromState',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'toState': _is.ParameterDescription(
              name: 'toState',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'createdAt': _is.ParameterDescription(
              name: 'createdAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['audit'] as _iw8u6495.AuditEndpoint).recordEvent(
                    session,
                    eventId: params['eventId'],
                    missionId: params['missionId'],
                    event: params['event'],
                    fromState: params['fromState'],
                    toState: params['toState'],
                    createdAt: params['createdAt'],
                  ),
        ),
        'watchMission': _is.MethodStreamConnector(
          name: 'watchMission',
          params: {
            'missionId': _is.ParameterDescription(
              name: 'missionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['audit'] as _iw8u6495.AuditEndpoint).watchMission(
                session,
                missionId: params['missionId'],
              ),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['mission'] = _is.EndpointConnector(
      name: 'mission',
      endpoint: endpoints['mission']!,
      methodConnectors: {
        'startMission': _is.MethodConnector(
          name: 'startMission',
          params: {
            'missionId': _is.ParameterDescription(
              name: 'missionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'patientId': _is.ParameterDescription(
              name: 'patientId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'totalSteps': _is.ParameterDescription(
              name: 'totalSteps',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mission'] as _ijdna360.MissionEndpoint)
                  .startMission(
                    session,
                    missionId: params['missionId'],
                    patientId: params['patientId'],
                    totalSteps: params['totalSteps'],
                  ),
        ),
        'updateMission': _is.MethodConnector(
          name: 'updateMission',
          params: {
            'missionId': _is.ParameterDescription(
              name: 'missionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'completedSteps': _is.ParameterDescription(
              name: 'completedSteps',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'currentStep': _is.ParameterDescription(
              name: 'currentStep',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'lastEvent': _is.ParameterDescription(
              name: 'lastEvent',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'completedAt': _is.ParameterDescription(
              name: 'completedAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mission'] as _ijdna360.MissionEndpoint)
                  .updateMission(
                    session,
                    missionId: params['missionId'],
                    status: params['status'],
                    completedSteps: params['completedSteps'],
                    currentStep: params['currentStep'],
                    lastEvent: params['lastEvent'],
                    completedAt: params['completedAt'],
                  ),
        ),
        'getRecentMissions': _is.MethodConnector(
          name: 'getRecentMissions',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mission'] as _ijdna360.MissionEndpoint)
                  .getRecentMissions(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'getMission': _is.MethodConnector(
          name: 'getMission',
          params: {
            'missionId': _is.ParameterDescription(
              name: 'missionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mission'] as _ijdna360.MissionEndpoint)
                  .getMission(
                    session,
                    missionId: params['missionId'],
                  ),
        ),
        'getMissionHistory': _is.MethodConnector(
          name: 'getMissionHistory',
          params: {
            'missionId': _is.ParameterDescription(
              name: 'missionId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['mission'] as _ijdna360.MissionEndpoint)
                  .getMissionHistory(
                    session,
                    missionId: params['missionId'],
                  ),
        ),
      },
    );
    connectors['sync'] = _is.EndpointConnector(
      name: 'sync',
      endpoint: endpoints['sync']!,
      methodConnectors: {
        'syncLocalEvent': _is.MethodConnector(
          name: 'syncLocalEvent',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'patientId': _is.ParameterDescription(
              name: 'patientId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'heartRate': _is.ParameterDescription(
              name: 'heartRate',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'spo2': _is.ParameterDescription(
              name: 'spo2',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'respiratoryRate': _is.ParameterDescription(
              name: 'respiratoryRate',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'temperature': _is.ParameterDescription(
              name: 'temperature',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'signalQuality': _is.ParameterDescription(
              name: 'signalQuality',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'decision': _is.ParameterDescription(
              name: 'decision',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'createdAt': _is.ParameterDescription(
              name: 'createdAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['sync'] as _imb49tzk.SyncEndpoint).syncLocalEvent(
                    session,
                    eventId: params['eventId'],
                    patientId: params['patientId'],
                    heartRate: params['heartRate'],
                    spo2: params['spo2'],
                    respiratoryRate: params['respiratoryRate'],
                    temperature: params['temperature'],
                    signalQuality: params['signalQuality'],
                    decision: params['decision'],
                    reason: params['reason'],
                    createdAt: params['createdAt'],
                  ),
        ),
      },
    );
    connectors['triage'] = _is.EndpointConnector(
      name: 'triage',
      endpoint: endpoints['triage']!,
      methodConnectors: {
        'analyzeTelemetry': _is.MethodConnector(
          name: 'analyzeTelemetry',
          params: {
            'patientId': _is.ParameterDescription(
              name: 'patientId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'heartRate': _is.ParameterDescription(
              name: 'heartRate',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'spo2': _is.ParameterDescription(
              name: 'spo2',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'respiratoryRate': _is.ParameterDescription(
              name: 'respiratoryRate',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'temperature': _is.ParameterDescription(
              name: 'temperature',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'signalQuality': _is.ParameterDescription(
              name: 'signalQuality',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['triage'] as _i7wei2f9.TriageEndpoint)
                  .analyzeTelemetry(
                    session,
                    patientId: params['patientId'],
                    heartRate: params['heartRate'],
                    spo2: params['spo2'],
                    respiratoryRate: params['respiratoryRate'],
                    temperature: params['temperature'],
                    signalQuality: params['signalQuality'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
