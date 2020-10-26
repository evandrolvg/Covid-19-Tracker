import 'package:covid_19/models/categorie_model.dart';

List<CategorieModel> getCategories() {
  List<CategorieModel> myCategories = List<CategorieModel>();
  CategorieModel categorieModel;

  categorieModel = new CategorieModel();
  categorieModel.categorieName = "World";
  categorieModel.imageAssetUrl = "assets/images/world.jpg";
  myCategories.add(categorieModel);

  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Official language";
  categorieModel.imageAssetUrl = "assets/images/world.jpg";
  myCategories.add(categorieModel);

  return myCategories;
}
