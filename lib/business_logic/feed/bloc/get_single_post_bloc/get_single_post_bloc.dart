import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_single_post_event.dart';
part 'get_single_post_state.dart';

class GetSinglePostBloc extends Bloc<GetSinglePostEvent, GetSinglePostState> {
  GetSinglePostBloc() : super(GetSinglePostInitial());

  @override
  Stream<GetSinglePostState> mapEventToState(
    GetSinglePostEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
