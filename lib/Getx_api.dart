import 'dart:convert';
import 'package:http/http.dart' as http;

const _headers = <String, String>{
  'Accept': 'application/json, text/plain, */*',
  'RequestId': '8122aae0-b8c3-4b62-5ff7-7cd75a3ba3e3',
  'X-PowerBI-ResourceKey': '388bb944-d39d-4e22-817c-90d1c8152a84',
  'ActivityId': 'a99ef3ad-1ad8-a289-3e15-a81b336e4277',
};

String bodyCountvalue =
    r"""{"version":"1.0.0","queries":[{"Query":{"Commands":[{"SemanticQueryDataShapeCommand":{"Query":{"Version":2,"From":[{"Name":"t","Entity":"TAB_MASTER","Type":0}],"Select":[{"Aggregation":{"Expression":{"Column":{"Expression":{"SourceRef":{"Source":"t"}},"Property":"valore_da_sostituire"}},"Function":0},"Name":"Sum(TAB_MASTER.valore_da_sostituire)"}]},"Binding":{"Primary":{"Groupings":[{"Projections":[0]}]},"DataReduction":{"DataVolume":3,"Primary":{"Window":{}}},"Version":1}}}]},"CacheKey":"{\"Commands\":[{\"SemanticQueryDataShapeCommand\":{\"Query\":{\"Version\":2,\"From\":[{\"Name\":\"t\",\"Entity\":\"TAB_MASTER\",\"Type\":0}],\"Select\":[{\"Aggregation\":{\"Expression\":{\"Column\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t\"}},\"Property\":\"valore_da_sostituire\"}},\"Function\":0},\"Name\":\"Sum(TAB_MASTER.valore_da_sostituire)\"}]},\"Binding\":{\"Primary\":{\"Groupings\":[{\"Projections\":[0]}]},\"DataReduction\":{\"DataVolume\":3,\"Primary\":{\"Window\":{}}},\"Version\":1}}}]}","QueryId":"","ApplicationContext":{"DatasetId":"5bff6260-1025-49e0-8e9b-169ade7c07f9","Sources":[{"ReportId":"b548a77c-ab0a-4d7c-a457-2e38c2914fc6"}]}}],"cancelQueries":[],"modelId":4280811}"""
        .trim();

Future totalVax() async {
  String body =
      r"""{"version":"1.0.0","queries":[{"Query":{"Commands":[{"SemanticQueryDataShapeCommand":{"Query":{"Version":2,"From":[{"Name":"t1","Entity":"TAB_MASTER_PIVOT","Type":0}],"Select":[{"Aggregation":{"Expression":{"Column":{"Expression":{"SourceRef":{"Source":"t1"}},"Property":"Valore"}},"Function":0},"Name":"Sum(TAB_MASTER_PIVOT.Valore)"}],"OrderBy":[{"Direction":1,"Expression":{"Aggregation":{"Expression":{"Column":{"Expression":{"SourceRef":{"Source":"t1"}},"Property":"Valore"}},"Function":0}}}]},"Binding":{"Primary":{"Groupings":[{"Projections":[0]}]},"DataReduction":{"DataVolume":3,"Primary":{"Window":{}}},"Version":1}}}]},"CacheKey":"{\"Commands\":[{\"SemanticQueryDataShapeCommand\":{\"Query\":{\"Version\":2,\"From\":[{\"Name\":\"t1\",\"Entity\":\"TAB_MASTER_PIVOT\",\"Type\":0}],\"Select\":[{\"Aggregation\":{\"Expression\":{\"Column\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t1\"}},\"Property\":\"Valore\"}},\"Function\":0},\"Name\":\"Sum(TAB_MASTER_PIVOT.Valore)\"}],\"OrderBy\":[{\"Direction\":1,\"Expression\":{\"Aggregation\":{\"Expression\":{\"Column\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t1\"}},\"Property\":\"Valore\"}},\"Function\":0}}}]},\"Binding\":{\"Primary\":{\"Groupings\":[{\"Projections\":[0]}]},\"DataReduction\":{\"DataVolume\":3,\"Primary\":{\"Window\":{}}},\"Version\":1}}}]}","QueryId":"","ApplicationContext":{"DatasetId":"5bff6260-1025-49e0-8e9b-169ade7c07f9","Sources":[{"ReportId":"b548a77c-ab0a-4d7c-a457-2e38c2914fc6"}]}}],"cancelQueries":[],"modelId":4280811}"""
          .trim();

  final resp = await http.post(
      'https://wabi-europe-north-b-api.analysis.windows.net/public/reports/querydata?synchronous=true',
      headers: _headers,
      body: body);
  final jsonBody = json.decode(resp.body);
  final val = jsonBody['results'][0]['result']['data']['dsr']['DS'][0]['PH'][0]
      ['DM0'][0]['M0'];
  return val;
}

