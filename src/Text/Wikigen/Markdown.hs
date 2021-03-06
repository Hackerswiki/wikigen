{-# LANGUAGE OverloadedStrings #-}
module Text.Wikigen.Markdown where

import Data.Text.Lazy (Text)
import qualified Data.Text.Lazy as LT
import qualified Data.Text as ST
import qualified Data.Text.Encoding as STE

import Text.Blaze.Html (Html)

import Text.Highlighter (lexerFromLanguage, runLexer)
import Text.Highlighter.Formatters.Html (format)

import Text.Markdown
import Text.Markdown.Block (Block(..))
import Text.Markdown.Inline (Inline)

import Text.Wikigen.Types

-- | generate the HTML for the markdown of an article
parseArticle :: Text -> Article
parseArticle input =
    Article clean (markdown settings input)
    where settings = def { msBlockCodeRenderer = renderCode
                         , msBlockFilter = indent
                         , msAddHeadingId = True
                         }
          clean | "#" `LT.isPrefixOf` input =
              LT.tail $ LT.takeWhile (/= ' ') input
                | otherwise = input

-- | render codeblocks to colorful HTML
renderCode :: Maybe ST.Text -> (ST.Text, Html) -> Html
renderCode (Just lang) (raw, html) =
    case lexerFromLanguage (ST.unpack lang) of
      Just lexer -> either (const html) id $ format True <$>
          runLexer lexer (STE.encodeUtf8 raw)
      Nothing -> html
renderCode _ (_, html) = html

-- | indent all headers by one and treat h6 headers someway or another
indent :: [Block [Inline]] -> [Block [Inline]]
indent = map transform
    where transform (BlockHeading n i) = BlockHeading (n+1) i
          transform b = b
