import 'package:flutter/material.dart';

import '../controller/app_router.dart';
import '../models/Contact.dart';
import '../services/ContactService.dart';
import 'ContactDetail.dart';

class ContactsList extends StatefulWidget {
  _ContactsListState createState() => new _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactService contactService = new ContactService();
  Future<List<Contact>> _futureContacts;
  Future<List<Contact>> _futureFavorites;
  TextEditingController editingController = TextEditingController();

  Future refreshPage() async => setState(() {
        _futureContacts = contactService.getContacts();
        _futureFavorites = contactService.getFavorites();
      });

  @override
  void initState() {
    refreshPage();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: TabBarView(
            children: <Widget>[
              _buildBody(_futureContacts),
              _buildBody(_futureFavorites),
            ],
          ),
          drawer: _buildDrawer(),
          floatingActionButton: _buildFloatingButton(),
        ));
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.blue,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: refreshPage,
        )
      ],
      title: Text(
        "ContactsAPP",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      bottom: const TabBar(
        indicatorWeight: 5,
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.people_alt, size: 28),
          ),
          Tab(
            icon: Icon(Icons.star, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Ross", style: TextStyle(fontSize: 20)),
            accountEmail: Text("github.com/RossDiliberto",
                style: TextStyle(fontSize: 15)),
            currentAccountPicture: const CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          ListTile(
            title: Text("English"),
            leading: const Icon(Icons.language),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("github.com/RossDiliberto"),
            leading: const Icon(Icons.support_agent),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("v.1.0"),
            leading: const Icon(
              Icons.info,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Made with love by Ross Diliberto"),
            leading: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton.extended(
      icon: new Icon(Icons.person_add),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      label: Text('Add'),
      onPressed: () {
        Navigator.of(context).pushNamed(AppRouter.ADD).then((result) {
          if (result != null) {
            return ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(result, style: TextStyle(fontSize: 15)),
                action: SnackBarAction(
                  label: 'Update',
                  onPressed: refreshPage,
                ),
              ));
          }
          return refreshPage();
        });
      },
    );
  }

  Widget _buildBody(Future<List<Contact>> future) {
    return RefreshIndicator(
        onRefresh: refreshPage,
        child: Container(
            padding: EdgeInsets.all(5.0),
            child: FutureBuilder<List<Contact>>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot?.data?.isEmpty == true) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: Icon(
                            Icons.person_add,
                            color: Colors.blue,
                            size: 120,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Contact list empty',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount:
                            snapshot.data == null ? 0 : snapshot.data.length,
                        // ignore: missing_return
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              key: ValueKey(snapshot.data[index].id),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Colors.white,
                                  elevation: 1,
                                  child: ListTile(
                                    trailing: snapshot?.data[index]?.favorite ==
                                            true
                                        ? Icon(Icons.star,
                                            color: Colors.amber, size: 30)
                                        : Icon(Icons.star_outline, size: 25),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 25,
                                      child: Text(
                                          snapshot.data[index].firstname[0]
                                                  .toUpperCase() +
                                              snapshot.data[index].lastname[0]
                                                  .toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          )),
                                    ),
                                    title: Text(
                                        snapshot.data[index].firstname +
                                            " " +
                                            snapshot.data[index].lastname,
                                        style: TextStyle(
                                          fontSize: 18,
                                        )),
                                    subtitle: Text(snapshot.data[index].phone),
                                    onTap: null,
                                  )),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(
                                  AppRouter.DETAIL,
                                  arguments: ContactDetail(
                                    contactID: snapshot.data[index].id,
                                    favorite: snapshot.data[index].favorite,
                                  ),
                                )
                                    .then((result) {
                                  if (result != null) {
                                    return ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(SnackBar(
                                        content: Text(result,
                                            style: TextStyle(fontSize: 15)),
                                        action: SnackBarAction(
                                          label: 'Update',
                                          onPressed: refreshPage,
                                        ),
                                      ));
                                  }
                                  return refreshPage();
                                });
                              });
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                })));
  }
}
