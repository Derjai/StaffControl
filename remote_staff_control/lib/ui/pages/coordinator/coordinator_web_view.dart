import 'package:flutter/material.dart';

class CoordinatorWebView extends StatelessWidget {
  const CoordinatorWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome Back Coordinator!'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          UserAccountsDrawerHeader(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            accountName: const Text('Navigation Menu'),
            accountEmail: null,
            currentAccountPicture: null,
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Manage Clients'),
            onTap: () {
              Navigator.pushNamed(context, '/coordinator/clients');
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('Manage Support Users'),
            onTap: () {
              Navigator.pushNamed(context, '/coordinator/us');
            },
          ),
          ListTile(
            leading: const Icon(Icons.reviews),
            title: const Text('Rate Reports'),
            onTap: () {
              Navigator.pushNamed(context, '/coordinator/reports');
            },
          ),
        ])),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const ListTile(
                          title: null, //Text(reports[index].title),
                        );
                      }))
            ],
          ),
        ));
  }
}
