import Text.Pandoc.Readers.Markdown (readMarkdown)
import Text.Pandoc.Writers.HTML (writeHtmlString)
import Text.Pandoc.Options (
    def,
    Extension(..),
    ReaderOptions(..),
    WriterOptions(..))
import qualified Data.Set as S

main :: IO ()
main =
    let
        readerOptions :: ReaderOptions
        readerOptions = def { readerExtensions = S.fromList [Ext_east_asian_line_breaks] }
        writerOptions :: WriterOptions
        writerOptions = def { writerExtensions = S.fromList [] }
        filepath :: FilePath
        filepath = "a.html"
    in
        case readMarkdown readerOptions "`a`" of
            Right pandoc ->
                writeFile filepath $ writeHtmlString writerOptions pandoc
            Left pandocError ->
                putStr $ show pandocError
