import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/form_models.dart';
import '../../providers/form_providers.dart';

class StepperFormLayout extends ConsumerStatefulWidget {
  const StepperFormLayout({super.key});

  @override
  ConsumerState<StepperFormLayout> createState() => _StepperFormLayoutState();
}

class _StepperFormLayoutState extends ConsumerState<StepperFormLayout> {
  int _currentStep = 0;
  
  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(formStateProvider('stepper_form'));
    final formNotifier = ref.read(formStateProvider('stepper_form').notifier);
    
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Stepper(
        currentStep: _currentStep,
        onStepContinue: () async {
          if (_currentStep < 3) {
            // Validate current step before proceeding
            final isValid = await _validateCurrentStep(formNotifier);
            if (isValid) {
              setState(() {
                _currentStep++;
              });
            }
          } else {
            // Submit form
            await formNotifier.submitForm((values) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order placed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        controlsBuilder: (context, details) {
          return Row(
            children: [
              FilledButton(
                onPressed: details.onStepContinue,
                child: Text(_currentStep == 3 ? 'Place Order' : 'Continue'),
              ),
              const SizedBox(width: 8),
              if (_currentStep > 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Back'),
                ),
            ],
          );
        },
        steps: [
          Step(
            title: const Text('Shipping Address'),
            content: _buildShippingStep(formState, formNotifier),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Payment Method'),
            content: _buildPaymentStep(formState, formNotifier),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Order Items'),
            content: _buildOrderItemsStep(formState, formNotifier),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Review & Confirm'),
            content: _buildReviewStep(formState, formNotifier),
            isActive: _currentStep >= 3,
            state: _currentStep > 3 ? StepState.complete : StepState.indexed,
          ),
        ],
      ),
    );
  }
  
  Widget _buildShippingStep(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return Column(
      children: [
        TextFormField(
          initialValue: formState.values['fullName'],
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => formNotifier.updateFieldValue('fullName', value),
        ),
        const SizedBox(height: 16),
        TextFormField(
          initialValue: formState.values['address'],
          decoration: const InputDecoration(
            labelText: 'Street Address',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => formNotifier.updateFieldValue('address', value),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                initialValue: formState.values['city'],
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formNotifier.updateFieldValue('city', value),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                initialValue: formState.values['state'],
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formNotifier.updateFieldValue('state', value),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                initialValue: formState.values['zipCode'],
                decoration: const InputDecoration(
                  labelText: 'ZIP',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => formNotifier.updateFieldValue('zipCode', value),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildPaymentStep(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text('Credit Card'),
          subtitle: const Text('Visa, Mastercard, Amex'),
          value: 'credit_card',
          groupValue: formState.values['paymentMethod'],
          onChanged: (value) => formNotifier.updateFieldValue('paymentMethod', value),
        ),
        RadioListTile<String>(
          title: const Text('PayPal'),
          subtitle: const Text('Pay with your PayPal account'),
          value: 'paypal',
          groupValue: formState.values['paymentMethod'],
          onChanged: (value) => formNotifier.updateFieldValue('paymentMethod', value),
        ),
        RadioListTile<String>(
          title: const Text('Bank Transfer'),
          subtitle: const Text('Direct bank transfer'),
          value: 'bank_transfer',
          groupValue: formState.values['paymentMethod'],
          onChanged: (value) => formNotifier.updateFieldValue('paymentMethod', value),
        ),
        const SizedBox(height: 16),
        if (formState.values['paymentMethod'] == 'credit_card') ...[
          TextFormField(
            initialValue: formState.values['cardNumber'],
            decoration: const InputDecoration(
              labelText: 'Card Number',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => formNotifier.updateFieldValue('cardNumber', value),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: formState.values['expiryDate'],
                  decoration: const InputDecoration(
                    labelText: 'MM/YY',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => formNotifier.updateFieldValue('expiryDate', value),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  initialValue: formState.values['cvv'],
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => formNotifier.updateFieldValue('cvv', value),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
  
  Widget _buildOrderItemsStep(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    final items = [
      {'name': 'Flutter Development Book', 'price': 49.99, 'quantity': 1},
      {'name': 'Dart Programming Course', 'price': 99.99, 'quantity': 1},
      {'name': 'Material Design Guide', 'price': 29.99, 'quantity': 2},
    ];
    
    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int),
    );
    final tax = subtotal * 0.08;
    final total = subtotal + tax;
    
    return Column(
      children: [
        ...items.map((item) => Card(
          child: ListTile(
            title: Text(item['name'] as String),
            subtitle: Text('Quantity: ${item['quantity']}'),
            trailing: Text(
              '\$${((item['price'] as double) * (item['quantity'] as int)).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        )),
        const SizedBox(height: 16),
        const Divider(),
        ListTile(
          title: const Text('Subtotal'),
          trailing: Text('\$${subtotal.toStringAsFixed(2)}'),
        ),
        ListTile(
          title: const Text('Tax (8%)'),
          trailing: Text('\$${tax.toStringAsFixed(2)}'),
        ),
        const Divider(),
        ListTile(
          title: Text(
            'Total',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            '\$${total.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildReviewStep(
    FormStateData formState,
    FormStateNotifier formNotifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipping Address',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formState.values['fullName'] ?? ''),
                Text(formState.values['address'] ?? ''),
                Text('${formState.values['city'] ?? ''}, ${formState.values['state'] ?? ''} ${formState.values['zipCode'] ?? ''}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Payment Method',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: Icon(
              formState.values['paymentMethod'] == 'credit_card'
                  ? Icons.credit_card
                  : formState.values['paymentMethod'] == 'paypal'
                      ? Icons.account_balance_wallet
                      : Icons.account_balance,
            ),
            title: Text(
              formState.values['paymentMethod'] == 'credit_card'
                  ? 'Credit Card'
                  : formState.values['paymentMethod'] == 'paypal'
                      ? 'PayPal'
                      : 'Bank Transfer',
            ),
            subtitle: formState.values['paymentMethod'] == 'credit_card' &&
                    formState.values['cardNumber'] != null
                ? Text('**** **** **** ${formState.values['cardNumber'].toString().substring(formState.values['cardNumber'].toString().length - 4)}')
                : null,
          ),
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
          value: formState.values['agreeToTerms'] ?? false,
          onChanged: (value) => formNotifier.updateFieldValue('agreeToTerms', value),
          title: const Text('I agree to the Terms of Service and Privacy Policy'),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ],
    );
  }
  
  Future<bool> _validateCurrentStep(FormStateNotifier formNotifier) async {
    // Add validation logic for each step
    switch (_currentStep) {
      case 0:
        // Validate shipping address
        return true;
      case 1:
        // Validate payment method
        return true;
      case 2:
        // Validate order items
        return true;
      case 3:
        // Validate review
        return true;
      default:
        return true;
    }
  }
}