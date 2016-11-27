import Control.Monad (when)
import Data.Foldable (traverse_, forM_)
import qualified Data.Set as S
import Data.Traversable (forM)
import System.Directory (createDirectoryIfMissing, doesDirectoryExist, listDirectory)
import System.FilePath.Posix (
    (</>), joinPath, replaceExtension, splitPath,
    takeExtension, takeFileName, takeDirectory)
import Text.Pandoc.Definition (Pandoc)
import Text.Pandoc.Error (PandocError)
import Text.Pandoc.Readers.Markdown (readMarkdown)
import Text.Pandoc.Writers.HTML (writeHtmlString)
import Text.Pandoc.Options (def, Extension(..), ReaderOptions(..), WriterOptions(..))


main :: IO ()
main = do
    let markdownDirectory = "markdown"
    let htmlDirectory = "html"
    filePaths <- getFilePaths markdownDirectory
    forM_ filePaths $ \filePath ->
       when (takeExtension filePath == ".markdown") $ do
            let
                destFileName :: FilePath
                destFileName = ((`replaceExtension` "html") . takeFileName) filePath
                destDirectory :: FilePath
                destDirectory = (htmlDirectory </>) $
                    (joinPath . tail . splitPath . takeDirectory) filePath
                isRecursive :: Bool
                isRecursive = True
            createDirectoryIfMissing isRecursive destDirectory
            defaultConverter filePath (destDirectory </> destFileName)


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


defaultConverter :: FilePath -> FilePath -> IO ()
defaultConverter input output = do
    s <- readFile input
    case defaultReader s of
        Left pandocError -> print pandocError
        Right pandoc -> defaultWriter pandoc output


defaultReader :: String -> Either PandocError Pandoc
defaultReader s =
    let
        extensions :: S.Set Extension
        extensions = S.fromList [Ext_backtick_code_blocks,
                                 Ext_east_asian_line_breaks,
                                 Ext_raw_html]
        readerOptions :: ReaderOptions
        readerOptions = def { readerExtensions = extensions }
    in
        readMarkdown readerOptions s


defaultWriter :: Pandoc -> FilePath -> IO ()
defaultWriter pandoc filePath =
    let
        writerOptions :: WriterOptions
        writerOptions = def { writerExtensions = S.fromList [] }
    in
        writeFile filePath $ writeHtmlString writerOptions pandoc
