module Main where

import Lib
import qualified Data.ByteString.Char8 as BS

-- | Parses contents of "data/marathon_data.html" and outputs a newline
-- delimited list of minutes into "data/minutes_output.csv"
main :: IO ()
main = do
  input <- BS.readFile "data/marathon_data.html"
  let times  = extractResults input
      shownl :: Int -> BS.ByteString
      shownl = BS.pack . (++ "\n") . show
      output = foldr (BS.append . shownl) BS.empty times
  BS.writeFile "data/minutes_output.csv" output
  where
