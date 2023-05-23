import kotlinext.js.require
import kotlinext.js.requireAll
import kotlinx.browser.document
import react.*
import react.dom.client.createRoot
import web.dom.Element

fun main() {
    @Suppress("UnsafeCastFromDynamic")
    requireAll(require.context("ag-grid-community/styles", true, js("/\\.css$/")))

    createRoot(document.getElementById("root").unsafeCast<Element>())
        .render(Fragment.create { AppClients() })
}