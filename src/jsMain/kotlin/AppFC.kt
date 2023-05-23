@file:Suppress("UnsafeCastFromDynamic", "unused")

import csstype.*
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

data class Query(
    var id: Int,
    var name: String,
    var query: String,
    var columns: String,
    var heading: String,
    var submenu: String,
    var _sql: String?,
)

data class MenuNestedItem(
    val label: String,
    val items: Array<MenuNestedItem> = emptyArray(),
    val callback: Any? = null,
    val sx: Any? = object {
        val color = "#0033cc"
        val bgcolor = "#c6ecc6"
    }
)

val scope = MainScope()
var urlInput = ""
var urlQuerys = ""
var contextGreed = mapOf<String, String>()
var queryCurrent: Query? = null
var NewValue = mutableMapOf<String, String>()
var currentPlaceholder = ""
var sorted = 0
var adminState = false
var v_querys = "v_querys"
var endpoint_service_url: String? = null
var useEffectMap = mutableMapOf<String, (Any) -> Unit>()
val endpoint = window.location.origin
var rowFieldsValueString: String = ""
var dateFrom: String = DATE_MIN
var dateTo: String = DATE_MAX
var queriesLoaded = emptyArray<Query>()
var queryHistory = emptyList<Triple<String, String, String>>().toMutableList()
var historyCurrent = -1
var gridApi: ApiAG? = null
var src: String = ""
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
    val titlesList = useStateMap(emptyArray<Query>(), "titlesList")
    val titleCurrent = useStateMap("", "titleCurrent")
    val resultUpdate = useStateMap("", "resultUpdate")
    val showButton = useStateMap(HIDE, "showButton")

    useEffectOnce {
        showNav = getParameter("m") ?: SHOW
        scope.launch {
            startEnv = loadByPost(LOADENV, endpoint).body()
            endpoint_service_url = getParameter(ENDPOINT_SERVICE_URL) ?: startEnv[ENDPOINT_SERVICE_URL] ?: ""
            startEnv.putAll(loadByPost(LOADENV, endpoint_service_url).body())
            println("rezLoad=${decodeJson(startEnv.toString())}")
            v_querys = getParameter("v") ?: VIEW_QUERY
            urlQuerys = "$ROUTE_BD/$QUERY_BD/$JSON_PG/$v_querys/${getParameter("w") ?: " and left(name,2)!='--'"}"
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
                    refreshRow(gridApi, rowList)
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

    fun submenuByQueryCreate(submenus: List<String>): Array<MenuNestedItem> {
        return submenus
            .distinct()
            .sortedBy { it }
            .map { submenu ->
                titlesList
                    .sortedWith(compareBy<Query> { it.submenu }
                        .thenBy { it.heading })
                    .filter { submenu == it.submenu }
                    .map { query ->
                        if (query.name != "" && query.name != SUBMENU)
                            listOf(MenuNestedItem(decodeJson(query.heading), callback = {
                                contextGreed = contextGreed + ("selectedTable" to query.name)
                                if (query.heading.contains(NEW_TAB))
                                    window.open(
                                        if (query.name.endsWith("_link"))
                                            decodeJson(query.query)
                                        else
                                            "${window.location.origin}?q=${query.name}&$ROW_FIELDS_VALUE_PARAM=${rowFieldsValueString.ifEmpty { "{}" }}"
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
                    id = DATE_FROM;label = DATE_FROM; defaultValue = DATE_MIN
                    onChange = { e ->
                        dateFrom = e.asDynamic().target.value.toString()
                        refreshMenuItems(false)
                    }
                }
                FieldDateFC {
                    id = DATE_TO;label = DATE_TO; defaultValue = DATE_MAX
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
            }
        }
        img {
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
                    if ((sorted == 0))
                        gridApi.paginationGoToLastPage()
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
                        refreshRow(gridApi, rowList)
                        viewResult(rez)
                        if (urlInput.contains(v_querys))
                            refreshMenuItems()
                    }
            }
        }
    }

    fun menuItemsCreate() = MenuNestedItem(
        "Menu", submenuByQueryCreate(
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
                        rowClassRules = object {
                            var cl1 = { params: ParamsAG -> params.data.status == "admin" }
                            var cl2 = { params: ParamsAG -> params.data.status == "foodmaker" }
                            var cl3 = { params: ParamsAG -> params.data.status == "feedmaker" }
                        }
                        suppressClickEdit = true
                        enableRangeSelection = true
                        enableRangeHandle = true
                        enableFillHandle = true
                        onGridReady = { params: ParamsAG -> gridApi = params.api }
                        onCellClicked = cellClicked(rowList, editIcon)
                        onCellValueChanged = valueChanged(rowList)
                        onCellDoubleClicked = cellDoubleClicked(rowList, editIcon)
                        onRowSelected = rowSelected()
                        onCellMouseOver = {}
                        onCellKeyPress = {}
                        onCellKeyDown = {e:dynamic ->
                            println("onCellKeyPress=${e.event.key}")
                            if (e.event.key == "F9" && src.isNotEmpty())
                                jsr223(src)
                        }
                        onSortChanged = {
                            when (sorted) {
                                0 -> sorted = 1
                                1 -> sorted = 2
                                2 -> sorted = 0
                            }
                        }
                    }
                }
            }

    navBar()
    info()
    rowsGreed()
} // FC<Props>




