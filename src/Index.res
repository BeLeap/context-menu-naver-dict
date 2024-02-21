@val external chrome: 'a = "chrome"
@val external browser: 'a = "browser"

let browserInterop = if chrome {
  chrome
} else {
  browser
}

type browserContextMenuCreateProperties = {
  id: string,
  title: string,
  contexts: array<string>,
}

let contextMenuId = "naver-dict"

let search = (word: string) => {
  browserInterop["tabs"]["create"]({
    "url": `https://dict.naver.com/search?query=${word}`,
  })
}

let properties: browserContextMenuCreateProperties = {
  id: contextMenuId,
  title: "Search in Naver Dictionary",
  contexts: ["selection"],
}
browserInterop["contextMenus"]["create"](properties)

browserInterop["contextMenus"]["onClicked"]["addListener"](info => {
  if info["menuItemId"] === contextMenuId {
    search(info["selectionText"])
  }
})
