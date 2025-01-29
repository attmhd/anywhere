import 'package:flutter/material.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:myapp/widgets/bottom_navigation.dart';
import 'package:intl/intl.dart';
import 'package:myapp/widgets/custom_alert.dart';


class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final String userId = user?['user_id'] ?? 'Guest';
    final String userName = user?['fullname'] ?? 'Guest';

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              FutureBuilder<Map<String, dynamic>>(
                future: getSaldo(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('No saldo found for the user');
                  }

                  final saldo = snapshot.data!['balance'];
                  final saldoId = snapshot.data!['id'];

                  return FutureBuilder<List<Map<String, dynamic>>>(
                    future: getTopUpHistory(saldoId),
                    builder: (context, topUpSnapshot) {
                      if (topUpSnapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (topUpSnapshot.hasError) {
                        return Text('Error: ${topUpSnapshot.error}');
                      }

                      return Column(
                        children: [
                          _buildBalanceCard(context, saldo, userName, saldoId),
                          const SizedBox(height: 20),
                          _buildRecentTransactionsHeader(),
                          const SizedBox(height: 10),
                          _buildTransactionList(topUpSnapshot.data!),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getSaldo(String userId) async {
    final response = await Supabase.instance.client
        .from('saldo')
        .select('balance, id')
        .eq('user_id', userId)
        .single();
    return response;
  }

  Future<List<Map<String, dynamic>>> getTopUpHistory(int saldoId) async {
    final response = await Supabase.instance.client
        .from('top_up')
        .select()
        .eq('saldo_id', saldoId)
        .order('created_at', ascending: false)
        .limit(5);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> insertTopUp(int saldoId, int amount) async {
    final response = await Supabase.instance.client.from('top_up').insert({
      'saldo_id': saldoId,
      'amount': amount,
      'created_at': DateTime.now().toIso8601String(),
    });

    if (response.error != null) {
      throw Exception('Failed to insert top-up: ${response.error!.message}');
    }
  }

  Widget _buildBalanceCard(BuildContext context, dynamic saldo, String userName, int saldoId) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('mosalah.jpg'),
              ),
              const SizedBox(width: 10),
              Text(
                'Hello!\n$userName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Current Balance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'IDR ${saldo.toString()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _showTopUpModal(context, saldoId, () {
                  setState(() {});
                }),
                icon: const Icon(Icons.add),
                label: const Text('Add Balance'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.swap_horiz),
                label: const Text('Change Card'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSuccesAlert(){
    showCustomAlert(context: context, title: "Succes", icon: Icons.check_circle, iconColor: Colors.green , message: "Top up succes", onPressed: () {
      Navigator.pushNamed(context, '/topup');
    });
  }

  void _showTopUpModal(BuildContext context, int saldoId, VoidCallback onSuccess) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Top Up Balance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixText: 'IDR ',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: ()  {
                        final amount = int.tryParse(amountController.text);
                         if (amount != null) {
                           insertTopUp(saldoId, amount);
                           _showSuccesAlert();
                         } else {
                           // Handle the case where amount is null
                           showCustomAlert(
                             context: context,
                             title: "Error",
                             icon: Icons.error,
                             iconColor: Colors.red,
                             message: "Please enter a valid amount",
                             onPressed: () {
                               Navigator.pop(context);
                             },
                           );
                         }
                        _showSuccesAlert();
                        
                      },
                      child: const Text('Top Up'),
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

  Widget _buildRecentTransactionsHeader() {
    return const Text(
      'Recent Transactions',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTransactionList(List<Map<String, dynamic>> topUpHistory) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: topUpHistory.length,
      itemBuilder: (context, index) {
        final transaction = topUpHistory[index];
        return ListTile(
          leading: const Icon(Icons.monetization_on),
          title: Text('Transaction ${index + 1}'),
          subtitle: Text(
            DateFormat('dd MMM yyyy HH:mm').format(DateTime.parse(transaction['created_at'])),
          ),
          trailing: Text('IDR ${transaction['amount']}'),
        );
      },
    );
  }
}
