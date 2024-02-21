@val external browser: 'a = "browser"

type browserContextMenuCreateProperties = {
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

let properties: browserContextMenuCreateProperties = {
  id: contextMenuId,
  title: "Search in Naver Dictionary",
  contexts: ["selection"],
}
browser["contextMenus"]["create"](properties)

browser["contextMenus"]["onClicked"]["addListener"](info => {
  if info["menuItemId"] === contextMenuId {
    search(info["selectionText"])
  }
})
