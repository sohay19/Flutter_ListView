import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

// REGION, MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Flutter ListView'),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

// REGION, RandomWordState
class RandomWordsState extends State<RandomWords> {
  // 변수 앞에 _가 붙으면 해당 파일안에서만 사용가능하다는 뜻
  final _suggestions = <WordPair>[]; // List
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Word List'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: _buildSuggestions(),
    );
  }

  // ListView 생성
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // i = 인덱스
        itemBuilder: (context, i) {
          // 영단어행+Divider행 한쌍, 0부터 시작하니까 홀수에 Divider
          if (i.isOdd) return Divider();
          // ~/ = 몫 반환, 단어 개수 파악가능 (Divider로 인해 2개가 한쌍의 단어)
          final index = i ~/ 2;
          // suggestions의 길이가 현재 준비된 List행보다 적으면 10개의 랜덤 영단어 추가
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  // ListView의 행을 생성하는 메소드
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

// REGION, RandomWords
// Stateful Widget = 변경가능한 상태를 가진 위젯
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}