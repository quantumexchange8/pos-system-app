import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';

class AssignItem extends StatefulWidget {
  const AssignItem({super.key});

  @override
  State<AssignItem> createState() => _AssignItemState();
}

class _AssignItemState extends State<AssignItem> {
  bool isSearching = false;
  TextEditingController _searchController = TextEditingController();
  

  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 18.0),
        child: Column(
          children: [
            AppBar(
              title: Text('Assign items to category', style: heading4Regular),
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                icon: Icon(Icons.close, color: Theme.of(context).colorScheme.secondary),
              ),
              actions: [
                TextButton(
                  onPressed: (){
                    //need to handle save function, havent done
                  }, 
                  child: Text('SAVE', style: bodySregular.copyWith(color: Theme.of(context).colorScheme.primary),),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade400),
          ],
        ),
      ),

      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: 
                    Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  child: const Icon(Icons.search),
                ),
              ),

              Expanded(
                flex: 6,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: 
                    Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  child: //isSearching?
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none
                    ),
                    onTap: (){
                      setState(() {
                        isSearching = true;
                      });
                    },
                    onChanged: (value){
                       
                    },
                     
                  )
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                   height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: 
                    Border(
                      bottom: BorderSide(color: Colors.grey.shade400, width: 1),
                    ),
                  ),
                  child: IconButton(
                    icon: isSearching? const Icon(Icons.close):const SizedBox(), 
                    onPressed: () { 
                      setState(() {
                        isSearching = false;
                        _searchController.clear();
                        FocusScope.of(context).unfocus();
                      });
                     },
                     
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}