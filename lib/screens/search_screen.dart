import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search/screens/search2_screen.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Data",),
      ),
      body: BlocBuilder<SearchBloc,SearchState>(
        builder: (context,state){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,vertical: 16
                ),
                child: TextField(
                  onChanged: (v){
                    searchText=v;
                    context.read<SearchBloc>().add(SearcherEvent(searchText:v));
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(width: 2,color:Colors.black)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(width: 2,color:Colors.black)
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  Text("Data:${state.allData.length}")
                ],),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24,vertical:24),
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      onTap: (){
                        // context.read<SearchBloc>().add(SearcherByIdEvent(id:state.allData[index].id));
                        //  Navigator.push(context, MaterialPageRoute(builder: (context){
                        //   return const SearchByTumanScreen();
                        // }));
                      },
                      title:(searchText.isEmpty)?Text(state.allData[index].name,style: const TextStyle(
                          fontSize: 20,fontWeight:FontWeight.w400,color: Colors.black
                      ),):RichText(text:TextSpan(
                          text:state.allData[index].name.substring(0,searchText.length),
                          style:  const TextStyle(
                              fontWeight: FontWeight.w700,fontSize: 20,color:Colors.black
                          ),
                          children: [
                            TextSpan(
                              style:const TextStyle(
                                fontSize: 20,fontWeight:FontWeight.w400,color:Colors.black,
                              ),
                              text: state.allData[index].name.substring(searchText.length,state.allData[index].name.length),
                            )
                          ])),
                    );
                  },
                  itemCount: state.allData.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

