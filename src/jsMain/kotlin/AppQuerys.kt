@file:Suppress("UnsafeCastFromDynamic")

import kotlinext.js.jsObject
import react.*
import react.dom.*
import kotlinx.browser.window
import kotlinx.html.js.*
import kotlinx.coroutines.*
import kotlinx.datetime.LocalDate
import kotlinx.html.*
import kotlin.js.Date

data class Query(
    var id: Int,
    var name: String,
    var query: String,
    var columns: String,
    var heading: String,
    var submenu: String,
    var _sql: String?,
)

data class Param(var param: String)

private val scope = MainScope()
private var urlInput = ""
private var routeQuery = ""
private var contextGreed = mapOf<String, String>()
private var queryTableDef: Query? = null
private var NewValue = mutableMapOf<String, String>()
private var placeholder = ""
private var sorted = 0
private var adminState = false
private var v_querys = "v_querys"
private var useEffectMap = mutableMapOf<String, RSetState<String>>()

suspend fun <T> fetchArray(url: String): Array<T> = coroutineScope {
    let {
        if (url.contains("http")) url
        else endpoint.replace("80|82|81".toRegex(), "90") + "/" + url
    }
        .let { url ->
            println("URL=$url")
            runCatching {
                window.fetch(url)
                    .await()
                    .json()
                    .await()
                    .unsafeCast<Array<T>>()
            }.onFailure {
                window.alert("$ERROR_IN_FETCH URL=$url\n ${it.message}")
            }.getOrNull() as Array<T>
        }
}

val AppClients = functionalComponent<RProps> { _ ->
    val (gridApi, setGridApi) = useState<ApiAG?>(null)
    val (rowList, setRowList) = useState(emptyArray<Any>())
    val (colList, setColList) = useState(emptyArray<Any>())
    val (titlesList, setTitlesList) = useState(emptyArray<Query>())
    val resultUpdate = useStateMap("", "setResultUpdate")
    val showButton = useStateMap(HIDE, "setShowButton")
    val showInput = useStateMap(HIDE, "setShowInput")
    val showNav = useStateMap(HIDE, "setShowNav")
    val editIcon = useStateMap(EDIT_NO, "setEditIcon")

    useEffect(dependencies = listOf()) { //  execute only ONE
        effectMap("setShowNav", getParameter("m") ?: SHOW)
        scope.launch {
            startEnv = loadByPost(LOADENV, "")
            println("rezLoad=${decodeJson(startEnv.toString())}")
            v_querys = getParameter("v") ?: VIEW_QUERY
            routeQuery = "$ROUTE_BD/$QUERY_BD/$JSON_PG/$v_querys/${getParameter("w") ?: ""}"
            println("routeQuery=$routeQuery")
            println("search=${window.location.search}")
            loadMenuItems(setTitlesList)
            lunchQuery(setColList, setRowList, getParameter(FIRSTQUERY) ?: startEnv[FIRSTQUERY])
        }
    }
    nav(showNav) {
        ul("topmenu") {
            titlesList
                .filter {
                    it.name == ""
                }
                .map {
                    it.submenu
                }.also {
                    submenuCreate(it, titlesList, setColList, setRowList)
                }
            li(getParameter("s") ?: SHOW) {
                a {
                    +"Service ▼"
                }
                ul("submenu") {
                    li {
                        a {
                            +"New query"
                            attrs {
                                onClickFunction = {
                                    setPlaceholder(URI_FOR_QUERY, showInput)
                                }
                            }
                        }
                    }
                    li {
                        a {
                            +"Add Query to $CONSTRUCTION"
                            attrs.onClickFunction = {
                                setPlaceholder(TITLES_FOR_QUERY, showInput)
                            }
                        }
                    }
                    li {
                        a {
                            +ADMIN_PASSW
                            attrs.onClickFunction = {
                                setPlaceholder(ADMIN_PASSW, showInput)
                            }
                        }
                    }
                    div(showInput) {
                        inputAny(setRowList, setColList, placeholder, rowList, setTitlesList)
                    }
                    div { +urlInput }
                    div {
                        "$endpoint?q=${urlInput.replace(" ", "%20")}"
                            .let { urlFull ->
                                emailShareButton {
                                    attrs.url = urlFull
                                    emailIcon {
                                        attrs.size = 40
                                        attrs.round = false
                                    }
                                }
                                telegramShareButton {
                                    attrs.url = urlFull
                                    telegramIcon {
                                        attrs.size = 40
                                        attrs.round = true
                                    }
                                }
                                viberShareButton {
                                    attrs.url = urlFull
                                    viberIcon {
                                        attrs.size = 40
                                        attrs.round = true
                                    }
                                }
                                vkShareButton {
                                    attrs.url = urlFull
                                    vkIcon {
                                        attrs.size = 40
                                        attrs.round = true
                                    }
                                }
                                whatsappShareButton {
                                    attrs.url = urlFull
                                    whatsappIcon {
                                        attrs.size = 40
                                        attrs.round = true
                                    }
                                }
                            }
                    }
                    div { +(startEnv[GITVERSION] ?: "") }
                }
            }
            img {
                attrs {
                    src = "img/help.png"
                    height = "40"
                    onClickFunction = {
                        window.open("help.html")
                    }
                }
            }
            span{refreshSpan(setRowList, gridApi, rowList, 40)}
            img {
                attrs {
                    src = "img/$editIcon.jpg"
                    height = "40"
                    classes = setOf(showButton)
                    onClickFunction = {
                        effectMap(
                            "setEditIcon",
                            if (editIcon == EDIT_NO)
                                EDIT_YES
                            else EDIT_NO
                        )
                    }
                }
            }
            img {
                attrs {
                    src = "img/delete.png"
                    height = "40"
                    classes = setOf(showButton)
                    onClickFunction = {
                        deleteRows(gridApi)
                    }
                }
            }
            img {
                attrs {
                    src = "img/copy.png"
                    height = "40"
                    classes = setOf(showButton)
                    onClickFunction = {
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
                                    setRowList(catTwoArrays(rowList, it.toTypedArray()))
                                }
                            if ((sorted == 0))
                                gridApi.paginationGoToLastPage()
                        }
                    }
                }
            }
            img {
                attrs {
                    src = "img/save.png"
                    height = "40"
                    classes = setOf(if (editIcon == EDIT_NO) HIDE else SHOW)
                    onClickFunction = {
                        if (NewValue.isNotEmpty() && window.confirm(SAVE_TO_SERVER))
                            scope.launch {
                                effectMap("setResultUpdate", TRYING_TO_SAVE)
                                delay(1000)
                                val rez = saveRow(rowList, NewValue, urlInput)
                                refreshRow(setRowList, gridApi, rowList)
                                viewResult(rez)
                                if (urlInput.contains(v_querys))
                                    loadMenuItems(setTitlesList)
                            }
                    }
                }
            }
        }
    }
    span {
        refreshSpan(setRowList, gridApi, rowList, 20)
        span("cl3") { +resultUpdate }
        span("title") {
            +(decodeJson(queryTableDef?.heading ?: ""))
        }
    }
    rowsGreed(rowList, colList, setGridApi, contextGreed, editIcon)
}

