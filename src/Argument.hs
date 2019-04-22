module Argument
    ( handleArgument
    ) where

import System.Environment(getArgs)

data Options = Options
    { helper            :: Bool
    , version           :: Bool
    , nbColors          :: Int
    , convergenceLimit  :: Int
    , pathImage         :: String
    } deriving Show

startOption :: Options
startOption = Options
    { helper            = False
    , version           = False
    , nbColors          = 0
    , convergenceLimit  = 0
    , pathImage         = ""
    }

handleArgument :: IO (Either [String] Options)
handleArgument = do
    argv <- getArgs
    -- TODO: Implement the getopt
    return $ Right startOption