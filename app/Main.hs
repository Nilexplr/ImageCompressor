module Main
    ( main
    ) where

import Argument

main :: IO ()
main = do
    args <- Argument.handleArgument
    print $ args