private fun RDOMBuilder<SPAN>.refreshSpan(
    setRowList: RSetState<Array<Any>>,
    gridApi: ApiAG?,
    rowList: Array<Any>,
    heightRow: Int
) {
    img {
        attrs {
            src = "img/refresh.png"
            height = "$heightRow"
            onClickFunction = {
                scope.launch {
                    effectMap("setResultUpdate", TRYING_TO_FETCH)
                    refreshRow(setRowList, gridApi, rowList)
                    effectMap("setResultUpdate", "")
                }
            }
        }
    }
}

private fun setPlaceholder(currentPlaceholder: String, showInput: String) {
    placeholder = currentPlaceholder
    effectMap("setShowInput", if (showInput == HIDE) SHOW else HIDE)
}

private fun loadMenuItems(setTitlesList: RSetState<Array<Query>>) =
    scope.launch {
        fetchArray<Query>(routeQuery)
            .let { queries ->
                val error: dynamic = queries[0]
                if (queries.size == 1) // error in fetch
                    window.alert("loadMenuItems Error\n\n" + decodeJson(error["error"]))
                else
                    setTitlesList(queries)
            }
    }

private fun RDOMBuilder<UL>.submenuCreate(
    submenus: List<String>,
    titlesList: Array<Query>,
    setColList: RSetState<Array<Any>>,
    setRowList: RSetState<Array<Any>>,
) {
    submenus
        .distinct()
        .sortedBy { it }
        .forEach { submenu ->
            li {
                a { +("$submenu ▼") }
                ul("submenu") {
                    titlesList
                        .sortedWith(compareBy<Query> { it.submenu }
                            .thenBy { it.heading })
                        .filter {
                            val heading = decodeJson(it.heading)
                            submenu == it.submenu && !heading.split(",").contains(submenu)
                        }
                        .forEach { query ->
                            if (query.name != "" && query.name != SUBMENU)
                                li {
                                    a {
                                        +decodeJson(query.heading)
                                        if (!query.heading.contains(NEW_TAB))
                                            attrs.onClickFunction = {
                                                contextGreed = contextGreed + ("selectedTable" to query.name)
                                                lunchQuery(setColList, setRowList, query.name)
                                            }
                                        else {
                                            attrs.target = "_blank"
                                            attrs.href = if (query.query.endsWith(".json")
                                                || !query.query.startsWith("http")
                                            )
                                                "${window.location.origin}?q=${query.name}&m=hide"
                                            else
                                                decodeJson(query.query)
                                        }
                                    }
                                } else
                                if (query.heading.isNotBlank())
                                    submenuCreate(
                                        decodeJson(query.heading).split(","),
                                        titlesList,
                                        setColList,
                                        setRowList,
                                    )
                        }
                }
            }
        }
}

