import 'package:flutter/material.dart';
import 'package:projetcx/app/constants/app_colors.dart';
import 'package:projetcx/app/constants/strings.dart';
import 'package:projetcx/app/controllers/category.dart';
import 'package:projetcx/app/models/category.dart';
import 'package:projetcx/app/ui/category/list.dart';
import 'package:projetcx/app/ui/page/list.dart';
import 'package:projetcx/app/widgets/fields/color_picker.dart';
import 'package:projetcx/app/widgets/fields/text_field.dart';
import 'package:projetcx/app/widgets/fields/icon_picker.dart';
import 'package:projetcx/app/widgets/utils/gradient_background.dart';
import 'package:provider/provider.dart';

class CategoryManageForm extends StatefulWidget {
  final CategoryModel item;

  CategoryManageForm({this.item});

  @override
  State<StatefulWidget> createState() {
    return _CategoryManageFormState();
  }
}

class _CategoryManageFormState extends State<CategoryManageForm> {
  CategoryService _category;
  final Map<String, dynamic> _formData = {
    'name': null,
    'color': null,
    'icon': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color _categoryColor;
  IconData _categoryIcon;
  int _categoryIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.item != null) {
        _categoryColor = AppColors.getColorFrom(id: widget.item.color);
        _categoryIcon =  IconData(widget.item.icon);
        _formData['icon'] = widget.item.icon;
      } else {
        _categoryColor = AppColors.defaultColors[0];
        _categoryIcon = Icons.work;
        _formData['icon'] = Icons.work.codePoint;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _category = Provider.of<CategoryService>(context);
    _categoryIndex = _category.getItemIndex(widget.item);

    if (_categoryIndex == -1) {
      _categoryIndex = _category.getItems.length;
    }

    return GradientBackground(
      color: _categoryColor,
      child: WillPopScope(
        // ignore: missing_return
        onWillPop: () async {
          Route route = MaterialPageRoute(
            builder: (context) => CategoryList(categoryIndex: _categoryIndex),
          );
          Navigator.push(context, route);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _categoryColor,
            centerTitle: true,
            title: Text(Strings.managerCategory),
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(40.0),
              child: _formPage(_category),
            ),
          ),
          floatingActionButton: _floatingButtons(),
        ),
      ),
    );
  }

  Widget _floatingButtons() {
    return Stack(
      children: <Widget>[
        widget.item != null
            ? Padding(
                padding: EdgeInsets.only(left: 31),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('button'), //CategoryDeleteButton(widget.item),
                ),
              )
            : Container(),
        Align(
          alignment: Alignment.bottomRight,
          child: _saveButton(),
        ),
      ],
    );
  }

  Widget _saveButton() {
    return FloatingActionButton(
      heroTag: 'save',
      onPressed: () async {
        Future<CategoryModel> result = _submitFormSave();
        result.then((item) {
          _submitFormRedirect(context, item);
        });
      },
      child: Icon(
        Icons.done,
      ),
    );
  }

  Widget _formPage(CategoryService category) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              FieldColorPicker(
                color: _categoryColor,
                onColorChanged: (color) {
                  setState(() {
                    _categoryColor = color;
                    _formData['color'] = _categoryColor.value;
                  });
                },
              ),
              SizedBox(
                width: 20.0,
              ),
              FieldIconPicker(
                iconData: _categoryIcon,
                action: (newIcon) => setState(() {
                  _categoryIcon = newIcon;
                  _formData['icon'] = _categoryIcon.codePoint;
                }),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          FieldTextField(
            value: widget.item != null ? widget.item.name : null,
            hintText: Strings.fieldCategoryName,
            autoFocus: true,
            onSaved: (name) {
              setState(() {
                _formData['name'] = name != '' ? name : 'Category';
              });
            },
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }

  Future<CategoryModel> _submitFormSave() async {
    final _category = Provider.of<CategoryService>(context);
    _formKey.currentState.save();
    CategoryModel result;
    Future<int> itemResult;
    if (widget.item != null) {
      CategoryModel updatedItem = CategoryModel(
        id: widget.item.id,
        name: _formData['name'],
        color: _categoryColor.value,
        icon: null,
      );
      itemResult = _category.updateItem(updatedItem);
      await itemResult.then((_) {
        result = updatedItem;
      });
    } else {
      itemResult = _category.addItem(_formData);
      await itemResult.then((itemId) {
        result = CategoryModel(
          id: itemId,
          name: _formData['name'],
          color: _categoryColor.value,
          icon: null,
        );
      });
    }
    return result;
  }

  void _submitFormRedirect(BuildContext context, CategoryModel category) {
    Route route = MaterialPageRoute(
      builder: (context) => PageList(category: category,),
    );
    Navigator.push(context, route);
  }
}
