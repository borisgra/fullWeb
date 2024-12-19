import kotlinx.browser.document
import react.*
import react.dom.client.createRoot
import web.dom.Element

fun main() {
//    requireAll(require.context("@ag-grid-community/styles", true, js("/\\.css$/"))) // "kotlinw-extensions" is deprecated - aSemy and turansky committed on May 9 2024

    createRoot(document.getElementById("root").unsafeCast<Element>())
        .render(Fragment.create { AppClients() })
}