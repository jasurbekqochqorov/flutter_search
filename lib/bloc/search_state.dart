import 'package:equatable/equatable.dart';
import '../data/models/all_data_model.dart';

class SearchState extends Equatable{

  List<DataModel> allData;
  SearchState({required this.allData});

  SearchState copyWith({
    List<DataModel>? allData
}){
    return SearchState(allData: allData ?? this.allData);
  }
  @override
  // TODO: implement props
  List<Object?> get props =>[
    allData
  ];

}