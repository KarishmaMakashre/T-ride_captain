import 'package:flutter/material.dart';


class StoreHomeScreen extends StatefulWidget {
  const StoreHomeScreen({super.key});

  @override
  State<StoreHomeScreen> createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
  int _selectedIndex = 0;
  final List<Order> _orders = [
    Order(
      orderNo: '#11250',
      customerName: 'Anna Sharma',
      status: OrderStatus.pickupPending,
      pickupCenter: 'Pickup Center: 1',
      address: 'Hotels Store, 20/8, Main Road, Andheri West 400069',
      store: 'Store 1',
      weight: '5.0g',
      ops: 'Ops: 2',
      amount: 2300,
      isPaid: true,
      deliveryPickupBy: 'Temsova',
      deliveryTime: '5:30 PM, Thu, 26/08/2023',
      timeLeft: '10:41 hrs',
    ),
    Order(
      orderNo: '#11251',
      customerName: 'Rohan Lobo',
      status: OrderStatus.pickupFailed,
      pickupCenter: 'Pickup Center: 2',
      address: 'Anand Sam, 25/4C, Andheri East 400069',
      store: 'Store 1',
      weight: '3.5g',
      ops: 'Ops: 1',
      amount: 1800,
      isPaid: false,
    ),
    Order(
      orderNo: '#11252',
      customerName: 'Amit Patel',
      status: OrderStatus.pickupReached,
      pickupCenter: 'Pickup Center: 3',
      address: '201/A, Avenue Road, New Juhu, Andheri 400068',
      store: 'Store 1',
      weight: '7.2g',
      ops: 'Ops: 3',
      amount: 3500,
      isPaid: true,
    ),
    Order(
      orderNo: '#11251',
      customerName: 'Priya Singh',
      status: OrderStatus.deliveryFailed,
      address: '302/B, SV Road, Bandra West 400050',
      store: 'Store 1',
      weight: '4.0g',
      ops: 'Ops: 2',
      amount: 2100,
      isPaid: true,
    ),
    Order(
      orderNo: '#11253',
      customerName: 'Rajesh Kumar',
      status: OrderStatus.delivered,
      address: '45/C, Hill Road, Bandra 400050',
      store: 'Store 1',
      weight: '6.5g',
      ops: 'Ops: 3',
      amount: 2900,
      isPaid: true,
    ),
    Order(
      orderNo: '#11250',
      customerName: 'Neha Gupta',
      status: OrderStatus.deliveryPending,
      address: '78/D, Linking Road, Khar 400052',
      store: 'Store 1',
      weight: '2.5g',
      ops: 'Ops: 1',
      amount: 1500,
      isPaid: false,
    ),
    Order(
      orderNo: '#11252',
      customerName: 'Suresh Nair',
      status: OrderStatus.deliveryReached,
      address: '120/E, Carter Road, Bandra 400050',
      store: 'Store 1',
      weight: '8.0g',
      ops: 'Ops: 4',
      amount: 4200,
      isPaid: true,
    ),
  ];

  final List<Store> _stores = [
    Store(name: 'Store 1', orders: 7),
    Store(name: 'Store 1.1', orders: 3),
    Store(name: 'Store 2', orders: 5),
    Store(name: 'Store 3', orders: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              _stores[_selectedIndex].name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${_stores[_selectedIndex].orders} Orders',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Date Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wed',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '24/08/2023',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue[100]!),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.store,
                        size: 16,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Store',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Store Tabs
          Container(
            height: 60,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _stores.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 3,
                          color: _selectedIndex == index
                              ? const Color(0xFF2196F3)
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _stores[index].name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: _selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _selectedIndex == index
                                ? const Color(0xFF2196F3)
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_stores[index].orders} Orders',
                          style: TextStyle(
                            fontSize: 10,
                            color: _selectedIndex == index
                                ? const Color(0xFF2196F3)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Orders List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(_orders[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        selectedItemColor: const Color(0xFF2196F3),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order No. ${order.orderNo}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(order.status),
                    style: TextStyle(
                      color: _getStatusColor(order.status),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Customer Info
            if (order.customerName.isNotEmpty) ...[
              Text(
                order.customerName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Pickup Center
            if (order.pickupCenter.isNotEmpty) ...[
              Text(
                order.pickupCenter,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
            ],

            // Address
            Text(
              order.address,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 12),

            // Store, Weight, Ops Details
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.store,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.weight,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        order.ops,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.isPaid ? 'Paid' : 'Unpaid',
                        style: TextStyle(
                          fontSize: 12,
                          color: order.isPaid ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Amount:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '₹${order.amount}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            // Additional Info (for detailed view)
            if (order.deliveryPickupBy.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              
              // Delivery Pickup By
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Delivery Pickup By:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order.deliveryPickupBy,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Delivery Time
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order.deliveryTime,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Time Left
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[100]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TIME LEFT:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      order.timeLeft,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Update Status Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _getStatusText(order.status),
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: [
                      'Pickup Pending',
                      'Pickup Failed',
                      'Pickup Reached',
                      'Delivery Failed',
                      'Delivered',
                      'Delivery Pending',
                      'Delivery Reached',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Handle status update
                    },
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Confirm Pickup Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Confirm Pickup',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pickupPending:
        return Colors.orange;
      case OrderStatus.pickupFailed:
        return Colors.red;
      case OrderStatus.pickupReached:
        return Colors.blue;
      case OrderStatus.deliveryFailed:
        return Colors.red;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.deliveryPending:
        return Colors.orange;
      case OrderStatus.deliveryReached:
        return Colors.purple;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pickupPending:
        return 'Pickup Pending';
      case OrderStatus.pickupFailed:
        return 'Pickup Failed';
      case OrderStatus.pickupReached:
        return 'Pickup Reached';
      case OrderStatus.deliveryFailed:
        return 'Delivery Failed';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.deliveryPending:
        return 'Delivery Pending';
      case OrderStatus.deliveryReached:
        return 'Delivery Reached';
    }
  }
}

class Order {
  final String orderNo;
  final String customerName;
  final OrderStatus status;
  final String pickupCenter;
  final String address;
  final String store;
  final String weight;
  final String ops;
  final int amount;
  final bool isPaid;
  final String deliveryPickupBy;
  final String deliveryTime;
  final String timeLeft;

  Order({
    required this.orderNo,
    this.customerName = '',
    required this.status,
    this.pickupCenter = '',
    required this.address,
    required this.store,
    required this.weight,
    required this.ops,
    required this.amount,
    required this.isPaid,
    this.deliveryPickupBy = '',
    this.deliveryTime = '',
    this.timeLeft = '',
  });
}

enum OrderStatus {
  pickupPending,
  pickupFailed,
  pickupReached,
  deliveryFailed,
  delivered,
  deliveryPending,
  deliveryReached,
}

class Store {
  final String name;
  final int orders;

  Store({required this.name, required this.orders});
}