import Control.Monad (when)
import Data.Foldable (traverse_, forM_)
import qualified Data.Set as S
import Data.Traversable (forM)
import System.Directory (listDirectory, doesDirectoryExist)
import System.FilePath.Posix ((</>), replaceExtension, takeExtension)
import Text.Pandoc.Definition (Pandoc)
import Text.Pandoc.Error (PandocError)
import Text.Pandoc.Readers.Markdown (readMarkdown)
import Text.Pandoc.Writers.HTML (writeHtmlString)
import Text.Pandoc.Options (
    def,
    Extension(..),
    ReaderOptions(..),
    WriterOptions(..))


main :: IO ()
main = do
    filePaths <- getFilePaths "markdown"
    forM_ filePaths $ \filePath ->
       when (takeExtension filePath == ".markdown") $
            (defaultConverter . designateDestination) filePath


getFilePaths :: FilePath -> IO [FilePath]
getFilePaths directory = do
    ds <- listDirectory directory
    paths <- forM ds $ \d -> do
        let path = directory </> d
        isDirectory <- doesDirectoryExist path
        if isDirectory then
            getFilePaths path
        else
            return [path]
    return (concat paths)


designateDestination :: FilePath -> (FilePath, FilePath)
designateDestination filePath =
    let
        destination :: FilePath
        destination = replaceExtension filePath "html"
    in
        (filePath, destination)


defaultConverter :: (FilePath, FilePath) -> IO ()
defaultConverter (input, output) = do
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
