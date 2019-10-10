import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peeps/models/user.dart';
import 'package:peeps/resources/user_repository.dart';
import '../bloc.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository repository;

  ProfileBloc({
    @required this.repository,
  }

  );
  
  @override
  ProfileState get initialState => InitialProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if(event is LoadProfileEvent){
      yield ProfileLoading(); 
      UserModel user = await repository.readProfile();
      if(user == null)
        yield NoProfileLoaded();  
      else
        yield ProfileLoaded(data:user);

    }
  }
}