Future genderVax() async {
  int m = 0;
  int f = 0;
  await maleVax('TML_SESSO_M').then((value) => m = value);
  await femaleVax('TML_SESSO_F').then((value) => f = value);
  return [m, f];
}

Future maleVax(String value) async {
  String body = bodyCountvalue.replaceAll("valore_da_sostituire", value);

  final resp = await http.post(
      'https://wabi-europe-north-b-api.analysis.windows.net/public/reports/querydata?synchronous=true',
      headers: _headers,
      body: body);
  final jsonBody = json.decode(resp.body);
  final val = jsonBody['results'][0]['result']['data']['dsr']['DS'][0]['PH'][0]
      ['DM0'][0]['M0'];
  return val;
}

Future femaleVax(String value) async {
  String body = bodyCountvalue.replaceAll("valore_da_sostituire", value);

  final resp = await http.post(
      'https://wabi-europe-north-b-api.analysis.windows.net/public/reports/querydata?synchronous=true',
      headers: _headers,
      body: body);
  final jsonBody = json.decode(resp.body);
  final val = jsonBody['results'][0]['result']['data']['dsr']['DS'][0]['PH'][0]
      ['DM0'][0]['M0'];
  return val;
}

Future ageVaxCount() async {
  String body =
      r"""{"version":"1.0.0","queries":[{"Query":{"Commands":[{"SemanticQueryDataShapeCommand":{"Query":{"Version":2,"From":[{"Name":"t","Entity":"TAB_MASTER","Type":0},{"Name":"t1","Entity":"TAB_MASTER_PIVOT","Type":0}],"Select":[{"Column":{"Expression":{"SourceRef":{"Source":"t"}},"Property":"TML_FASCIA_ETA"},"Name":"TAB_MASTER.TML_FASCIA_ETA"},{"Aggregation":{"Expression":{"Column":{"Expression":{"SourceRef":{"Source":"t1"}},"Property":"Valore"}},"Function":0},"Name":"Sum(TAB_MASTER_PIVOT.Valore)"}],"OrderBy":[{"Direction":1,"Expression":{"Column":{"Expression":{"SourceRef":{"Source":"t"}},"Property":"TML_FASCIA_ETA"}}}]},"Binding":{"Primary":{"Groupings":[{"Projections":[0,1]}]},"DataReduction":{"DataVolume":4,"Primary":{"Window":{"Count":1000}}},"Version":1}}}]},"CacheKey":"{\"Commands\":[{\"SemanticQueryDataShapeCommand\":{\"Query\":{\"Version\":2,\"From\":[{\"Name\":\"t\",\"Entity\":\"TAB_MASTER\",\"Type\":0},{\"Name\":\"t1\",\"Entity\":\"TAB_MASTER_PIVOT\",\"Type\":0}],\"Select\":[{\"Column\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t\"}},\"Property\":\"TML_FASCIA_ETA\"},\"Name\":\"TAB_MASTER.TML_FASCIA_ETA\"},{\"Aggregation\":{\"Expression\":{\"Column\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t1\"}},\"Property\":\"Valore\"}},\"Function\":0},\"Name\":\"Sum(TAB_MASTER_PIVOT.Valore)\"}],\"OrderBy\":[{\"Direction\":1,\"Expression\":{\"Column\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t\"}},\"Property\":\"TML_FASCIA_ETA\"}}}]},\"Binding\":{\"Primary\":{\"Groupings\":[{\"Projections\":[0,1]}]},\"DataReduction\":{\"DataVolume\":4,\"Primary\":{\"Window\":{\"Count\":1000}}},\"Version\":1}}}]}","QueryId":"","ApplicationContext":{"DatasetId":"5bff6260-1025-49e0-8e9b-169ade7c07f9","Sources":[{"ReportId":"b548a77c-ab0a-4d7c-a457-2e38c2914fc6"}]}}],"cancelQueries":[],"modelId":4280811}""";

  final resp = await http.post(
      'https://wabi-europe-north-b-api.analysis.windows.net/public/reports/querydata?synchronous=true',
      headers: _headers,
      body: body);
  final jsonBody = json.decode(resp.body);
  final val =
      jsonBody['results'][0]['result']['data']['dsr']['DS'][0]['PH'][0]['DM0'];
  return val;
}

