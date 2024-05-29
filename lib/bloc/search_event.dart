

import 'package:equatable/equatable.dart';

class SearchEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class SearcherEvent extends SearchEvent{

  final String searchText;
  SearcherEvent({required this.searchText});

  @override
  // TODO: implement props
  List<Object?> get props =>[searchText];
}
class Searcher1Event extends SearchEvent{

  final String searchText;
  final int id;
  Searcher1Event({required this.id,required this.searchText});

  @override
  // TODO: implement props
  List<Object?> get props =>[searchText];
}
class SearcherByIdEvent extends SearchEvent{
  final int id;
  SearcherByIdEvent({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props =>[id];
}

class GetSearchEvent extends SearchEvent{

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}