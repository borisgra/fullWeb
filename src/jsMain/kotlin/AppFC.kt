@file:Suppress("UnsafeCastFromDynamic", "unused")

import web.cssom.ClassName
import io.ktor.client.call.*
import react.FC
import react.*
import kotlinx.browser.window
import kotlinx.coroutines.*
import react.dom.html.ReactHTML.a
import react.dom.html.ReactHTML.div
import react.dom.html.ReactHTML.img
import react.dom.html.ReactHTML.li
import react.dom.html.ReactHTML.nav
import react.dom.html.ReactHTML.span
import react.dom.html.ReactHTML.ul
import mui.material.*
import kotlin.js.json

external interface QueryI {
    var id: Int
    var name: String
    var query: String
    var columns: String
    var heading: String
    var submenu: String
    var _sql: String?
}

external interface MenuNestedItemI {
    val label: String
    val items: Array<MenuNestedItemI>
    val callback: Any?
    val sx: Any?
}
data class MenuNestedItem(
    override val label: String,
    override val items: Array<MenuNestedItemI> = emptyArray(),
    override val callback: Any? = null,
    override val sx: Any? =
        json(Pair("color", "#0033cc"))
            .add(json(Pair("bgcolor", "#c6ecc6")))
): MenuNestedItemI

val scope = MainScope()
var urlInput = ""
var urlQuerys = ""
var contextGreed = mapOf<String, String>()
var queryCurrent: QueryI? = null
var NewValue = mutableMapOf<String, String>()
var currentPlaceholder = ""
//var sorted = 0
var adminState = false
var v_querys = "v_querys"
var endpoint_service_url: String? = null
var useEffectMap = mutableMapOf<String, (Any) -> Unit>()
val endpoint = window.location.origin
var rowFieldsValueString: String = ""
var dateFrom: String = DATE_MIN
var dateTo: String = DATE_MAX
var queriesLoaded = emptyArray<QueryI>()

var queryHistory = emptyList<Triple<String, String, String>>().toMutableList()
var historyCurrent = -1
var gridApi: ApiAG? = null
const val HEIGHT = 40.0

