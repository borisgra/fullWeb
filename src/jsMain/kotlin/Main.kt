import react.child
import react.dom.render
import kotlinx.browser.document
import kotlinext.js.require

fun main() { //query-gra Branch - first
    require("ag-grid-community/dist/styles/ag-grid.css") //https://www.ag-grid.com/documentation/react
    require("ag-grid-community/dist/styles/ag-theme-alpine.css")
    require("ag-grid-enterprise")
    render(document.getElementById("root")) {
        child(AppClients)
    }
}