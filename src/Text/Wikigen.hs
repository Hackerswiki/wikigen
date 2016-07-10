module Text.Wikigen where

import Control.Monad (join, (=<<))

import qualified Data.Text.Lazy.IO as TI

import System.Directory
import System.FilePath (replaceExtension, (</>))

import Text.Blaze.Html.Renderer.Text

import Text.Wikigen.Template (articlePage)
import Text.Wikigen.Markdown (parseArticle)

-- | transform a markdown file to a HTML file
transformFile :: FilePath -> FilePath -> IO ()
transformFile fN dir = ((renderHtml . articlePage . parseArticle) <$>
    TI.readFile fN) >>= TI.writeFile fN'
    where fN' = dir </> replaceExtension fN "html"

-- | get a recursively generated list of files from a base directory
getFileList :: FilePath -> IO [FilePath]
getFileList base = join <$> (mapM transform =<< listDirectory base)
    where go perms isFile
              | searchable perms && readable perms = getFileList
              | readable perms && isFile = pure . (:[])
              | otherwise = empty
          empty = const (pure [])
          transform fName = do
              let path = base </> fName
              isLink <- isSymbolicLink path
              isFile <- doesFileExist path
              perms <- getPermissions path
              if not isLink then go perms isFile path else pure []
