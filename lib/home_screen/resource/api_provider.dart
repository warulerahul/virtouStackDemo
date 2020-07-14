import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:virtoustackdemo/home_screen/model/model.dart';

class PathsDataApiProvider
{
  /*
  * Local Variable of Client
  * */
  Client client = Client();

  /*
  * Method to fetch PathsData
  * */
  Future<PathsModel> fetchPathsData(BuildContext context) async
  {
    try
    {
      /*
      * API Url
      * */
      var url = 'https://5d55541936ad770014ccdf2d.mockapi.io/api/v1/paths';

      /*
      * Store Response
      * */
      final response = await client.get(
          url,
      );

      /*
      * Check for API Response Status Code
      * */
      if(response.statusCode == 200)
      {
        return PathsModel.fromJson(jsonDecode(response.body));
      }
      else
      {
        print('FAIL RESP: ' + response.body.toString());
      }
    }
    on SocketException catch (_) {

    }

    return null;
  }
}