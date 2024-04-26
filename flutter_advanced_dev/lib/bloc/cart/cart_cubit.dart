import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(super.initialState);

  sepeteEkle(
      {required String ad,
      required int id,
      required String photo,
      required int sayi,
      required double fiyat}) {
    var suankiSepet = state.sepet;
    suankiSepet.add({
      "id": id,
      "photo": photo,
      "name": ad,
      "in-stock": true,
      "count": sayi,
      "price": fiyat,
    });
    final yeniDurum = CartState(
      sepet: suankiSepet,
    );
    emit(yeniDurum);
  }

  sepettenCikart({required int id}) {
    var suankiSepet = state.sepet;

    suankiSepet.removeWhere((element) => ["id"] == id);

    final yeniDurum = CartState(
      sepet: suankiSepet,
    );
    emit(yeniDurum);
  }

  sepetiBosalt({required String ad, required int sayi, required double fiyat}) {
    final yeniDurum = CartState(sepet: []);
    emit(yeniDurum);
  }
}
