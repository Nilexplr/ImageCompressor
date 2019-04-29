module Argument
    ( handleArgument
    ) where

import System.Environment(getArgs)
import System.Console.GetOpt
import Control.Monad

{-
Options data declaration
-}
data Options = Options
    { helper            :: Bool
    , version           :: Bool
    , nbColors          :: Int
    , convergenceLimit  :: Int
    , pathImage         :: String
    } deriving Show

{-
Return a default Options data
-}
startOption :: Options
startOption = Options
    { helper            = False
    , version           = False
    , nbColors          = 0
    , convergenceLimit  = 0
    , pathImage         = ""
    }

{-
    Reference for the getOpt function
-}
options :: [ OptDescr (Options -> Either String Options) ]
options =
    [ Option ['c'] ["check"] (NoArg (\opt -> Right opt { helper = True } )) "Check ok"
    ]
-- DEBUG: This is a temporary version of the argument array

{-
Main function of the argument handling
-}
handleArgument :: IO (Either [String] Options)
handleArgument = do
    argv <- getArgs
    opt <- parseArguments argv
    return opt

{-
Parse every argument and return either an error or
the correct Options data
-}
parseArguments :: [String] -> IO (Either [String] Options)
parseArguments argv = do
    case getOpt Permute options argv of
        ([], [], []) -> return $ Left ["no args"]
        (_, _, err) -> return $ Left err
