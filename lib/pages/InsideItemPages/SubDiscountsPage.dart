import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/CreateDiscounts.dart';

class SubDiscounts extends StatefulWidget {
  const SubDiscounts({super.key});

  @override
  State<SubDiscounts> createState() => _SubDiscountsState();
}

class _SubDiscountsState extends State<SubDiscounts> {
  bool isSearching = false;

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
        :Text('Discounts', style: bodyMregular.copyWith(color: Colors.white)),
        
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
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> CreateDiscounts(),
              ),
            );
          },    
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Padding(
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
              child: Icon(Icons.sell_outlined, size: 100),
            ),
            const SizedBox(height: 25),
            Text('You have no discounts yet', style: heading4Regular),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Create discounts that can be applied at the time of sale.', style: bodySregular),
                TextButton(
                  onPressed: (){}, 
                  child: Text('Learn more', style: bodySregular.copyWith(decoration: TextDecoration.underline),),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}