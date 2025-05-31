import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int coin = 1250;

  // 각 아이템 이름별 보유 수량
  Map<String, int> inventory = {};

  // 코인 충분한지 확인
  bool canAfford(int price) => coin >= price;

  // 보유 수량 10개 이하인지 확인
  bool canHoldMore(String itemName) {
    final count = inventory[itemName] ?? 0;
    return count < 10;
  }

  // 아이템 구매 처리 (성공 시 true, 실패 시 false)
  bool buyItem(String name, int price) {
    if (!canAfford(price)) return false;
    if (!canHoldMore(name)) return false;

    coin -= price;
    inventory[name] = (inventory[name] ?? 0) + 1;
    notifyListeners();
    return true;
  }

  // 특정 아이템의 보유 개수 반환
  int getItemCount(String itemName) {
    return inventory[itemName] ?? 0;
  }
}