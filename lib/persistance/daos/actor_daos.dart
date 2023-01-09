
import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/persistance/hive_constant.dart';

class ActorDao{
  static final ActorDao _singleton=ActorDao.internal();

  factory ActorDao()=>_singleton;

  ActorDao.internal();

  void saveAllActors(List<ActorVO>actorList)async{
    //Map<int,ActorVO>actorMap={ for (var actor in actorList) actor.id! : actor };
    Map<int,ActorVO>actorMap=Map.fromIterable(actorList,key: (actor)=>actor.id,value: (actor)=>actor);
    await getActorBox().putAll(actorMap);
  }

  List<ActorVO>getAllActors()=>getActorBox().values.toList();

  Box<ActorVO>getActorBox()=> Hive.box<ActorVO>(BOX_NAME_ACTORVO);

}