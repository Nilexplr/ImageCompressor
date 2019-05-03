module Main
    ( main
    ) where

import System.Environment(getArgs)
import System.Exit

import Argument

main :: IO ()
main = do
    argv <- getArgs
    args <- handleArgument argv
    case args of
        Right   (opt)       -> do print $ opt
        Left    (Invalid)   -> exitWith $ ExitFailure 84
        _                   -> exitWith ExitSuccess
