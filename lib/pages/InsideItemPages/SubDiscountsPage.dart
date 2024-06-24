import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/const/controller/discountProvider.dart';
import 'package:pos_system/const/textStyle.dart';
import 'package:pos_system/pages/InsideItemPages/CreateDiscounts.dart';
import 'package:pos_system/pages/InsideItemPages/EditDiscounts.dart';
import 'package:pos_system/widgets/dataModel/discountDataModel.dart';
import 'package:provider/provider.dart';

class SubDiscounts extends StatefulWidget {
  const SubDiscounts({super.key});

  @override
  State<SubDiscounts> createState() => _SubDiscountsState();
}

class _SubDiscountsState extends State<SubDiscounts> {
  bool isSearching = false;
  //List<DiscountData> discountData = [];

  @override
  Widget build(BuildContext context) {
    final discountProvider = Provider.of<DiscountProvider>(context);
    List<DiscountData> discountData = discountProvider.discounts;

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
          onPressed: () async {
            final newDiscount = await Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> CreateDiscounts(),
              ),
            );
            if(newDiscount!=null){
              setState(() {
                discountData.add(newDiscount);
              });
            }
          },    
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body:  discountData.isEmpty?_buildDefaultView(): _buildDiscountList(discountData, discountProvider),
    );
  }


  Widget _buildDefaultView(){
    return  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
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
              const SizedBox(height: 25),
              Text('Create discounts that can be applied at the time of sale.', style: bodySregular),
              TextButton(
                onPressed: (){}, 
                child: Text('Learn more', style: bodySregular.copyWith(decoration: TextDecoration.underline),),
              ),
          
            ],
          ),
        ),
      );
  }

  Widget _buildDiscountList(List<DiscountData>discountData, DiscountProvider discountProvider){
    return ListView.builder(
      itemCount: discountData.length,
      itemBuilder: (context,index){
        final pdiscount = discountData[index];

        return Dismissible(
          key: Key(pdiscount.name),
          direction: DismissDirection.endToStart,
          background: Container(
            padding: const EdgeInsets.only(right: 15),
            color: Colors.red.shade500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete, color: Colors.white),
              ],
            ),
          ),
          onDismissed: (direction) {
            discountProvider.removeDiscount(pdiscount);
          },
          child: ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                          ),
                          child: Icon(Icons.sell_outlined, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Text(pdiscount.name, style: bodySregular),
                      ],
                    ),
                    Text(pdiscount.discount),
                  ],
                ),
                Divider(
                  height: 5,
                  color: Colors.grey.shade300, 
                  thickness: 1, 
                  indent: 40, 
                  endIndent: 0,
                ),
          
              ],
            ),
            onTap: () async {
              final updatedDiscount = await
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=>EditDiscounts(discountData: pdiscount),),
              );
              if(updatedDiscount!=null){
                Provider.of<DiscountProvider>(context,listen: false).updateDiscount(pdiscount, updatedDiscount);
              }
            },
          ),
        );
      }
    );
  }
}