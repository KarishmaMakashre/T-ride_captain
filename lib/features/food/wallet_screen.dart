import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  double sw(BuildContext context) => MediaQuery.of(context).size.width;
  double sh(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/topHeaderImage.png",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔥 DARK OVERLAY
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.25),
            ),
          ),

          /// 🔥 CONTENT
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(sw(context) * 0.04),
              child: Column(
                children: [
                  _walletCard(context),
                  SizedBox(height: sh(context) * 0.025),
                  _summaryRow(context),
                  SizedBox(height: sh(context) * 0.025),
                  _transactionTitle(context),
                  SizedBox(height: sh(context) * 0.01),
                  _transactionTile(context, "Order #1234", "+ ₹120"),
                  SizedBox(height: sh(context) * 0.01),
                  _transactionTile(context, "Order #1233", "+ ₹95"),
                  SizedBox(height: sh(context) * 0.01),
                  _transactionTile(context, "Order #1232", "+ ₹140"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= WALLET CARD =================
  Widget _walletCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw(context) * 0.05),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.teal],
        ),
        borderRadius: BorderRadius.circular(sw(context) * 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Wallet Balance",
            style: TextStyle(
              color: Colors.white70,
              fontSize: sw(context) * 0.035,
            ),
          ),
          SizedBox(height: sh(context) * 0.008),
          Text(
            "₹ 2,450",
            style: TextStyle(
              color: Colors.white,
              fontSize: sw(context) * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// ================= SUMMARY ROW =================
  Widget _summaryRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _summaryBox(context, "Today", "₹420"),
        _summaryBox(context, "Orders", "8"),
        _summaryBox(context, "Rating", "4.8 ⭐"),
      ],
    );
  }

  Widget _summaryBox(BuildContext context, String title, String value) {
    return Container(
      width: sw(context) * 0.28,
      padding: EdgeInsets.all(sw(context) * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sw(context) * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: sw(context) * 0.032,
            ),
          ),
          SizedBox(height: sh(context) * 0.006),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sw(context) * 0.04,
            ),
          ),
        ],
      ),
    );
  }

  /// ================= TRANSACTION TITLE =================
  Widget _transactionTitle(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Recent Transactions",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: sw(context) * 0.045,
          color: Colors.white,
        ),
      ),
    );
  }

  /// ================= TRANSACTION TILE =================
  Widget _transactionTile(
      BuildContext context, String title, String amount) {
    return Container(
      margin: EdgeInsets.only(bottom: sh(context) * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sw(context) * 0.04),
      ),
      child: ListTile(
        leading: Icon(
          Icons.receipt_long,
          size: sw(context) * 0.06,
          color: Colors.teal,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: sw(context) * 0.04),
        ),
        trailing: Text(
          amount,
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: sw(context) * 0.04,
          ),
        ),
      ),
    );
  }
}
