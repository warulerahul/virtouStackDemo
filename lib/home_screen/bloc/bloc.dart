import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:virtoustackdemo/home_screen/model/model.dart';
import 'package:virtoustackdemo/home_screen/resource/repo.dart';

class PathsDataBloc
{
  /*
  * Local Variable of PathsDataRepository
  * */
  final pathsDataRepository = PathsDataRepository();

  /*
  * Local Variable of PublishSubject<PathsModel>
  * */
  final pathsDataFetcher = PublishSubject<PathsModel>();

  Stream<PathsModel> get devicesData => pathsDataFetcher.stream;

  fetchDevicesData(BuildContext context) async
  {
    PathsModel pathsModel = await pathsDataRepository.fetchPathsData(context);
    pathsDataFetcher.add(pathsModel);
  }

  dispose()
  {
    pathsDataFetcher.close();
  }
}

final pathsDataBloc = PathsDataBloc();