// features/orders/cubit/orders_cubit.dart
import 'package:bloc/bloc.dart';
import '../model/order_model.dart';

class OrdersCubit extends Cubit<List<OrderModel>> {
  OrdersCubit() : super([]);

  void addOrder(OrderModel order) {
    state.add(order);
    emit(List.from(state)); 
    
  }
}