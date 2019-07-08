import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "第一个App",
      theme: new ThemeData(
        primaryColor: Colors.white
      ),
      home: new RandomWords(),
    );
  }

}

class RandomWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordsState();
  }

}
class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text("列表"),
        ),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved(){
      Navigator.of(context).push(new MaterialPageRoute(builder: (context){
        final tiles = _saved.map((pair){
          return new ListTile(title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),);
        });
        final divided = ListTile.divideTiles(tiles: tiles,context: context).toList();
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("收藏列表"),
          ),
          body: new ListView(
            children: divided,
          ),
        );
      }));
  }

  Widget _buildSuggestions (){
    return new ListView.builder(padding:const EdgeInsets.all(18.0),itemBuilder: (context,i){
      if(i.isOdd) return new Divider();
      final index = i ~/2;
      if(index >= _suggestions.length){
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow (WordPair wordPair){
    final saved = _saved.contains(wordPair);
    return new ListTile(
      title: new Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        saved ? Icons.favorite : Icons.favorite_border,
        color: saved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(saved){
            _saved.remove(wordPair);
          }else{
            _saved.add(wordPair);
          }
        });
      },
    );
  }

}