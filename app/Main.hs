module Main
    ( main
    ) where

import System.Environment
import System.Exit

import Argument
import FileParsing
import Compressor
import PrintCluster

main :: IO ()
main = do
    argv <- getArgs
    args <- handleArgument argv
    case args of
        Right   (opt)       -> do
                c <- readFile (pathImage opt)
                printCluster (imgCompressor (parseFile c, nbColors opt, convergenceLimit opt) [])
        Left    (Invalid)   -> exitWith $ ExitFailure 84
        _                   -> exitWith ExitSuccess
