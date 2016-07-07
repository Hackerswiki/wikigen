module Text.Wikigen.Wikigen where

import Data.Text.Lazy (Text)
import qualified Data.Text.Lazy.IO as TI
import qualified Data.Text as ST
import qualified Data.Text.Encoding as STE

import System.FilePath (replaceExtension, (</>))

import Text.Blaze.Html5 (Html)
import Text.Blaze.Html.Renderer.Text

import Text.Highlighter (lexerFromLanguage, runLexer)
import Text.Highlighter.Formatters.Html (format)

import Text.Markdown
import Text.Markdown.Block (Block(..))
import Text.Markdown.Inline (Inline)

import Text.Wikigen.Template
import Text.Wikigen.Types
import Text.Wikigen.Markdown

-- | transform a markdown file to a HTML file
transformFile :: FilePath -> FilePath -> IO ()
transformFile fN dir = ((renderHtml . articlePage . parseArticle) <$>
    TI.readFile fN) >>= TI.writeFile fN'
    where fN' = dir </> replaceExtension fN "html"
