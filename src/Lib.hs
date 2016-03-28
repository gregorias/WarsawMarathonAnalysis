{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( extractResults
    ) where

import Control.Applicative
import Data.Attoparsec.ByteString.Char8
import qualified Data.ByteString.Char8 as BS
import Data.Either

-- | Parser for strings like <p>2:34:56 AM</p>
timeString :: Parser BS.ByteString
timeString = do
  string "<p>"
  time <- many1 $ notChar ' '
  string " AM</p>"
  return $ BS.pack time

-- | Parser for regular expresion: ((NOT timeString)* timeString)*
timeStrings :: Parser [BS.ByteString]
timeStrings = timeStringsTLO []

-- | Tail optimized parser for regular expresion:
-- ((NOT timeString)* timeString)*
timeStringsTLO :: [BS.ByteString] -> Parser [BS.ByteString]
timeStringsTLO acc =
  (endOfInput >> return acc) <|> foundInput
  where
    foundInput = do
      result <- (: []) <$> timeString <|> (anyChar >> return [])
      timeStringsTLO (result ++ acc)

-- Parses from H:MM:SS to int representing number of minutes.
timeToMinutes :: Parser Int
timeToMinutes = do
  hours <- digit
  char ':'
  minutes <- many' digit
  char ':'
  many' digit
  return $ (read [hours] * 60) + (read minutes :: Int)

-- Parses string with timeStrings and returns list with minute counts.
extractResults :: BS.ByteString -> [Int]
extractResults input =
  case parseOnly timeStrings input of
    Left _ -> []
    Right result -> rights $ map (parseOnly timeToMinutes) result
