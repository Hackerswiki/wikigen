module Text.Wikigen.Wikigen where

import qualified Data.Text.Lazy.IO as TI

import System.FilePath (replaceExtension, (</>))

import Text.Blaze.Html.Renderer.Text

import Text.Wikigen.Template (articlePage)
import Text.Wikigen.Markdown (parseArticle)

-- | transform a markdown file to a HTML file
transformFile :: FilePath -> FilePath -> IO ()
transformFile fN dir = ((renderHtml . articlePage . parseArticle) <$>
    TI.readFile fN) >>= TI.writeFile fN'
    where fN' = dir </> replaceExtension fN "html"