val AppClients = FC<Props> {
    var showInput by useState(HIDE)
    var showNav by useState(HIDE)
    var showShare by useState(HIDE)
    var historyDialogOpen by useState(false)
    var intervalDialogOpen by useState(false)
    var newTab by useState(false)
    val editIcon = useStateMap(EDIT_NO, "editIcon")
    val rowList = useStateMap(emptyArray<Any>(), "rowList")
    val colList = useStateMap(emptyArray<Any>(), "colList")
    val titlesList = useStateMap(emptyArray<QueryI>(), "titlesList")
    val titleCurrent = useStateMap("", "titleCurrent")
    val resultUpdate = useStateMap("", "resultUpdate")
    val showButton = useStateMap(HIDE, "showButton")

    useEffectOnce {
        scope.launch {
            startEnv = loadByPost(LOADENV, getParameter(ENDPOINT_SERVICE_URL) ?: endpoint).body()
            endpoint_service_url = getParameter(ENDPOINT_SERVICE_URL) ?: startEnv[ENDPOINT_SERVICE_URL] ?: ""
            startEnv.putAll(loadByPost(LOADENV, endpoint_service_url).body())
            println("rezLoad=${decodeJson(startEnv.toString())}")
            showNav = if (startEnv[QUERY_BD] == null) HIDE else getParameter("m") ?: SHOW
            v_querys = getParameter(VIEW_QUERY_NAME) ?: startEnv[VIEW_QUERY_NAME] ?: VIEW_QUERY
            urlQuerys = "$ROUTE_BD/$QUERY_BD/$JSON_PG/$v_querys/${
                getParameter(VIEW_QUERY_WHERE)
                    ?: startEnv[VIEW_QUERY_WHERE]
                    ?: VIEW_QUERY_WHERE_DEFAULT
            }"
            println("urlQuerys=$urlQuerys")
            println("search=${window.location.search}")
            refreshMenuItems(first = true)
            if (startEnv[JSR223] != HIDE)
                jsr223("println(\"First run $JSR223 \")") // for load cash
        }
    }

    fun ChildrenBuilder.refresh(heightIn: Double = HEIGHT) {
        img {
            src = "img/refresh.png"
            title = "refresh"
            height = heightIn
            onClick = {
                scope.launch {
                    setStateMap("resultUpdate", TRYING_TO_FETCH)
                    refreshRow(gridApi)
                    setStateMap("resultUpdate", "")
                }
            }
        }
    }

    fun ChildrenBuilder.inputAny() {
        div {
            InputFC {
                placeholder = currentPlaceholder
                onSubmit = { input ->
                    when (placeholder) {
                        URI_FOR_QUERY -> {
                            if (input.isNotBlank())
                                lunchQuery(input)
                            else refreshMenuItems() // when menu updated in other window
                        }

                        TITLES_FOR_QUERY ->
                            addNewQuery(rowList, input)

                        else -> scope.launch {
                            adminState = checkPassw("$ROUTE_BD/$PASSW", input, endpoint_service_url)
                        }
                    }
                    showInput = HIDE
                }
            }
        }
    }

    fun info() {
        div {
            refresh(HEIGHT / 2)
            span {
                className = ClassName("cl3")
                +resultUpdate
            }
            span {
                className = ClassName("title")
                +titleCurrent
            }
            span {
                className = ClassName("oneline $showInput")
                inputAny()
            }
        }
    }

    fun submenuByQueryCreate(submenus: List<String>): Array<MenuNestedItemI> {
        return submenus
            .distinct()
            .sortedBy { it }
            .map { submenu ->
                titlesList
                    .sortedWith(compareBy<QueryI> { it.submenu }
                        .thenBy { it.heading })
                    .filter { submenu == it.submenu }
                    .map { query ->
                        if (query.name != "" && query.name != SUBMENU)
                            listOf(MenuNestedItem(decodeJson(query.heading), callback = {
                                contextGreed = contextGreed + ("selectedTable" to query.name)
                                if (query.heading.endsWith(NEW_TAB))
                                    window.open(
                                        if (query.heading.endsWith(NEW_TAB + NEW_TAB))
                                            decodeJson(query.query)
                                        else
                                            "$endpoint_service_url?$FIRSTQUERY=${query.name}&$ROW_FIELDS_VALUE_PARAM=${rowFieldsValueString.ifEmpty { "{}" }}"
                                    )
                                else lunchQuery(query.name)
                            }))
                        else
                            submenuByQueryCreate(
                                decodeJson(query.heading).split(",")
                            ).toList()
                    }.flatten()
                    .let { MenuNestedItem(submenu, it.toTypedArray()) }
            }.toTypedArray()
    }

    fun setPlaceholder(whatInput: String) {
        currentPlaceholder = whatInput
        showInput = if (showInput == HIDE) SHOW else HIDE
        js("setTimeout(function(){document.getElementById('inputAny').focus()},10);")//https://stackoverflow.com/questions/27313872/auto-focus-is-not-working-for-input-field
    }

    fun ChildrenBuilder.historyListDialog() {
        Dialog {
            open = historyDialogOpen
            DialogTitle { +"Queries History" }
            DialogContent {
                List {
                    queryHistory.forEachIndexed { i, it ->
                        ListItem {
                            selected = it.third == titleCurrent
                            ListItemButton {
                                +it.third
                                onClick = {
                                    historyCurrent = i
                                    if (newTab)
                                        window.open(
                                            "${window.location.origin}?q=${queryHistory[historyCurrent].second}"
                                                .let { "$it&$ROW_FIELDS_VALUE_PARAM=${queryHistory[historyCurrent].first.ifEmpty { "{}" }}" }
                                        )
                                    else
                                        lunchQuery(
                                            queryHistory[historyCurrent].second,
                                            queryHistory[historyCurrent].first
                                        )
                                    setStateMap("titleCurrent", queryHistory[historyCurrent].third)
                                    historyDialogOpen = false
                                }
                            }
                        }
                    }
                }
                DialogActions {
                    Checkbox {
                        checked = newTab
                        onChange = { _, _ -> newTab = !newTab }
                    }
                    a { +OPEN_IN_NEW_TAB }
                    Button {
                        onClick = { historyDialogOpen = false }
                        +"Cancel"
                    }
                }
            }
        }
    }

    fun ChildrenBuilder.intervalDateDialog() {
        img {
            src = "img/interval.png"
            title = "Interval Date"
            height = HEIGHT
            onClick = {
                intervalDialogOpen = true
            }
        }
        Dialog {
            open = intervalDialogOpen
            DialogTitle { +"Interval Date" }
            DialogContent {
                FieldDateFC {
                    id = DATE_FROM;label = DATE_FROM; defaultValue = dateFrom
                    onChange = { e ->
                        dateFrom = e.asDynamic().target.value.toString()
                        refreshMenuItems(false)
                    }
                }
                FieldDateFC {
                    id = DATE_TO;label = DATE_TO; defaultValue = dateTo
                    onChange = { e ->
                        dateTo = e.asDynamic().target.value.toString()
                        refreshMenuItems(false)
                    }
                }
                DialogActions {
                    Button {
                        onClick = { intervalDialogOpen = false }
                        +"Ок"
                    }
                }
            }
        }
    }

    fun ChildrenBuilder.history() {
        img {
            src = "img/prev${if (queryHistory.size > 1 && historyCurrent > 0) "" else "H"}.png"
            title = "prev query"
            height = HEIGHT
            onClick = {
                if (historyCurrent > 0) {
                    historyCurrent--
                    lunchQuery(queryHistory[historyCurrent].second, queryHistory[historyCurrent].first)
                    setStateMap("titleCurrent", queryHistory[historyCurrent].third)
                }
            }
        }
        img {
            src = "img/history.png"
            title = "query history"
            height = HEIGHT
            className = ClassName(if (queryHistory.size > 0) SHOW else HIDE)
            onClick = { historyDialogOpen = true }
        }
        historyListDialog()
        img {
            src = "img/next${if (historyCurrent < queryHistory.size - 1 && historyCurrent > -1) "" else "H"}.png"
            title = "next query"
            height = HEIGHT
            onClick = {
                if (historyCurrent < queryHistory.size - 1) {
                    historyCurrent++
                    lunchQuery(queryHistory[historyCurrent].second, queryHistory[historyCurrent].first)
                    setStateMap("titleCurrent", queryHistory[historyCurrent].third)
                }
            }
        }
    }

    fun ChildrenBuilder.modify(gridApi: ApiAG?) {
        img {
            src = "img/help.png"
            title = "help"
            height = HEIGHT
            onClick = {
                window.open("help.html")
//                setPlaceholder(URI_FOR_QUERY)
            }
        }
        img {
            className = ClassName(HIDE) // from 609 not work  npm react-share
            src = "img/share.png"
            title = "share"
            height = HEIGHT
            onClick = {
                showShare = if (showShare == SHOW) HIDE else SHOW
            }
        }
        span {
            className = ClassName(showShare)
            shareButtons()
        }
        img {
            src = "img/$editIcon.jpg"
            title = "edit"
            height = HEIGHT
            className = ClassName(showButton)
            onClick = {
                setStateMap(
                    "editIcon",
                    if (editIcon == EDIT_NO)
                        EDIT_YES
                    else EDIT_NO
                )
            }
        }
        img {
            src = "img/delete.png"
            title = "delete"
            height = HEIGHT
            className = ClassName(showButton)
            onClick = {
                deleteRows(gridApi)
            }
        }
        img {
            src = "img/copy.png"
            title = "copy"
            height = HEIGHT
            className = ClassName(showButton)
            onClick = {
                scope.launch {
                    val rowsSelected: Array<Any> = gridApi!!.getSelectedRows()
                    rowsSelected.forEachIndexed { i, _ ->
                        NewValue[(rowList.size + i).toString()] = "copy"
                    }
                    fetchArray<Any>(urlInput)
                        .filter {
                            rowsSelected.map { it1 -> JSON.stringify(it1) }
                                .contains(JSON.stringify(it))
                        }.also {
                            setStateMap("rowList", rowList + it.toTypedArray())
                        }
//                    if ((sorted == 0))
//                        gridApi.paginationGoToLastPage()
                }
            }
        }
        img {
            src = "img/save.png"
            title = "save"
            height = HEIGHT
            className = ClassName(if (editIcon == EDIT_NO) HIDE else SHOW)
            onClick = {
                if (NewValue.isNotEmpty() && window.confirm(SAVE_TO_SERVER))
                    scope.launch {
                        setStateMap("resultUpdate", TRYING_TO_SAVE)
                        delay(1000)
                        val rez = saveRow(rowList, NewValue, urlInput, endpoint_service_url).body<String>()
                        refreshRow(gridApi)
                        viewResult(rez)
                        if (urlInput.contains(v_querys))
                            refreshMenuItems()
                    }
            }
        }
    }

    fun menuItemsCreate() =
        MenuNestedItem(
            "Menu",
            submenuByQueryCreate(
                titlesList
                    .filter { it.query == "" && it.name != SUBMENU }
                    .map { it.submenu }) + arrayOf(
                MenuNestedItem(
                    "Service",
                    arrayOf(
                        MenuNestedItem("New Query", callback = { setPlaceholder(URI_FOR_QUERY) }),
                        MenuNestedItem("Add Query to $CONSTRUCTION", callback = { setPlaceholder(TITLES_FOR_QUERY) }),
                        MenuNestedItem(ADMIN_PASSW, callback = {
                            setPlaceholder(ADMIN_PASSW)
                        }),
                        MenuNestedItem(urlInput, callback = { window.navigator.clipboard.writeText(urlInput) }),
                        MenuNestedItem(startEnv[GIT_VERSION] ?: ""),
                    )
                )
            )
        )

    fun navBar() {
        nav {
            className = ClassName(showNav)
            ul {
                className = ClassName("topmenu")
                li {
                    nestedMenu {
                        if (showNav == SHOW)
                            menuItemsData = menuItemsCreate()
                    }
                }
                history()
                intervalDateDialog()
                refresh()
                modify(gridApi)
            }
        }
    }

    fun rowsGreed() =
        rowList.ifEmpty { null }
            .apply {
                div {//https://stackoverflow.com/questions/11163981/div-resizable-like-text-area
                    className =
                        ClassName("ag-theme-alpine fullscreen${if ((getParameter("m") ?: SHOW) == HIDE) "WithoutMenu" else ""}")
                    agGreed {
                        columnDefs = colList
                        rowData = rowList
                        context = contextGreed
                        headerHeight = 30
                        rowHeight = 30
                        rowDragManaged = false
                        animateRows = true
                        rowSelection = "multiple" // single / multiple
                        stopEditingWhenCellsLoseFocus = true
                        pagination = true // divide by page
                        paginationAutoPageSize = true
                        undoRedoCellEditing = true
                        undoRedoCellEditingLimit = 20
                        getRowClass = { params: ParamsAG ->
                            if (params.rowIndex % 2 == 0) "liteGray" else ""
                        }
                        rowClassRules = json(Pair("cl1", { params: ParamsAG -> params.data.status == "admin" }))
                            .add(json(Pair("cl2", { params: ParamsAG -> params.data.status == "foodmaker" })))
                            .add(json(Pair("cl3", { params: ParamsAG -> params.data.status == "feedmaker" })))
                        suppressClickEdit = true
//                        enableRangeSelection = true
//                        enableRangeHandle = true
//                        enableFillHandle = true
                        onGridReady = { params: ParamsAG -> gridApi = params.api }
                        onCellClicked = cellClicked(editIcon)
                        onCellValueChanged = valueChanged(rowList)
                        onCellDoubleClicked = cellDoubleClicked(editIcon)
                        onRowSelected = rowSelected()
                        onCellMouseOver = {}
                        onCellKeyPress = {}
                        onCellKeyDown = { e: dynamic ->
                            println("onCellKeyPress=${e.event.key}")
//                            println("value=${e.value}")
                            if (e.event.key == "F9" && ("" + e.value) != "undefined")
                                jsr223(decodeJson(e.value))
                        }
//                        onSortChanged = {
//                            when (sorted) {
//                                0 -> sorted = 1
//                                1 -> sorted = 2
//                                2 -> sorted = 0
//                            }
//                        }
                    }
                }
            }

    navBar()
    info()
    rowsGreed()
} // FC<Props>




