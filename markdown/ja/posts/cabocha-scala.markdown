## このページでの前提

1. CaboCha のインストールが済んでいること。
2. OS が Linux（特に RHEL 7 または Ubuntu 14）であること。

## 準備

インストールのときに使ったソースコードが残っていればそれを使ってください。
捨ててしまった場合は https://github.com/taku910/cabocha からクローンしてください。

```language-bash
git clone https://github.com/taku910/cabocha.git
```

次に `cabocha/java/Makefile` の `INCLUDE` を、使っている Java に合わせて変更します。
どの Java を使っているのか分からない場合は、
`which java` や `update-alternatives` などで調べてください。

```language-makefile
# …
# Example
INCLUDE=/usr/lib/jvm/java-8-oracle/include
# …
```

設定を書き換えたら `cabocha/java` ディレクトリで `make` と打ち込んでコンパイルします。

## 利用例

実際にプロジェクトを作成して使ってみることにします。
まず、先ほど生成された `CaboCha.jar` と `libCaboCha.so lib` を
プロジェクトの `lib` ディレクトリにコピーします。

```language-bash
mkdir <project_root>
cd <project_root>
echo 'scalaVersion := "2.12.0"' > build.sbt
mkdir lib
cp path/to/cabocha/java/CaboCha.jar lib/
cp path/to/cabocha/java/libCaboCha.so lib/
```

次に `Parser` の内容を `<project_root>/src/main/scala/cabochawrapper/Parser.scala` に定義します。

```language-scala
package cabochawrapper

import org.chasen.cabocha.{
  Parser => CaboChaParser,
  Chunk => CaboChaChunk,
  Tree => CaboChaTree,
  Token => CaboChaToken,
  FormatType
}

case class Token(
  surface: String,
  normalizedSurface: String,
  feature: String,
  namedEntity: Option[String],
  additionalInfo: Option[String]
)

case class Chunk(
  score: Float,
  link: Int,
  additionalInfo: Option[String],
  features: Seq[String],
  tokens: Seq[Token]
)

class Parser {

  try {
    System.loadLibrary("CaboCha")
  } catch {
    case _: UnsatisfiedLinkError => {
      println("Make sure that `CaboCha.jar` and `libCaboCha.so` are in `lib`.")
      System.exit(1)
    }
  }

  val parser = new CaboChaParser()

  def parseToChunks(s: String): Seq[Chunk] = {
    val tree: CaboChaTree = this.parser.parse(s)
    (0.toLong until tree.chunk_size()).map { i =>
      val chunk = tree.chunk(i)
      val features = (0.toLong until chunk.getFeature_list_size()).map { i =>
        chunk.feature_list(i)
      }
      val n = chunk.getToken_pos()
      val N = n + chunk.getToken_size()
      val tokens = (n until N).map { i =>
        tree.token(i).toToken()
      }
      Chunk(score = chunk.getScore(),
            link = chunk.getLink(),
            tokens = tokens,
            additionalInfo = Option(chunk.getAdditional_info()).filter(_ != null),
            features = features)
    }
  }

  implicit class ExtendedCaboChaToken(token: CaboChaToken) {
    def toToken(): Token =
      Token(surface = token.getSurface(),
            normalizedSurface = token.getNormalized_surface(),
            feature = token.getFeature(),
            namedEntity = Option(token.getNe()).filter(_ != null),
            additionalInfo = Option(token.getAdditional_info()).filter(_ != null)
      )
  }

}
```

最後に `<project_root>/src/main/scala/Main.scala` を編集して、
先ほど定義した `Parser` を呼び出すようにします。

```language-scala
package cabochawrapper

object Main extends App {

  val parser = new Parser()
  val s = "太郎は二郎にこの本を渡した．"

  parser.parseToChunks(s).zipWithIndex.foreach { case (c, i) =>
    c.tokens.zipWithIndex.foreach { case (t, j) =>
      println(t.normalizedSurface)
    }
  }
}
```

これを `sbt run` などで実行してください。
