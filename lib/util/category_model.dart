class CategoryModel{

  Map<int,String> categoryData={
    17:"Science",
    23:"History",
    22:"Geography",
    18:"Computer Science",
    11:"Films",
    20:"Mythology",
    21:"Sports"
    };
  
  Map<String,int> categoryDataInv={
    "Science":17,
    "History":23,
    "Geography":22,
    "Computer Science":18,
    "Films":11,
    "Mythology":20,
    "Sports":21
    };


  String categoryName(int catNum){
    return categoryData[catNum];
  }

  int categoryNumber(String name){
    return categoryDataInv[name];
  }
}