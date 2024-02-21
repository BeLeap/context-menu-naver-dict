@val external browser: 'a = "browser"

let contextMenuId = "naver-dict"

let search = (word: string) => {
  browser["tabs"]["create"]({
    "url": `https://dict.naver.com/search?query=${word}`,
  })
}

browser["contextMenus"]["create"]({
  "id": contextMenuId,
  "title": "Search in Naver Dictionary",
  "contexts": ["selection"],
})
browser["contextMenus"]["onClicked"]["addListener"](info => {
  if info["menuItemId"] === contextMenuId {
    search(info["selectionText"])
  }
})
