import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'services/weather_service.dart';

void main() => runApp(const InternshipApp());

class ThemeController extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  void toggle() { mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light; notifyListeners(); }
}

class InternshipApp extends StatefulWidget {
  const InternshipApp({super.key});
  @override State<InternshipApp> createState() => _InternshipAppState();
}
class _InternshipAppState extends State<InternshipApp> {
  final theme = ThemeController();
  @override void initState() { super.initState(); theme.addListener(() => setState(() {})); }
  @override void dispose() { theme.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter Internship Portfolio', debugShowCheckedModeBanner: false,
    themeMode: theme.mode,
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo, brightness: Brightness.light),
    darkTheme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo, brightness: Brightness.dark),
    home: HomeScreen(theme: theme),
  );
}

class HomeScreen extends StatelessWidget {
  final ThemeController theme;
  const HomeScreen({super.key, required this.theme});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Flutter Internship Portfolio'), actions: [
      IconButton(onPressed: theme.toggle, icon: Icon(theme.mode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode))
    ]),
    drawer: const AppDrawer(),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      const Text('SkillNexis Mobile App Dev (Flutter)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8), const Text('Weeks 1–4 complete solution portfolio'), const SizedBox(height: 20),
      _weekCard(context, 1, 'Dart & Flutter Fundamentals', Icons.flutter_dash, const Week1Screen()),
      _weekCard(context, 2, 'Layouts, Navigation & State', Icons.dashboard_customize, const Week2Screen()),
      _weekCard(context, 3, 'APIs, Storage & Firebase-ready services', Icons.cloud, const Week3Screen()),
      _weekCard(context, 4, 'Student Attendance Capstone', Icons.school, const Week4Screen()),
    ]),
  );
  Widget _weekCard(BuildContext c, int n, String title, IconData icon, Widget page) => Card(
    child: ListTile(leading: CircleAvatar(child: Icon(icon)), title: Text('Week $n'), subtitle: Text(title), trailing: const Icon(Icons.arrow_forward_ios), onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => page))),
  );
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override Widget build(BuildContext context) => Drawer(child: ListView(children: [
    const DrawerHeader(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.flutter_dash, size: 48), SizedBox(height: 10), Text('Internship Solutions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))])),
    ListTile(title: const Text('Home'), onTap: () { Navigator.popUntil(context, (route) => route.isFirst); }),
    _item(context, 'Week 1', const Week1Screen()), _item(context, 'Week 2', const Week2Screen()), _item(context, 'Week 3', const Week3Screen()), _item(context, 'Week 4', const Week4Screen()),
  ]));
  Widget _item(BuildContext c, String label, Widget page) => ListTile(title: Text(label), onTap: () { Navigator.pop(c); Navigator.push(c, MaterialPageRoute(builder: (_) => page)); });
}

class Week1Screen extends StatelessWidget {
  const Week1Screen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Week 1 — Fundamentals')), body: ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Hello Flutter', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
    const Text('Name: Internship Learner\nCourse: Mobile App Development (Flutter)'), const SizedBox(height: 16),
    const ProfileCard(), const SizedBox(height: 16), const BusinessCard(), const SizedBox(height: 16),
    FilledButton.icon(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hot reload: save a Dart file while flutter run is active.'))), icon: const Icon(Icons.refresh), label: const Text('Practice Hot Reload')),
  ]));
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});
  @override Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
    const CircleAvatar(radius: 44, backgroundImage: NetworkImage('https://picsum.photos/seed/flutter/160')), const SizedBox(height: 12),
    const Text('Internship Learner', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const Text('Flutter Developer'), const SizedBox(height: 12),
    const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Chip(label: Text('Dart')), Chip(label: Text('Flutter')), Chip(label: Text('Firebase'))]),
    const SizedBox(height: 12), FilledButton(onPressed: null, child: Text('Contact')),
  ])));
}
class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key});
  @override Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
    const CircleAvatar(radius: 34, child: Icon(Icons.business)), const SizedBox(width: 14),
    const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Flutter Studio', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text('Mobile App Developer'), Text('hello@example.com'), Text('+91 90000 00000')])),
    IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
  ])));
}

