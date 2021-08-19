import 'package:flutter/material.dart';
import 'package:transportation/constants.dart';
import 'package:transportation/widgets/custom_textfield.dart';

class MakeOrder extends StatefulWidget {
  static String id = 'make order';
  const MakeOrder({Key? key}) : super(key: key);

  @override
  _MakeOrderState createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {
  final _formKey = GlobalKey<FormState>();
  bool car = true;
  bool isDeliveredToday = false;
  String _orderName = '';
  String _receiverName = '';
  String _receiverPhoneNumber = '';
  String _receiverAddress = '';

  _setOrderName(String orderName) {
    _orderName = orderName;
  }
  _setReceiverName(String receiverName) {
    _receiverName = receiverName;
  }
  _setReceiverPhoneNumber(String receiverPhoneNumber) {
    _receiverPhoneNumber = receiverPhoneNumber;
  }
  _setReceiverAddress(String receiverAddress) {
    _receiverAddress = receiverAddress;
  }

  _onSubmit(){
    FocusScope.of(context).unfocus();
    bool valid = _formKey.currentState!.validate();
    if(valid){
      _formKey.currentState!.save();
      print(_orderName);
      print(_receiverName);
      print(_receiverPhoneNumber);
      print(_receiverAddress);
      print(car);
      print(isDeliveredToday);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains))
        return primaryColor;
      return Colors.grey.shade800;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('أرسل طلب'),
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25 ,horizontal: 20),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextField(
                      text: "أسم المنتج",
                      obscureText: false,
                      textInputType: TextInputType.text,
                      setValue: _setOrderName,
                      validation: (value) {
                        if (value.isEmpty) return 'أدخل اسم المنتج';
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      text: "أسم المرسل أليه",
                      obscureText: false,
                      textInputType: TextInputType.text,
                      setValue: _setReceiverName,
                      validation: (value) {
                        if (value.isEmpty) return 'أدخل أسم المرسل أليه';
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      text: "هاتف المرسل أليه",
                      obscureText: false,
                      textInputType: TextInputType.phone,
                      setValue: _setReceiverPhoneNumber,
                      validation: (value) {
                        if (value.isEmpty) return 'أدخل هاتف المرسل أليه';
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      text: "عنوان المرسل أليه",
                      obscureText: false,
                      textInputType: TextInputType.text,
                      setValue: _setReceiverAddress,
                      validation: (value) {
                        if (value.isEmpty) return 'أدخل عنوان المرسل أليه';
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'أختر النوع المناسب لحجم الشحنة',
                      style: TextStyle(
                          fontSize: 16,
                      ),
                    ),
                    Text(
                      'اذا كانت الشحنة صغيرة اختار موتوسكل والعكس صحيح',
                      style: TextStyle(
                        color: Colors.grey.shade500
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              setState(() { car = !car; });
                            },
                            child: Container(
                              height: 100,
                              color: car ? primaryColor : Colors.grey.shade300,
                              child: Center(
                                child: Text(
                                  'عربية',
                                  style: TextStyle(
                                    color: car ? Colors.white : Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              setState(() { car = !car; });
                            },
                            child: Container(
                              height: 100,
                              color: !car ? primaryColor : Colors.grey.shade300,
                              child: Center(
                                child: Text(
                                  'موتوسكل',
                                  style: TextStyle(
                                    color: !car ? Colors.white : Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Checkbox(
                            value: isDeliveredToday,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            onChanged: (value){
                              setState(() {
                                isDeliveredToday = !isDeliveredToday;
                              });
                            },
                        ),
                        Text(
                          'التوصيل في نفس اليوم',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'التوصيل في نفس اليوم يرفع من سعر النوصيل',
                      style: TextStyle(
                          color: Colors.grey.shade500
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: _onSubmit,
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        color: primaryColor,
                        child: Center(
                          child: Text(
                            'أرسال الطلب',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
