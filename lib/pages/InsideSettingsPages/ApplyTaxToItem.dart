import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';

class ApplyTaxToItem extends StatefulWidget {
  const ApplyTaxToItem({super.key});

  @override
  State<ApplyTaxToItem> createState() => _ApplyTaxToItemState();
}

class _ApplyTaxToItemState extends State<ApplyTaxToItem> {
  bool isSearching = false;
  TextEditingController _searchController = TextEditingController();
  

  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  PopupMenuEntry<String> _popUpItem (String value, String title){
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Text(title, style: bodySregular),
          //need to action 
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 18.0),
        child: Column(
          children: [
            AppBar(
              title: Text('Apply tax to items', style: heading4Regular),
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

                PopupMenuButton<String>(
                  icon: Icon(
                      Icons.more_vert, color: Theme.of(context).colorScheme.secondary,
                       // Set the color of the popup menu icon
                    ),
                    onSelected: (String value){
                      //action
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                      _popUpItem('Option 1', 'Select all'),
                      _popUpItem('Option 2', 'Clear selection'),
                      ];
                    } 
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
                      hintText: 'Search item',
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