import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  final List<Map<String, dynamic>> foodItems = const [
    {'name': '기본 사료', 'price': 500},
    {'name': '고급 사료', 'price': 700},
    {'name': '프리미엄 사료', 'price': 1000},
  ];

  final List<Map<String, dynamic>> medicineItems = const [
    {'name': '감기약', 'price': 800},
    {'name': '진통제', 'price': 1000},
    {'name': '소화제', 'price': 1200},
  ];

  final List<Map<String, dynamic>> toyItems = const [
    {'name': '사과', 'price': 1500},
    {'name': '뼈', 'price': 1800},
    {'name': '공', 'price': 2000},
  ];

  @override
  Widget build(BuildContext context) {
    final coin = context.watch<AppState>().coin;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFD5F3C4),
        appBar: AppBar(
          backgroundColor: const Color(0xFFD5F3C4),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('상점', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.monetization_on, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text('$coin원', style: const TextStyle(color: Colors.black)),
                ],
              ),
            ],
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: '음식'),
              Tab(text: '약'),
              Tab(text: '용품'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildShopItems(context, foodItems),
            _buildShopItems(context, medicineItems),
            _buildShopItems(context, toyItems),
          ],
        ),
      ),
    );
  }

  Widget _buildShopItems(BuildContext context, List<Map<String, dynamic>> items) {
    final appState = Provider.of<AppState>(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: items.map((item) {
        final itemCount = appState.getItemCount(item['name']);

        return Card(
          color: const Color(0xFFFFF5D1),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${item['price']}원 / 보유: $itemCount개'),
            trailing: ElevatedButton(
              onPressed: () {
                _confirmPurchase(context, item['name'], item['price']);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('구매'),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _confirmPurchase(BuildContext context, String name, int price) {
    final appState = Provider.of<AppState>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('구매 확인'),
        content: Text('$name을(를) 구매하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              final success = appState.buyItem(name, price);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(success ? '구매 성공' : '구매 실패'),
                  content: Text(
                    success
                        ? '$name을(를) 구매했습니다!\n보유 수량: ${appState.getItemCount(name)}개'
                        : appState.canAfford(price)
                        ? '해당 아이템은 최대 10개까지 보유할 수 있습니다.'
                        : '코인이 부족합니다.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('확인'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('예'),
          ),
        ],
      ),
    );
  }
}
