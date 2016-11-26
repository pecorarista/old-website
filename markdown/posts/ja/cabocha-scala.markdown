__前提__

+ CaboCha のインストールが済んでいること。
+ 使う OS は Linux（特に RHEL 7 または Ubuntu 14）を想定しています。

### 1. CaboCha のソースコードの取得

インストールのときに使ったソースコードが残っていればそれを使ってください。
捨ててしまった場合は https://github.com/taku910/cabocha からクローンしてください。

```bash
git clone https://github.com/taku910/cabocha.git
```

### 2. 設定

Makefile の `INCLUDE` を使っている Java に合わせて変更します。
どの Java を使っているのか分からない場合は、
`which java` や `update-java-alternatives` (`update-alternatives`) で調べてください。

```Makefile
# …
# Example
INCLUDE=/usr/lib/jvm/java-8-oracle/include
# …
```

### 3. コンパイル

`cabocha/java` ディレクトリで `make` と打ち込んでコンパイルします。


### 4. Scala からの利用例

実際にプロジェクトを作成して使ってみることにします。
まず、先ほど生成された `CaboCha.jar` と `libCaboCha.so lib` を
プロジェクトの `lib` ディレクトリにコピーします。

```bash
mkdir <project_root>
cd <project_root>
echo 'scalaVersion := "2.12.0"' > build.sbt
mkdir lib
cp path/to/cabocha/java/CaboCha.jar lib/
cp path/to/cabocha/java/libCaboCha.so lib/
```

次に、例えば以下のように `<project_root>/src/main/scala/Main.scala` を編集します。

```scala
import org.chasen.cabocha.{
  Parser,
  FormatType
}

object Main extends App {

  try {
    System.loadLibrary("CaboCha")
  } catch {
    case e: UnsatisfiedLinkError => {
      println("Make sure that `CaboCha.jar` and `libCaboCha.so` are in `lib`.")
      System.exit(1)
    }
  }

  val parser = new Parser()
  val s = "太郎は二郎にこの本を渡した．"
  val tree = parser.parse(s)
  print(tree.toString(FormatType.FORMAT_TREE))

}
```

これを `sbt run` で実行します。
次のような出力が得られたならば成功です。

```
  太郎は-------D
    二郎に-----D
        この-D |
          本を-D
        渡した．
EOS
```
