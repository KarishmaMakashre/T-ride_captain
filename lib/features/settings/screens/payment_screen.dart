import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Handle help, e.g., show help dialog or navigate to help page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallets Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Wallets',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
            _walletCard(
              context,
              theme,
              icon: Icons.wallet,
              title: 'Tryde Wallet',
              balance: '₹0.0',
              balanceColor: Colors.red,
              buttonText: 'Add Money',
              onButtonPressed: () {
                // TODO: Implement add money functionality, e.g., navigate to add money screen
              },
            ),
            const SizedBox(height: 16),
            // Linked Payments
            _paymentOption(
              context,
              theme,
              icon: Icons.payment, // Replace with actual Amazon Pay icon asset if available
              title: 'Amazon Pay',
              subtitle: 'Cashback behind scratch card upto Rs.25, Assured Rs.5 | min order value of Rs.39 | once per month',
              buttonText: 'LINK',
              onButtonPressed: () {
                // TODO: Implement link Amazon Pay
              },
            ),
            const SizedBox(height: 16),
            // UPI Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Pay by any UPI app',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
            _upiOption(
              context,
              theme,
              icon: Icons.payment, // Replace with GPay icon if available
              title: 'GPay',
              onTap: () {
                // TODO: Implement GPay payment
              },
            ),
            const SizedBox(height: 16),
            // Pay Later Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pay Later',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
            _payLaterOption(
              context,
              theme,
              icon: Icons.qr_code,
              title: 'Pay at drop',
              subtitle: 'Go cashless, after ride pay by scanning QR code',
              onTap: () {
                // TODO: Implement pay at drop
              },
            ),
            _payLaterOption(
              context,
              theme,
              icon: Icons.payment, // Replace with Simpl icon if available
              title: 'Simpl',
              buttonText: 'LINK',
              onButtonPressed: () {
                // TODO: Implement link Simpl
              },
            ),
            const SizedBox(height: 16),
            // Others Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Others',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
            _otherOption(
              context,
              theme,
              icon: Icons.money,
              title: 'Cash',
              onTap: () {
                // TODO: Implement cash payment
              },
            ),
            _otherOption(
              context,
              theme,
              icon: Icons.book,
              title: 'Show Passbook',
              onTap: () {
                // TODO: Implement show passbook, e.g., navigate to passbook screen
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _walletCard(
    BuildContext context,
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String balance,
    required Color balanceColor,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                'Low Balance: $balance',
                style: TextStyle(
                  color: balanceColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                buttonText,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentOption(
    BuildContext context,
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onButtonPressed,
            child: Text(buttonText, style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Widget _upiOption(
    BuildContext context,
    ThemeData theme, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _payLaterOption(
    BuildContext context,
    ThemeData theme, {
    required IconData icon,
    required String title,
    String? subtitle,
    String? buttonText,
    VoidCallback? onTap,
    VoidCallback? onButtonPressed,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            if (buttonText != null)
              TextButton(
                onPressed: onButtonPressed,
                child: Text(buttonText, style: TextStyle(color: AppColors.primary)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _otherOption(
    BuildContext context,
    ThemeData theme, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}