class Week2Screen extends StatefulWidget { const Week2Screen({super.key}); @override State<Week2Screen> createState() => _Week2ScreenState(); }
class _Week2ScreenState extends State<Week2Screen> {
  int index = 0; final tasks = <String>[]; final done = <bool>[];
  @override Widget build(BuildContext context) {
    final pages = [TodoScreen(tasks: tasks, done: done, onChanged: () => setState(() {})), const ExpenseTrackerScreen(), const CalculatorScreen()];
    return Scaffold(
      appBar: AppBar(title: const Text('Week 2 — Layout & Navigation'), actions: [IconButton(tooltip: 'Login demo', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())), icon: const Icon(Icons.login)), IconButton(tooltip: 'Form demo', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ValidatedFormScreen())), icon: const Icon(Icons.edit_note))]),
      drawer: const AppDrawer(), body: pages[index],
      bottomNavigationBar: NavigationBar(selectedIndex: index, onDestinationSelected: (i) => setState(() => index = i), destinations: const [NavigationDestination(icon: Icon(Icons.checklist), label: 'Todo'), NavigationDestination(icon: Icon(Icons.account_balance_wallet), label: 'Expenses'), NavigationDestination(icon: Icon(Icons.calculate), label: 'Calculator')]),
      floatingActionButton: index == 0 ? FloatingActionButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskScreen())).then((v) { if (v is String && v.isNotEmpty) setState(() { tasks.add(v); done.add(false); }); }), child: const Icon(Icons.add)) : null,
    );
  }
}

