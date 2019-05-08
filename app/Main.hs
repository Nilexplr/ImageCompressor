module Main
    ( main
    ) where

import System.Environment
import System.Exit

import Argument
import FileParsing

main :: IO ()
main = do
    argv <- getArgs
    args <- handleArgument argv
    case args of
        Right   (opt)       -> do
                c <- readFile (pathImage opt)
                print $ parseFile c
        Left    (Invalid)   -> exitWith $ ExitFailure 84
        _                   -> exitWith ExitSuccess
