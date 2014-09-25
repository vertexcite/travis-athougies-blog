{-# LANGUAGE OverloadedStrings #-}
import Clay
import qualified Clay.Media as Mq
import Prelude hiding (div, span, (**), all)

travisLightGray = grayish 136
travisBlue      = rgb 0 0x99 0xFF
codeBackground  = grayish 0xEE
headerRuleColor = grayish 0xDD

titleFamily = fontFamily ["Open Sans", "Nexa Light"] [sansSerif]
bodyFamily  = fontFamily ["Palatino Linotype", "Palatino", "Baskerville", "Book Antiqua", "URW Palladio L"] [serif]

headerWidth = 280
headerRightSpace = 20
contentMaxWidth = 685
contentMinWidth = 300
contentPaddingLeft = 75
contentPaddingTop = 75
contentPaddingTopNarrow = miniHeaderHeight + 10
contentPaddingLeftNarrow = 10
contentPaddingRightNarrow = 10
normalBodyPadding = 190
miniHeaderHeight = 140

siteMinWidth = headerWidth - headerRightSpace + contentMinWidth + contentPaddingLeft + normalBodyPadding * 2

plainLinks =
    a ? do
      textDecoration none
      color         black

narrowW = query all [Mq.maxWidth (px siteMinWidth)]
normalW = query all [Mq.minWidth (px siteMinWidth)]

-- Related speciically to projects
projects = do
  ul # byId "projects" ? do
    "list-style"   -: "none"
    sym padding       0
    h2 ? do
      marginBottom    (px 2)
      textTransform   none
    li ? do
      marginTop       (em 3)
      firstChild &
        marginTop     0
    ul # byClass "info" ? do
      titleFamily
      "list-style" -: "none"
      marginTop       (px 3)
      marginBottom    (px 10)
      paddingLeft     (em 1)
      fontSize        (pt 10)
      li ? do
        display       inline
        marginLeft    (em 1.5)
        firstChild &
          marginLeft  0
        span ? do
          byClass "label" & do
            color      travisBlue
            marginRight (px 5)
          byClass "value" & do
            textDecoration underline

galleryStyles = do
  let prevNextCommon arrowImg = do position relative
                                   width (px prevNextWidth)
                                   background (url arrowImg, (noRepeat, placed sideCenter sideCenter))
                                   backgroundColor (grayish 0x66)
      prevNextWidth = 100

  star # ".modal" ? do
    overflow scroll
  star # "#gallery-prev" ? do
    prevNextCommon "/images/stock/left-arrow.png"
    float floatLeft
  star # "#gallery-next" ? do
    prevNextCommon  "/images/stock/right-arrow.png"
    float floatRight
  star # "#gallery-image" ? do
    minWidth (px (prevNextWidth * 2))
    minHeight (px (prevNextWidth * 2))
    marginLeft (px (-prevNextWidth))
    marginRight (px (-prevNextWidth))
  star # "#gallery-caption" ** star # ".gallery-figure" ? do
    fontWeight        bold
  star # "#gallery-caption" ?
    do narrowW $ do
        color   white
        position absolute
        bottom (px 0)
        sym padding (px 5)
        backgroundColor (rgba 0x33 0x33 0x33 192)
        fontSize (pt 18)
  narrowW $ do
    div # ".modal" ? do
      sym borderRadius (px 0)
      backgroundColor black
      sym padding (px 0)

main :: IO ()
main = putCss $ do
  body ? do
    bodyFamily
    sym margin        0
    normalW $ do
      paddingLeft       (px normalBodyPadding)
      paddingRight      (px normalBodyPadding)
    h2 ? do
      fontWeight      normal

  ul # byClass "blogroll" ? do
    "list-style"   -: "none"
    li ? do
      marginTop       (em 1)
      firstChild & do
        marginTop     0

  div # "#content" ? do
    normalW $ maxWidth (px contentMaxWidth)
    marginLeft        auto
    marginRight       auto
    narrowW $ do
      paddingTop  (px contentPaddingTopNarrow)
      paddingLeft (px contentPaddingLeftNarrow)
      paddingRight (px contentPaddingRightNarrow)
      fontSize (pt 18)
    normalW $ do
      paddingTop      (px contentPaddingTop)
      paddingLeft     (px contentPaddingLeft)
    p ? do
      lineHeight (em 1.7)
      textAlign       justify
      overflow        hidden -- This makes the text not wrap around #header
    div # ".figure" ? do
      sym padding       (px 10)
      border            solid (px 1) travisLightGray
      float             floatLeft
      marginLeft        (px 5)
      marginTop         (px 5)
      width             (px 200)
      textAlign         (alignSide sideCenter)
      ".figure-center" & do
        marginLeft      auto
        marginRight     auto
      ".figure-flow" & do
        marginLeft      (px 5)
        marginRight     (px 5)
      ".figure-right" & do
        float           floatRight
      firstChild & do
        marginLeft      0
        marginTop       0
      img ? do
        maxWidth        (px 200)
        maxHeight       (px 200)
      p # ".caption" ? do
        lineHeight      (em 1.1)
        fontSize        (pt 10)
        narrowW $ do display none
        textAlign       (alignSide sideLeft)

    ul ? do
      li ? do
        lineHeight    (em 1.3)
        marginBottom  (em 1)
        "last-child" & do
          marginBottom 0
    h1 ? do
      normalW $ bodyFamily
      narrowW $ do titleFamily
                   fontSize (pt 40)
      fontWeight      normal
      marginBottom    (px 12)
    h2 ? do
      titleFamily
      textTransform   uppercase
      normalW $ fontSize (pt 13)
      narrowW $ fontSize (pt 16)
      borderBottom    solid (px 1) headerRuleColor

    div # byClass "info" ? do
      paddingLeft     (em 2)
      fontStyle       italic
      color           gray
      span ? do
        byClass "author" & do
          color black
        byClass "date" & do
          color navy
    div # byClass "tags" ? do
      paddingLeft     (em 2)
      fontStyle       italic
      color           gray
      marginTop     (px 10)
      ul ? do
        color         black
        fontStyle     normal
        "list-style"  -: "none"
        sym padding   0
        sym margin    0
        display       inline
        li ? do
          a ? do
            color     black
          display     inline

    pre ? do
      overflowX       auto
      width           (pct 100)
      marginLeft      (px 20)
      sym padding     (em 1)
      lineHeight      (em 1)
      backgroundColor codeBackground

  div # "#mini-header-bar" ? do
     normalW $ display none
     narrowW $ do position fixed
                  width    (pct 100)
                  height   (px miniHeaderHeight)
                  backgroundColor black
                  titleFamily
                  star # "#show-header" ? do
                    color white
                    fontSize (px 70)
                    width    (px 70)
                    sym padding (px 10)
                    paddingRight (px 2)
                    sym margin (px 7)
                    float floatRight
                    "cursor" -: "pointer"
                  h1 # "#mini-logo" ? do
                    plainLinks
                    fontSize (pt 30)
                    letterSpacing (px 5)
                    textTransform uppercase
                    fontWeight normal
                    display block
                    marginLeft auto
                    marginRight auto
                    marginTop (px 40)
                    width (px 400)
                    textAlign (alignSide sideCenter)
                    p ? do
                      sym margin 0
                      color travisBlue
                      display inline
                      ".travis" & do
                         color white
                         marginRight (px 15)

  div # "#header" ? do
    titleFamily
--    position          fixed
    overflow          auto
    float             floatLeft
    width             (px (headerWidth - headerRightSpace))
    marginRight       (px headerRightSpace)
    narrowW $ do
      position fixed
      display none
      backgroundColor black
      color white
      textAlign (alignSide sideCenter)
      marginTop (px miniHeaderHeight)
      height    (pct 100)
      width     (pct 100)
      fontSize  (pt 28)
    div # byId "shamelessplug" ? do
      normalW $ fontSize (pt 8)
      narrowW $ fontSize (pt 15)
    h1 # byId "logo" ? do
      -- display         block
      -- float           floatLeft
      narrowW $
        display none -- The header bar has this logo in the narrow display mode
      plainLinks
      fontSize        (pt 24)
      letterSpacing   (px 6)
      textTransform   uppercase
      fontWeight      normal
      display         block
      marginTop       (px 60)
      marginBottom    (px 10)
      p ? do
        sym margin    0
        marginBottom  4
        ":first-letter" & do
          fontSize    (pt 26)
          display     inlineBlock
        ".travis" & do
          color       travisLightGray

    div # byId "taglines" ? do
      normalW $ fontSize (pt 14)
      narrowW $ fontSize (pt 20)
      color           travisBlue

    ul # byId "navigation" ? do
      "list-style" -: "none"
      sym padding     0
      h2 ? do
        textTransform uppercase
        sym margin    0
        marginBottom  (px 5)
        fontSize      (pt 13)
        narrowW $ do
             backgroundColor (grayish 0x33)
      li ? do
        marginTop     (px 10)
        firstChild &
          marginTop   0
      ul ? do
        "list-style" -: "none"
        normalW $ paddingLeft   (px 20)
        narrowW $ do
             paddingLeft 0
             a ? color white
        li ? do
          marginTop   (px 4)
          firstChild &
            marginTop 0

  projects
  galleryStyles