class TodoScreen extends StatelessWidget {
  final List<String> tasks; final List<bool> done; final VoidCallback onChanged;
  const TodoScreen({super.key, required this.tasks, required this.done, required this.onChanged});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(12), children: [
    const Text('Two-screen To-Do List', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 8),
    if (tasks.isEmpty) const Text('No tasks yet. Tap + to add one.'),
    ...List.generate(tasks.length, (i) => CheckboxListTile(value: done[i], title: Text(tasks[i]), onChanged: (v) { done[i] = v ?? false; onChanged(); }, secondary: IconButton(icon: const Icon(Icons.delete), onPressed: () { tasks.removeAt(i); done.removeAt(i); onChanged(); }))),
  ]);
}
class AddTaskScreen extends StatefulWidget { const AddTaskScreen({super.key}); @override State<AddTaskScreen> createState() => _AddTaskScreenState(); }
class _AddTaskScreenState extends State<AddTaskScreen> { final c = TextEditingController(); @override void dispose(){c.dispose();super.dispose();} @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Add Task')),body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[TextField(controller:c,decoration:const InputDecoration(labelText:'Task',border:OutlineInputBorder())),const SizedBox(height:12),FilledButton(onPressed:()=>Navigator.pop(context,c.text.trim()),child:const Text('Save'))]))); }

class ExpenseTrackerScreen extends StatefulWidget { const ExpenseTrackerScreen({super.key}); @override State<ExpenseTrackerScreen> createState()=>_ExpenseTrackerScreenState(); }
class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final expenses = <Map<String, dynamic>>[];
  @override Widget build(BuildContext context) {
    final total = expenses.fold<double>(0, (s, e) => s + (e['amount'] as double));
    return Padding(padding: const EdgeInsets.all(12), child: Column(children: [
      Card(child: ListTile(title: const Text('Dashboard'), subtitle: Text('Total: ₹${total.toStringAsFixed(2)}'))),
      Expanded(child: expenses.isEmpty ? const Center(child: Text('No expenses yet.')) : ListView.builder(itemCount: expenses.length, itemBuilder: (_, i) => ListTile(title: Text(expenses[i]['title'] as String), trailing: Text('₹${expenses[i]['amount']}')))),
      FilledButton(onPressed: () => showDialog(context: context, builder: (_) => _ExpenseDialog(onAdd: (e) => setState(() => expenses.add(e)))), child: const Text('Add Expense')),
    ]));
  }
}
class _ExpenseDialog extends StatefulWidget { final ValueChanged<Map<String,dynamic>> onAdd; const _ExpenseDialog({required this.onAdd}); @override State<_ExpenseDialog> createState()=>_ExpenseDialogState(); }
class _ExpenseDialogState extends State<_ExpenseDialog> {
  final t = TextEditingController(); final a = TextEditingController();
  @override Widget build(BuildContext c) => AlertDialog(title: const Text('Add Expense'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller:t,decoration:const InputDecoration(labelText:'Title')),TextField(controller:a,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Amount'))]), actions: [TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),FilledButton(onPressed:(){final amount=double.tryParse(a.text);if(t.text.trim().isEmpty||amount==null)return;widget.onAdd({'title':t.text.trim(),'amount':amount});Navigator.pop(c);},child:const Text('Add'))]);
}

class CalculatorScreen extends StatefulWidget { const CalculatorScreen({super.key}); @override State<CalculatorScreen> createState()=>_CalculatorScreenState(); }
class _CalculatorScreenState extends State<CalculatorScreen>{final a=TextEditingController(),b=TextEditingController();String result='0';void calc(String op){final x=double.tryParse(a.text),y=double.tryParse(b.text);if(x==null||y==null)return;setState(()=>result=switch(op){'+'=>'${x+y}','-'=>'${x-y}','×'=>'${x*y}','÷'=>y==0?'Cannot divide by zero':'${x/y}',_=>'0'});} @override Widget build(BuildContext c)=>Padding(padding:const EdgeInsets.all(16),child:Column(children:[Text('Result: $result',style:const TextStyle(fontSize:28,fontWeight:FontWeight.bold)),TextField(controller:a,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'First number')),TextField(controller:b,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Second number')),Wrap(spacing:8,children:['+','-','×','÷'].map((o)=>FilledButton(onPressed:()=>calc(o),child:Text(o))).toList())]));}

class LoginScreen extends StatefulWidget { const LoginScreen({super.key}); @override State<LoginScreen> createState()=>_LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen>{final email=TextEditingController(),pass=TextEditingController();@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Login')),body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[TextField(controller:email,decoration:const InputDecoration(labelText:'Email')),TextField(controller:pass,obscureText:true,decoration:const InputDecoration(labelText:'Password')),FilledButton(onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>const SimpleHomeScreen())),child:const Text('Login'))])));}
class SimpleHomeScreen extends StatelessWidget{const SimpleHomeScreen({super.key});@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Home')),body:const Center(child:Text('Login → Home navigation completed.')));}
class ValidatedFormScreen extends StatefulWidget{const ValidatedFormScreen({super.key});@override State<ValidatedFormScreen> createState()=>_ValidatedFormScreenState();}
class _ValidatedFormScreenState extends State<ValidatedFormScreen>{final key=GlobalKey<FormState>();@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Validated Form')),body:Form(key:key,child:Padding(padding:const EdgeInsets.all(16),child:Column(children:[TextFormField(decoration:const InputDecoration(labelText:'Email'),validator:(v)=>v==null||!v.contains('@')?'Enter a valid email':null),TextFormField(decoration:const InputDecoration(labelText:'Name'),validator:(v)=>v==null||v.trim().isEmpty?'Name is required':null),FilledButton(onPressed:()=>key.currentState!.validate(),child:const Text('Validate'))])));}

class Week3Screen extends StatelessWidget { const Week3Screen({super.key}); @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Week 3 — Backend & APIs')),body:ListView(padding:const EdgeInsets.all(16),children:[_nav(context,'Public API + JSON + ListView',const ApiDemoScreen()),_nav(context,'SharedPreferences',const StorageDemoScreen()),_nav(context,'Weather Forecast pattern',const WeatherScreen()),_nav(context,'Firebase Auth / Firestore',const FirebaseSetupScreen())]); Widget _nav(BuildContext c,String t,Widget p)=>Card(child:ListTile(title:Text(t),trailing:const Icon(Icons.arrow_forward),onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>p))));}

class ApiDemoScreen extends StatefulWidget{const ApiDemoScreen({super.key});@override State<ApiDemoScreen> createState()=>_ApiDemoScreenState();}
class _ApiDemoScreenState extends State<ApiDemoScreen>{List<dynamic> posts=[];bool loading=true;String? error;@override void initState(){super.initState();load();}Future<void> load()async{try{final r=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));if(r.statusCode!=200)throw Exception('HTTP ${r.statusCode}');setState(()=>posts=jsonDecode(r.body) as List<dynamic>);}catch(e){setState(()=>error=e.toString());}finally{setState(()=>loading=false);}}@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Public API Demo')),body:loading?const Center(child:CircularProgressIndicator()):error!=null?Center(child:Text(error!)):ListView.builder(itemCount:posts.length,itemBuilder:(_,i){final p=posts[i] as Map<String,dynamic>;return ListTile(leading:CircleAvatar(child:Text('${p['id']}')),title:Text(p['title']),subtitle:Text(p['body']));}));}

class StorageDemoScreen extends StatefulWidget{const StorageDemoScreen({super.key});@override State<StorageDemoScreen> createState()=>_StorageDemoScreenState();}
class _StorageDemoScreenState extends State<StorageDemoScreen>{int count=0;@override void initState(){super.initState();load();}Future<void>load()async{final p=await SharedPreferences.getInstance();setState(()=>count=p.getInt('launch_count')??0);}Future<void>inc()async{final p=await SharedPreferences.getInstance();count++;await p.setInt('launch_count',count);setState((){});} @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('SharedPreferences')),body:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text('Saved counter: $count',style:const TextStyle(fontSize:24)),FilledButton(onPressed:inc,child:const Text('Increment & Save'))]));}

class WeatherScreen extends StatefulWidget{const WeatherScreen({super.key});@override State<WeatherScreen> createState()=>_WeatherScreenState();}
class _WeatherScreenState extends State<WeatherScreen>{final city=TextEditingController(text:'Kolkata');Map<String,dynamic>? data;String? error;bool loading=false;final service=WeatherService();Future<void>load()async{setState(()=>loading=true);try{data=await service.fetchWeather(city.text.trim(),const String.fromEnvironment('OPENWEATHER_API_KEY'));error=null;}catch(e){error=e.toString();}finally{setState(()=>loading=false);}}@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Weather Forecast')),body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[TextField(controller:city,decoration:const InputDecoration(labelText:'City',border:OutlineInputBorder())),const SizedBox(height:10),FilledButton(onPressed:loading?null:load,child:const Text('Fetch Weather')),const SizedBox(height:20),if(loading)const CircularProgressIndicator(),if(error!=null)Text(error!),if(data!=null)...[Text('${data!['name']} — ${data!['main']['temp']} °C',style:const TextStyle(fontSize:24)),Text('Humidity: ${data!['main']['humidity']}%'),Text('Condition: ${data!['weather'][0]['description']}')]]));}

class FirebaseSetupScreen extends StatelessWidget{const FirebaseSetupScreen({super.key});@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Firebase Integration')),body:const Padding(padding:EdgeInsets.all(16),child:Text('Firebase Auth and Firestore service classes are included in lib/services. Configure Firebase with flutterfire configure, initialize Firebase in main(), enable Email/Password Auth, and create Firestore rules before enabling the backend. No credentials are committed to this repository.')));}

class Week4Screen extends StatefulWidget{const Week4Screen({super.key});@override State<Week4Screen> createState()=>_Week4ScreenState();}
class _Week4ScreenState extends State<Week4Screen>{final students=['Aarav','Diya','Ishaan','Meera'];final Map<String,Set<String>> attendance={};String dateKey=DateTime.now().toIso8601String().split('T').first;void toggle(String student){setState((){attendance.putIfAbsent(dateKey,()=>{});final s=attendance[dateKey]!;s.contains(student)?s.remove(student):s.add(student);});} @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Week 4 — Student Attendance'),actions:[IconButton(onPressed:()=>showDatePicker(context:c,initialDate:DateTime.now(),firstDate:DateTime(2020),lastDate:DateTime(2035)).then((d){if(d!=null)setState(()=>dateKey=d.toIso8601String().split('T').first);}),icon:const Icon(Icons.calendar_month))]),body:ListView(padding:const EdgeInsets.all(12),children:[Text('Date: $dateKey',style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold)),const SizedBox(height:8),...students.map((s)=>Card(child:CheckboxListTile(value:attendance[dateKey]?.contains(s)??false,onChanged:(_)=>toggle(s),title:Text(s),subtitle:Text((attendance[dateKey]?.contains(s)??false)?'Present':'Absent')))),Card(child:ListTile(title:const Text('Capstone features'),subtitle:const Text('Admin/student role concept • date-wise records • local state • dark mode • Firebase-ready data layer')))]);}
