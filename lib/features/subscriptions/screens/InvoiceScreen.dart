import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shurjopay/models/config.dart';
import 'package:shurjopay/models/payment_verification_model.dart';
import 'package:shurjopay/models/shurjopay_request_model.dart';
import 'package:shurjopay/models/shurjopay_response_model.dart';
import 'package:shurjopay/shurjopay.dart';
import 'package:shurjopay/utilities/functions.dart';
import 'package:talent_lens_hub/api/api_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../authentication/providers/auth_provider.dart';

class InvoiceScreen extends StatefulWidget {
  final int packageID;
  final String packageName;
  final double packageValue;
  final double discountValue;
  final double payableAmount;

  const InvoiceScreen(
      {super.key,
      required this.packageID,
      required this.packageName,
      required this.packageValue,
      required this.discountValue,
      required this.payableAmount});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late String status = "nothing";
  late int generatedTransectionId = 0;
  late int userID;

  late int _packageID;
  late String _packageName;
  late double _packageValue;
  late double _discountValue;
  late double _payableAmount;

  bool _isApplied = false;

  late TextEditingController couponCodeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _packageID = widget.packageID;
    _packageName = widget.packageName;
    _packageValue = widget.packageValue;
    _discountValue = widget.discountValue;
    _payableAmount = widget.payableAmount;
    _isApplied = false;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    userID = authProvider.user!.id;
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Purchase Invoice",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: TColors.primaryBackground,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: TColors.primaryColor),
              ),
              child: Column(
                children: [
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("PackageID "),
                      Text("${widget.packageID}"),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PackageName ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _packageName,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Base Price ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _packageValue.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _discountValue.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total "),
                Text("${widget.payableAmount}"),
              ],
            ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payable Amount ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        _payableAmount.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TransectionId",
                        style: TextStyle(fontSize: 16),
                      ),
                      status == "true"
                          ? Text(
                              "${generatedTransectionId}",
                              style: TextStyle(fontSize: 16),
                            )
                          : const Text(
                              "No transaction yet",
                              style: TextStyle(fontSize: 16),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            status == "true"
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: TColors.accent,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Purchased Successfully,\n Now you can continue your study.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryColor),
                      onPressed: () {
                        generatedTransectionId =
                            DateTime.now().millisecondsSinceEpoch;
                        print("$generatedTransectionId");
                        setState(() {
                          generatedTransectionId;
                        });
                        ApiController.initiatePayment(
                          userID,
                          _packageID,
                          generatedTransectionId.toString(),
                          _payableAmount,
                        );
                        _initiatePayment();
                      },
                      child: Text(
                        "Purchase",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

            /*Text("Transection Status:  $status"),*/
          ],
        ),
      ),
    );
  }

  void _initiatePayment() async {
    // Initialize shurjopay
    /*ShurjoPay shurjoPay = ShurjoPay();*/
    // ShurjoPay _shurjoPayService = ShurjopayRequestModel(configs: configs, currency: currency, amount: amount, orderID: orderID, customerName: customerName, customerPhoneNumber: customerPhoneNumber, customerAddress: customerAddress, customerCity: customerCity, customerPostcode: customerPostcode, returnURL: returnURL, cancelURL: cancelURL);
    // initializeShurjopay(environment: "live");
    ShurjoPay shurjoPay = ShurjoPay();
    ShurjopayConfigs shurjopayConfigs = ShurjopayConfigs(
      prefix: "TLH",
      userName: "TalentLensHub",
      password: "talety4r5p8mpz&v",
      clientIP: "127.0.0.1",
    );

    final shurjopayRequestModel = await ShurjopayRequestModel(
        configs: shurjopayConfigs,
        currency: "BDT",
        amount: _payableAmount,
        orderID: generatedTransectionId.toString(),
        customerName: "widget.packageName",
        customerPhoneNumber: "01758387250",
        customerAddress: "Bangladesh",
        customerCity: "Dhaka",
        customerPostcode: "1230",
        returnURL: "https://www.sandbox.shurjopayment.com/return_url",
        cancelURL: "https://www.sandbox.shurjopayment.com/cancel_url");

    ShurjopayResponseModel shurjopayResponseModel = ShurjopayResponseModel();

    shurjopayResponseModel = await shurjoPay.makePayment(
      context: context,
      shurjopayRequestModel: shurjopayRequestModel,
    );
    print(shurjopayResponseModel.errorCode);

    ShurjopayVerificationModel shurjopayVerificationModel =
        ShurjopayVerificationModel();
    if (shurjopayResponseModel.status == true) {
      try {
        // Initiate payment
        shurjopayVerificationModel = await shurjoPay.verifyPayment(
          orderID: shurjopayResponseModel.shurjopayOrderID!,
        );
        print(shurjopayVerificationModel.spCode);
        print(shurjopayVerificationModel.spMessage);
        if (shurjopayVerificationModel.spCode == "1000") {
          print(
              "Payment Varified - ${shurjopayVerificationModel.spMessage}, ${shurjopayVerificationModel.spCode}");
        } else {
          print(
              "Payment not Varified - ${shurjopayVerificationModel.spMessage}, ${shurjopayVerificationModel.spCode}");
        }

        ApiController.receivePayment(
          userID,
          widget.packageID,
          generatedTransectionId.toString(),
          shurjopayVerificationModel.spCode == "1000" ? "VALID" : "FAILED",
          //STATUS
          double.tryParse(shurjopayVerificationModel.amount != null
              ? shurjopayVerificationModel.amount!
              : "0")!,
          //amount
          shurjopayVerificationModel.receivedAmount != null
              ? shurjopayVerificationModel.receivedAmount.toString()
              : "0",
          //store amount
          shurjopayVerificationModel.cardNumber != null
              ? shurjopayVerificationModel.cardNumber!
              : "null",
          //cardNumber
          shurjopayVerificationModel.bankTrxId != null
              ? shurjopayVerificationModel.bankTrxId!
              : "null",
          //bankTranId
          shurjopayVerificationModel.currency != null
              ? shurjopayVerificationModel.currency!
              : "null",
          //currencyType
          shurjopayVerificationModel.cardHolderName != null
              ? shurjopayVerificationModel.cardHolderName!
              : "null",
          //cardIssuer
          shurjopayVerificationModel.bankStatus != null
              ? shurjopayVerificationModel.bankStatus!
              : "null",
          //cardBrand
          shurjopayVerificationModel.transactionStatus != null
              ? shurjopayVerificationModel.transactionStatus!
              : "null",
          //cardIssuerCountry
          shurjopayVerificationModel.spCode != null
              ? shurjopayVerificationModel.spCode!
              : "null",
          //riskLevel
          shurjopayVerificationModel.spMessage != null
              ? shurjopayVerificationModel.spMessage!
              : "null", //risk title
        );
        // Handle payment response
        if (shurjopayVerificationModel.spCode.toString() == "1000") {
          setState(() {
            status = "true";
          });
          Fluttertoast.showToast(
            msg:
                "Transaction successful. Transaction ID: ${shurjopayVerificationModel.bankTrxId}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        } else if (shurjopayVerificationModel.spCode.toString() == "1011" ||
            shurjopayVerificationModel.spCode.toString() == "1002") {
          setState(() {
            status = "false";
          });
          Fluttertoast.showToast(
            msg: "Transaction closed by user.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        } else {
          setState(() {
            status = "false";
          });
          Fluttertoast.showToast(
            msg: "Transaction failed.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
          // Perform any actions after successful payment (e.g., navigate to success screen)
        }
      } catch (e) {
        debugPrint(e.toString());
        Fluttertoast.showToast(
          msg: "Error occurred during payment.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }
}
