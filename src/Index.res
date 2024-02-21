@val external browser: 'a = "browser"

type browserContextMenuCreateOption = {
  id: string,
  title: string,
  contexts: array<string>,
}

let contextMenuId = "naver-dict"

let search = (word: string) => {
  browser["tabs"]["create"]({
    "url": `https://dict.naver.com/search?query=${word}`,
  })
}

let option: browserContextMenuCreateOption = {
  id: contextMenuId,
  title: "Search in Naver Dictionary",
  contexts: ["selection"],
}
browser["contextMenus"]["create"](option)

browser["contextMenus"]["onClicked"]["addListener"](info => {
  if info["menuItemId"] === contextMenuId {
    search(info["selectionText"])
  }
})
