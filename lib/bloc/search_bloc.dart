import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search/bloc/search_event.dart';
import 'package:flutter_search/bloc/search_state.dart';

import '../data/local/place_data_base.dart';
import '../data/models/all_data_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(allData: const [])) {
    on<GetSearchEvent>(getAllData);
    on<SearcherEvent>(searchAllData);
    on<Searcher1Event>(searchByRegion);
    on<SearcherByIdEvent>(getById);
  }

  List<DataModel> allData1 = [];

  getAllData(GetSearchEvent event, emit) async {
    allData1 = [
      ...await PlacesDatabase.instance.getAllRegions(),
      ...await PlacesDatabase.instance.getAllQuarters(),
      ...await PlacesDatabase.instance.getAllDistricts()
    ];

    emit(state.copyWith(allData: allData1));
  }

  getById(SearcherByIdEvent event, emit){
    emit(state.copyWith(
      allData: allData1.where((element) => element.regionId==event.id).toList()
    ));
  }

  searchByRegion(Searcher1Event event, emit){
    if(event.searchText.isEmpty){
      emit(state.copyWith(allData: allData1.where((element) => element.regionId==event.id).toList()));
    }
    else{
      emit(state.copyWith(
          allData:allData1.where((element) => element.regionId==event.id).toList().where((element) {
            try {
              return element.name
                  .substring(0, event.searchText.length)
                  .toLowerCase() ==
                  event.searchText.toLowerCase();
            } catch (_) {
              return false;
            }
          }).toList()));
    }
  }
  searchAllData(SearcherEvent event, emit) async {
    debugPrint("AllData Length:${allData1.length}");
    debugPrint(event.searchText);
    if(event.searchText.isEmpty){
      emit(state.copyWith(allData: allData1));
    }
    else{
      emit(state.copyWith(
          allData: allData1
              .where((element) {
            try {
              return element.name
                  .substring(0, event.searchText.length)
                  .toLowerCase() ==
                  event.searchText.toLowerCase();
            } catch (_) {
              return false;
            }
          }).toList()));
      }
  }
}
