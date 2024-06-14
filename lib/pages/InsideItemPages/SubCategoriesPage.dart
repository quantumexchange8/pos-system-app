import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/CreateCategory.dart';
import 'package:pos_system/widgets/categoryDataModel.dart';

class SubCategories extends StatefulWidget {
  const SubCategories({super.key});

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  bool isSearching = false;
  List<DataCategory> dataCategory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: isSearching?
        IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                isSearching = false;
              });
            },
          )
        : null,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: isSearching? TextField(
          autofocus: true,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
            border: InputBorder.none,
          ),
          onChanged: (value){
            //handle search
          },
        )
        :Text('Categories', style: bodyMregular.copyWith(color: Colors.white)),
        
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                isSearching = !isSearching;
              });
            }, 
            icon: isSearching? SizedBox():Icon(Icons.search),
          )
        ],
      ),
       floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          onPressed: () async {
            final newCategory = await Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> CreateCategory(),),
            );
            if(newCategory!=null){
              setState(() {
                dataCategory.add(newCategory);
              });
            }
          },    
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: dataCategory.isEmpty? _buildDefaultView():_buildCategoryList(),
    );
  }

Widget _buildDefaultView(){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150, width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: Icon(Icons.filter_none_outlined, size: 100),
        ),
        const SizedBox(height: 25),
        Text('You have no categories yet', style: heading4Regular),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Categories help you organize items.', style: bodySregular),
            TextButton(
              onPressed: (){}, 
              child: Text('Learn more', style: bodySregular.copyWith(decoration: TextDecoration.underline),),
            ),
          ],
        ),

      ],
    ),
  );
}


Widget _buildCategoryList(){
  return ListView.builder(
    itemCount: dataCategory.length,
    itemBuilder: (context, index){
      final dCategory = dataCategory[index];

    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _convertColor(dCategory.color),
                  shape: BoxShape.circle,
                ),   
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dCategory.name, style: bodySregular),
                  Text('0 items', style: bodyXSregular),
                ],
              )
            ],
          ),

          Divider(
            height: 30,
            color: Colors.grey.shade300, 
            thickness: 1, 
            indent: 40, 
            endIndent: 0,
          ),
        ],
      ),
    );
    },
  );
}

Color _convertColor(String colorString) {
  // Remove 'Color(' prefix and ')' suffix
  if (colorString.startsWith('Color(')) {
    colorString = colorString.substring(6, colorString.length - 1);
  }

  // Ensure the string starts with '0xff'
  if (!colorString.startsWith('0xff')) {
    colorString = '0xff' + colorString;
  }

  return Color(int.parse(colorString));
}



}