Future regionVaxCount() async {
  String body =
      r"""{"version":"1.0.0","queries":[{"Query":{"Commands":[{"SemanticQueryDataShapeCommand":{"Query":{"Version":2,"From":[{"Name":"t2","Entity":"TAB_REGIONI","Type":0},{"Name":"t","Entity":"TAB_MASTER","Type":0}],"Select":[{"Column":{"Expression":{"SourceRef":{"Source":"t2"}},"Property":"AREA"},"Name":"TAB_REGIONI.AREA"},{"Aggregation":{"Expression":{"Column":{"Expression":{"SourceRef":{"Source":"t"}},"Property":"TOT_SOMM"}},"Function":0},"Name":"Sum(TAB_MASTER.TOT_SOMM)"},{"Measure":{"Expression":{"SourceRef":{"Source":"t"}},"Property":"TassoVaccinazione"},"Name":"TAB_MASTER.TassoVaccinazione"},{"Aggregation":{"Expression":{"Column":{"Expression":{"SourceRef":{"Source":"t"}},"Property":"DOSI_CONSEGNATE"}},"Function":4},"Name":"Sum(TAB_MASTER.DOSI_CONSEGNATE)"}],"OrderBy":[{"Direction":1,"Expression":{"Column":{"Expression":{"SourceRef":{"Source":"t2"}},"Property":"AREA"}}}]},"Binding":{"Primary":{"Groupings":[{"Projections":[0,1,2,3]}]},"DataReduction":{"DataVolume":3,"Primary":{"Window":{"Count":500}}},"Version":1}}}]},"CacheKey":"{\"Commands\":[{\"SemanticQueryDataShapeCommand\":{\"Query\":{\"Version\":2,\"From\":[{\"Name\":\"t2\",\"Entity\":\"TAB_REGIONI\",\"Type\":0},{\"Name\":\"t\",\"Entity\":\"TAB_MASTER\",\"Type\":0}],\"Select\":[{\"Column\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t2\"}},\"Property\":\"AREA\"},\"Name\":\"TAB_REGIONI.AREA\"},{\"Aggregation\":{\"Expression\":{\"Column\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t\"}},\"Property\":\"TOT_SOMM\"}},\"Function\":0},\"Name\":\"Sum(TAB_MASTER.TOT_SOMM)\"},{\"Measure\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t\"}},\"Property\":\"TassoVaccinazione\"},\"Name\":\"TAB_MASTER.TassoVaccinazione\"},{\"Aggregation\":{\"Expression\":{\"Column\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t\"}},\"Property\":\"DOSI_CONSEGNATE\"}},\"Function\":4},\"Name\":\"Sum(TAB_MASTER.DOSI_CONSEGNATE)\"}],\"OrderBy\":[{\"Direction\":1,\"Expression\":{\"Column\":{\"Expression\":{\"SourceRef\":{\"Source\":\"t2\"}},\"Property\":\"AREA\"}}}]},\"Binding\":{\"Primary\":{\"Groupings\":[{\"Projections\":[0,1,2,3]}]},\"DataReduction\":{\"DataVolume\":3,\"Primary\":{\"Window\":{\"Count\":500}}},\"Version\":1}}}]}","QueryId":"","ApplicationContext":{"DatasetId":"5bff6260-1025-49e0-8e9b-169ade7c07f9","Sources":[{"ReportId":"b548a77c-ab0a-4d7c-a457-2e38c2914fc6"}]}}],"cancelQueries":[],"modelId":4280811}""";

  final resp = await http.post(
      'https://wabi-europe-north-b-api.analysis.windows.net/public/reports/querydata?synchronous=true',
      headers: _headers,
      body: body);
  final jsonBody = json.decode(resp.body);
  final val =
      jsonBody['results'][0]['result']['data']['dsr']['DS'][0]['PH'][0]['DM0'];
  return val;
}
