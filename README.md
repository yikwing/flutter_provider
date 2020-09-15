# provider 状态管理

## 引入



[下载依赖](https://pub.dev/packages/provider)

```yaml
dependencies:
  flutter:
    sdk: flutter

  provider: ^4.3.2+1 
```



## 创建DataModel

```dart
class CountModel extends ChangeNotifier {
  int _count = 0;
  int _sum = 0;
  int _num = 1;

  int get count => _count;

  int get sum => _sum;

  int get num => _num;

  addCount(int a) {
    _count += a;

    notifyListeners();
  }

  addSum() {
    _sum++;

    notifyListeners();
  }

  addNum() {
    _num = _num * 2;

    notifyListeners();
  }
}
```

## 管理数据之Provider.of

```dart
var countModel = Provider.of<CountModel>(context);
```

- Provider.of<T>(context)：用于需要根据数据的变化而自动刷新的场景
-  Provider.of<T>(context, listen: false)：用于只需要触发Model中的操作而不关心刷新的场景
- T watch<T>()
- T read<T>()

```dart
Text('watch: ${context.watch<TestModel>().value}', style: style)

RaisedButton(
  onPressed: () => context.read<TestModel>().add(),
  child: Text('add'),
),
```

## 管理数据之Consumer

```dart
Consumer<TestModel>(
	builder: (BuildContext context, value, Widget child) {
    return Text('Model data: ${value.value}',style: style,);
  },
),
```

## 管理数据之Consumer

- 直接使用 `Selector Widget`

```dart
 Selector<TestModel, int>(
      selector: (context, value) => value.count,
      builder: (BuildContext context, value, Widget child) {
        return Container(
          color: Colors.redAccent,
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('ChildA', style: style),
              Text('Model data: $value', style: style),
              RaisedButton(
                onPressed: () => context.read<TestModel>().addA(),
                child: Text('add'),
              ),
            ],
          ),
        );
      },
 );
```

- 使用扩展函数

```dart
 Builder(
            builder: (BuildContext context) {
              return Text(
                'Model data: ${context.select((TestModel value) => value.modelValueB)}',
                style: style,
              );
            },
          ),
```



## Consumer 使用Tuple 多筛选

下载 [tuple依赖](https://pub.dev/packages/tuple)

```dart
selector: (context, value) => Tuple2(value.sum, value.num),
      builder: (context, value, child) {
        return Container(
          color: Colors.blueAccent,
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Child2', style: style),
              Text('Model data: ${value.item1} ====  ${value.item2}',
                  style: style),
              RaisedButton(
                onPressed: () {
                  context.read<CountModel>().addSum();
                  context.read<CountModel>().addNum();
                },
                child: child,
              ),
            ],
          ),
        );
```


