import Control.Monad (when, unless)
import Data.Traversable (traverse)
import Data.Foldable (foldrM, traverse_)
import System.Directory (listDirectory, doesDirectoryExist)
import System.FilePath.Posix (replaceExtension, (</>))
import Text.Pandoc.Definition (Pandoc)
import Text.Pandoc.Error (PandocError)
import Text.Pandoc.Readers.Markdown (readMarkdown)
import Text.Pandoc.Writers.HTML (writeHtmlString)
import Text.Pandoc.Options (
    def,
    Extension(..),
    ReaderOptions(..),
    WriterOptions(..))
import qualified Data.Set as S

main :: IO ()
main = do
    xs <- getFilePaths [] "markdown"
    traverse_ putStrLn xs


getFilePaths :: [FilePath] -> FilePath -> IO [FilePath]
getFilePaths filePaths directory = do
    isDirectory <- doesDirectoryExist directory
    if not isDirectory then
        do
            return (directory : filePaths)
    else
        do
            xs <- listDirectory directory
            let fs = map (directory </>) xs
            getFilePaths filePaths (head fs)



replaceExtension' :: FilePath -> (FilePath, FilePath)
replaceExtension' filePath = (filePath, replaceExtension filePath "html")


defaultConverter :: FilePath -> FilePath -> IO ()
defaultConverter input output = do
    s <- readFile input
    case defaultReader s of
        Left pandocError -> print pandocError
        Right pandoc -> defaultWriter pandoc output


defaultReader :: String -> Either PandocError Pandoc
defaultReader s =
    let
        readerOptions :: ReaderOptions
        readerOptions = def { readerExtensions = S.fromList [Ext_east_asian_line_breaks] }
    in
        readMarkdown readerOptions s


defaultWriter :: Pandoc -> FilePath -> IO ()
defaultWriter pandoc filePath =
    let
        writerOptions :: WriterOptions
        writerOptions = def { writerExtensions = S.fromList [] }
    in
        writeFile filePath $ writeHtmlString writerOptions pandoc
