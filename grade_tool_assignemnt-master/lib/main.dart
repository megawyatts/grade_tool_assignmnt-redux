import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grade_tool_assignment/grade_calculator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create:(context)=>MyAppState(),
      child: MaterialApp(
        title:'Grade Tool',
        theme: ThemeData(
        useMaterial3:true,
        colorScheme: ColorScheme.fromSeed(seedColor:Colors.lightBlue),),
        home:const MyHomeApp()),
    );
  }
}

class MyAppState extends ChangeNotifier{
  String userGradeLetter='';
  final gradeCalculator=GradeCalculator();
  void calculateGrade(TextEditingController gradeController){
    String gradeInputAsString= gradeController.text;
    int gradeInputAsInt=int.parse(gradeInputAsString);
    userGradeLetter=gradeCalculator.defineGrade(gradeInputAsInt);
    notifyListeners();
  }
  String updateGrade(){
    String resultText=('Your grade is a $userGradeLetter');
    notifyListeners();
    return (resultText);
  }
}
class MyHomeApp extends StatelessWidget {
  const MyHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    var appState=context.watch<MyAppState>();
    TextEditingController gradeController= TextEditingController();
    Widget enterButton = Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          onPressed: () {
            appState.calculateGrade(gradeController);
          },
          child: const Text("Enter"),
        ));
    Widget textSection = Container(
        padding: const EdgeInsets.all(22),
        child: const Text(
          'Enter your grade in number form, then press enter and '
          'the calculator will tell you what your letter grade is.',
          softWrap: true,
        ));
    Widget textEnterForm = TextFormField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(labelText: 'Enter your grade score'),
      controller: gradeController,
    );
    Widget outputForm = Column(
      children: [
        ElevatedButton(onPressed:(){
        }, child:
        Container(
            padding: const EdgeInsets.all(32),
            child: Text(appState.updateGrade()),),

    ),],);
    return MaterialApp(
      title: 'Grade Tool',
      home:Listener( child:Scaffold(
        appBar: AppBar(
          title: const Text('Grade Tool'),
        ),
        body: ListView(
          children: [
            textSection,
            textEnterForm,
            enterButton,
            outputForm,
          ],
        ),
      ),),
    );
  }
}
