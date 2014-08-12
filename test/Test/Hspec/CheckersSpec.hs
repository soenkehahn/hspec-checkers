
module Test.Hspec.CheckersSpec where


import Test.Hspec
import Test.QuickCheck.Classes

import Test.Hspec.Checkers


spec :: Spec
spec = do
  describe "testBatch" $ do
    it "allows to test the monoid laws for [Int]" $ do
      hspec $ testBatch (monoid (undefined :: [Int]))