private suspend fun refreshRow(
    setRowList: RSetState<Array<Any>>,
    gridApi: ApiAG?,
    rowList: Array<Any>
) {
    setRowList(fetchArray(urlInput)) // refresh from server
    NewValue.clear()
    gridApi!!.redrawRows(rowList)
}

private fun addNewQuery(
    rowList: Array<Any>,
    setTitlesList: RSetState<Array<Query>>,
    newTitle: String
) {
    arrayOf(
        Query(
            0,
            encodeJson(if (newTitle != "") newTitle else urlInput.split("/").last()),
            encodeJson(urlInput),
            getColumns(rowList).joinToString("") {
                encodeJson("$it;\n")
            },
            encodeJson(if (newTitle != "") newTitle else urlInput.split("/").last()),
            CONSTRUCTION,
            null
        )
    ).let { newQuery ->
        scope.launch {
            effectMap("setResultUpdate", TRYING_TO_SAVE)
            delay(1000)
            val rez = saveRow(newQuery, mapOf("0" to "ins"), routeQuery)
            viewResult(rez)
            loadMenuItems(setTitlesList)
        }
    }
}

private suspend fun viewResult(rez: String) {
    if (rez == UPDATE_BASE_SUCCESS) {
        effectMap("setResultUpdate", UPDATE_BASE_SUCCESS)
        delay(3000)
        effectMap("setResultUpdate", "")
    } else
        window.alert(rez)
}

private fun <T> catTwoArrays(array1: Array<T>, array2: Array<T>): Array<T> = array1 + array2

