class PathsModel  // Model Class for API Response
{
  List<PathsData> pathsDataList;

  PathsModel.fromJson(List<dynamic> json)
  {
    List<PathsData> tempPathsData = [];
    for(int i = 0; i < json.length; i++)
    {
      PathsData devicesData = PathsData(json[i]);
      tempPathsData.add(devicesData);
    }
    pathsDataList = tempPathsData;
  }
}

class PathsData
{
  String id, title, createdAt, name, avatar;
  List<SubPathsData> subPathsDataList;

  PathsData(pathsData)
  {
    id = pathsData['id'];
    title = pathsData['title'];
    createdAt = pathsData['createdAt'];
    name = pathsData['name'];
    avatar = pathsData['avatar'];

    if(pathsData['sub_paths'] != null)
      {
        List<SubPathsData> tempSubPathsData = [];
        for(int i = 0; i < pathsData['sub_paths'].length; i++)
        {
          SubPathsData devicesData = SubPathsData(pathsData['sub_paths'][i]);
          tempSubPathsData.add(devicesData);
        }
        subPathsDataList = tempSubPathsData;
      }
  }
}

class SubPathsData
{
  String id, title, imageUrl;

  SubPathsData(subPathsData)
  {
    id = subPathsData['id'];
    title = subPathsData['title'];
    imageUrl = subPathsData['image'];
  }
}