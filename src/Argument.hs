module Argument
    ( ArgumentType(..)
    , Options(..)
    , handleArgument
    ) where

{-
Options data declaration
-}
data Options = Options
    { nbColors          :: Int
    , convergenceLimit  :: Int
    , pathImage         :: String
    } deriving Show

{-
Return a default Options data
-}
startOption :: Options
startOption = Options
    { nbColors          = 0
    , convergenceLimit  = 0
    , pathImage         = ""
    }

{--
Declaration of the Flag datatype used for GetOpt
--}
data ArgumentType =     Invalid
                    |   Helper
                    |   Version
                    |   Other
    deriving (Show, Enum)

{-
Main function of the argument handling
-}
handleArgument :: [String] -> IO (Either ArgumentType Options)
handleArgument args = case parseArgument args of
                    Right   t           -> do return $ Right t
                    Left    (Helper)    -> do programUsage ; return $ Left Helper
                    Left    (Version)   -> do programVersion ; return $ Left Version
                    Left    (_)         -> do programInvalidArgs ; return $ Left Invalid

{-
Return the parsed argument
-}
parseArgument :: [String] -> Either ArgumentType Options
parseArgument ["--help"]    = Left  Helper
parseArgument ["--version"] = Left  Version
parseArgument [c, l, f]     = Right Options { nbColors = (read c :: Int) , convergenceLimit = (read l :: Int) , pathImage = f }
parseArgument _             = Left  Invalid

{-
Display the usage
-}
programUsage :: IO ()
programUsage = do putStrLn "./imageCompressor [nb colors] [convergence limit] [path to file]"


{-
Display the program's version
-}
programVersion :: IO ()
programVersion = do putStrLn "imageCompressor v0.0.1"

{-
Display invalid message error,
-}
programInvalidArgs :: IO ()
programInvalidArgs = do putStrLn "the given arguments are invalid, please use the --help option"