private fun RBuilder.rowsGreed(
    rowList: Array<Any>,
    colList: Array<Any>,
    setGridApi: RSetState<ApiAG?>,
    contextMy: Map<String, String>,
    editIcon: String,
) =
    rowList.ifEmpty { null }
        .apply {
            div("ag-theme-alpine fullscreen${if ((getParameter("m") ?: SHOW) == HIDE) "WithoutMenu" else ""}") {//https://stackoverflow.com/questions/11163981/div-resizable-like-text-area
                agGreed {
                    columnDefs = colList
                    rowData = rowList
                    context = contextMy
                    headerHeight = 30
                    rowHeight = 30
                    rowDragManaged = true
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
                    onGridReady = { params: ParamsAG -> setGridApi(params.api) }
                    onCellClicked = cellClicked(editIcon)
                    onCellValueChanged = valueChanged(rowList)
                    onCellDoubleClicked = cellDoubleClicked()
                    onCellMouseOver = {}
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

private fun cellClicked(editIcon: String) = { params: ParamsAG ->
    if (editIcon == EDIT_YES)
        edit(params.api)
}

private fun valueChanged(rowList: Array<Any>) = { params: ParamsAG ->
    val node: dynamic = params.node
    val record: dynamic = rowList[node.id]
    record[params.colDef.field] = encodeJson(params.newValue)
    rowList[node.id] = record
    if (NewValue[node.id] == null)
        NewValue[node.id] = "upd"
    else if (NewValue[node.id] == "copy")
        NewValue[node.id] = "ins"
    val row = params.api.getDisplayedRowAtIndex(params.rowIndex)
    params.api.redrawRows(arrayOf(row))
}

private fun cellDoubleClicked() = { params: ParamsAG ->
    if (params.columnApi.getAllDisplayedColumns()[0].colId == params.column.colId)
        deleteRows(params.api)
}

private fun edit(gridApi: dynamic) {
    gridApi.startEditingCell(object {
        val rowIndex = gridApi.getFocusedCell().rowIndex
        val colKey = gridApi.getFocusedCell().column
    })
}

private fun deleteRows(gridApi: ApiAG?) =
    gridApi!!.getSelectedNodes()
        .let { nodes ->
            nodes.forEach { node: dynamic ->
                if (NewValue[node.id] == "del")
                    NewValue.remove(node.id)
                else
                    NewValue[node.id] = "del"
            }
            gridApi.redrawRows(nodes)
        }

suspend fun arrayOfColumnDefs(rows: Array<Any>): Array<Any> =
    when {
        (JSON.stringify(rows[0]).contains(ERROR_FIELD)) -> listOf("field: error")
        (queryTableDef != null && queryTableDef?.columns != "") ->
            queryTableDef?.columns
                ?.let { decodeJson(it) }
                ?.split(";")
        else -> getColumns(rows)
    }
        ?.filter { it.isNotBlank() }
        ?.mapIndexed { i, columnStr ->
            columnStr.split(",")
                .associate { it.split(":")[0].trim() to it.split(":")[1].trim() }
                .let { columnMap ->
                    val cellEditorParams = setEditor(columnMap["cellEditor"], columnMap["cellEditorParams"] ?: "")
                    object {
                        val headerName = columnMap["headerName"]
                        val field = columnMap["field"]
                        val filter = columnMap["filter"] ?: "agTextColumnFilter"
                        val sortable = (columnMap["sortable"] ?: "true") == "true"
                        val comparator = if ((field ?: "").contains("date")) dateComparator() else null// for sort
                        val editable = (columnMap["editable"] ?: "true") == "true"
                        val type = columnMap["type"]
                        val resizable = (columnMap["resizable"] ?: "true") == "true"
                        val width = columnMap["width"]?.toInt()
                        val pinned = columnMap["pinned"]
                        val rowDrag = (columnMap["rowDrag"] ?: "false") == "true"
                        val checkboxSelection = (columnMap["checkboxSelection"] ?: "false") == "true"
                        val cellEditor = columnMap["cellEditor"]
                        val cellEditorPopup = columnMap["cellEditor"] == "agLargeTextCellEditor"
                        val cellEditorParams = cellEditorParams
                        val colSpan = columnMap["colSpan"]
                        val flex = columnMap["flex"]?.toInt()
                        val headerTooltip = columnMap["headerTooltip"]
                        val wrapText = (columnMap["wrapText"] ?: "false") == "true"
                        val autoHeight = (columnMap["autoHeight"] ?: "false") == "true"
                        val minWidth = columnMap["minWidth"]?.toInt()
                        val headerCheckboxSelection = i == 0
                        val headerCheckboxSelectionFilteredOnly = true
                        val filterParams = object {
                            val comparator = filterParams() // for column type Date
                        }
                        val cellClass = { params: ParamsAG ->
                            when (NewValue[params.node.id]) { // not work text-decoration in getRowClass
                                "upd" -> "updatedClass"
                                "del" -> "deleteClass"
                                "copy" -> "copyClass"
                                "ins" -> "insertClass"
                                else -> ""
                            }
                        }
                        val valueGetter = { params: ParamsAG ->
                            val value = "" + params.data[field]
                            if (value.contains("@@"))
                                decodeJson(value)
                            else
                                params.data[field]
                        }
                        //valueSetter replace encodeJson(params.newValue) in valueChanged
                    }
                }
        }
        ?.toTypedArray() ?: arrayOf()

private fun filterParams() = { filterLocalDateAtMidnight: Date, cellValue: String? ->
    cellValue?.let {
        LocalDate(
            filterLocalDateAtMidnight.getFullYear(),
            filterLocalDateAtMidnight.getMonth() + 1, //todo  +1 ??
            filterLocalDateAtMidnight.getDate()
        ).let {
            strToDate(cellValue).compareTo(it)
        }
    } ?: -1
}

private fun strToDate(cellValue: String) =
    cellValue
        .replace("/", "-")
        .replace(".", "-")
        .split(" ")[0]
        .let { cellDateStr ->
            LocalDate(
                cellDateStr.split("-")[if (cellDateStr.split("-")[0].length == 4) 0 else 2].toInt(),
                cellDateStr.split("-")[1].toInt(),
                cellDateStr.split("-")[if (cellDateStr.split("-")[0].length == 4) 2 else 0].toInt()
            )
        }

private fun dateComparator() =
    { date1: String, date2: String ->
        strToDate(date1).compareTo(strToDate(date2))
    }

suspend fun setEditor(editorType: String?, editorParam: String) = run {
    (if (editorParam.contains("v_")) { //  dropdown list from view in base
        (urlInput.split("/").take(3) + editorParam).joinToString("/")
            .let { url ->
                fetchArray<Param>(url).map { it.param }.toTypedArray()
            }
    } else
        editorParam.split(".").toTypedArray())
        .let {
            when (editorType) {
                "agLargeTextCellEditor" -> object {
                    val maxLength = 1000
                    val rows = 10
                    val cols = 60
                }
                "agSelectCellEditor" -> object {
                    var values = it
                }
                else -> null
            }
        }
}

fun RBuilder.agGreed(handler: ReactGridProps.() -> Unit) =
    agGr {
        this.attrs(handler)
    }

private fun RBuilder.inputAny(
    setRowList: RSetState<Array<Any>>,
    setColList: RSetState<Array<Any>>,
    currentPlaceholder: String,
    rowList: Array<Any>,
    setTitlesList: RSetState<Array<Query>>,
) {
    child(
        InputComponent,
        props = jsObject {
            placeholder = currentPlaceholder
            onSubmit = { input ->
                when (placeholder) {
                    URI_FOR_QUERY ->
                        lunchQuery(setColList, setRowList, input)
                    TITLES_FOR_QUERY ->
                        addNewQuery(rowList, setTitlesList, input)
                    else -> scope.launch { adminState = checkPassw("$ROUTE_BD/$PASSW", input) }
                }
                effectMap("setShowInput", HIDE)
            }
        }
    )
}

private fun lunchQuery(
    setColList: RSetState<Array<Any>>,
    setRowList: RSetState<Array<Any>>,
    input: String?
) =
    input?.let {
        println("INPUT=$input")
        scope.launch {
            effectMap("setResultUpdate", TRYING_TO_FETCH)
            setColList(arrayOf())
            setRowList(arrayOf())
            effectMap("setShowButton", HIDE)
            (if (!input.contains("/")) {
                with(fetchArray<Query>("$routeQuery and name='${decodeJson(input)}'"))
                {
                    queryTableDef = if (isNotEmpty()) first() else {
                        window.alert("$ERROR_IN_FETCH -> $NOT_FOUND_QUERYNAME $it")
                        null
                    }
                    queryTableDef?.query
                        ?.let { "${decodeJson(it)}${if (queryTableDef?._sql != null) "?name=${queryTableDef?.name}" else ""}" }
                        ?.also { urlInput = it }
                }
            } else input)
                ?.let { nameQuery ->
                    NewValue.clear()
                    effectMap("setEditIcon", EDIT_NO)
                    fetchArray<Any>(nameQuery)
                        .also { rows ->
                            setColList(arrayOfColumnDefs(rows))
                            setRowList(rows)
                        }
                    queryTableDef?.name?.let { name ->
                        if ((nameQuery.contains(JSON_PG)
                                    && !(queryTableDef?.query ?: "").contains(v_querys)  // blocking edit v_querys
                                    && !nameQuery.contains(v_querys)  // blocking edit v_querys
                                    && !name.endsWith("_ro"))// read only (no edit)
                            || (name == v_querys && adminState)  // Unblocking edit v_querys
                        )
                            effectMap("setShowButton", SHOW)
                    }
                }
            effectMap("setResultUpdate", "")
        }
    }

private fun getColumns(rows: Array<Any>) =
    rows.ifEmpty { null }
        .let {
            JSON.stringify(rows[0])
                .split(",")
                .map {
                    it.trim().replace("[\n{}\"']".toRegex(), "").split(":")[0]
                        .let { field ->
                            "field:$field" +
                                    when {
                                        it.trim().replace("[\n }]".toRegex(), "")
                                            .last() != '"' -> ",type: numericColumn,filter: agNumberColumnFilter " // numeric
                                        field.contains("date") -> ",filter: agDateColumnFilter " // date
                                        else -> "" // other
                                    }
                        }
                }
        }

fun effectMap(whatSet: String, default: String) = useEffectMap[whatSet]?.invoke(default)

fun <T> useStateMap(initValue: T, name: String) = run{
    val (currentValue, setState) = useState(initValue)
    @Suppress("UNCHECKED_CAST")
    useEffectMap[name] = setState as RSetState<String>
    currentValue
}

private fun cellMouseOver(params: ParamsAG) { // not uses now
    if (params.colDef.field == "columns")
        window.alert(
            "\n newValue=" + params.newValue +
                    "\n field=" + params.colDef.field +
                    "\n rowIndex=" + params.rowIndex +
                    "\n data[\'name\']=" + params.data["name"] +
                    "\n data.columns=\n" + params.colDef.field
        )
}