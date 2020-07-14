
import 'package:flutter/material.dart';
import 'package:virtoustackdemo/home_screen/model/model.dart';
import 'package:virtoustackdemo/home_screen/resource/api_provider.dart';

class PathsDataRepository
{
  /*
  * Local Variable of PathsDataApiProvider
  * */
  final pathsDataApiProvider = PathsDataApiProvider();

  /*
  * Method call to fetchPathsData
  * */
  Future<PathsModel> fetchPathsData(BuildContext context) => pathsDataApiProvider.fetchPathsData(context);
}