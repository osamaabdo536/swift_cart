import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_cart/features/cart/cubit/cart_cubit.dart';
import 'package:swift_cart/features/order/cubit/orders_cubit.dart';
import 'package:swift_cart/features/order/model/order_model.dart';
import 'package:swift_cart/features/order/orders_page.dart';

class CheckoutDialog extends StatefulWidget {
  const CheckoutDialog({super.key});

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [


                Row(
                  children: [
                    const Text(
                      "Checkout",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  height: 1.5,
                  color: const Color.fromARGB(255, 210, 209, 209),
                ),

                const SizedBox(height: 12),


                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Phone Number",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: inputDecoration("01234567890"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Phone number is required";
                    }
                    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
                      return "Phone number must be 11 digits";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),


                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Address",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                TextFormField(
                  controller: addressController,
                  decoration: inputDecoration("Egypt, Cairo"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Address is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),


                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Notes",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                TextFormField(
                  controller: notesController,
                  maxLines: 3,
                  decoration: inputDecoration("Any notes..."),
                ),

                const SizedBox(height: 20),


                Row(
                  children: [

                    /// Cancel
                    Expanded(
                      child: OutlinedButton(
                        style: ButtonStyle(
                          side: WidgetStateProperty.all(
                            const BorderSide(color: Colors.grey),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          overlayColor:
                          WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.pressed)) {
                              return Colors.grey.withOpacity(0.2);
                            }
                            if (states.contains(WidgetState.hovered)) {
                              return Colors.grey.withOpacity(0.1);
                            }
                            return null;
                          }),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ),

                    const SizedBox(width: 10),


                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.pressed)) {
                              return const Color(0xFF06004F).withOpacity(0.8);
                            }
                            if (states.contains(WidgetState.hovered)) {
                              return const Color(0xFF06004F).withOpacity(0.9);
                            }
                            return const Color(0xFF06004F);
                          }),
                          foregroundColor: WidgetStateProperty.all(
                            const Color(0xFFFFFFFF),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

                            final cartCubit = context.read<CartCubit>();
                            final ordersCubit = context.read<OrdersCubit>();

                            final order = OrderModel(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              items: List.from(cartCubit.cartItems),
                              phone: phoneController.text,
                              address: addressController.text,
                              notes: notesController.text,
                              dateTime: DateTime.now(),
                              totalPrice: cartCubit.totalPrice,
                            );

                            ordersCubit.addOrder(order);
                            cartCubit.clearCart();

                            Navigator.pop(context); // يقفل الـ dialog

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Order placed successfully")),
                            );

                            // ✅ هنا بقى نحط navigation المباشر
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrdersPage(),
                              ),
                            );
                          }
                        }
                        ,
                        child: const Text("Place Order"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}