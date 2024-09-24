@file:Suppress("UnsafeCastFromDynamic", "unused")

import io.ktor.client.call.*
import react.*
import kotlinx.browser.window
import kotlinx.coroutines.*
import kotlinx.datetime.internal.JSJoda.LocalDate
import kotlinx.datetime.internal.JSJoda.DateTimeFormatter
import kotlinx.datetime.internal.JSJoda.Instant
import kotlinx.datetime.internal.JSJoda.ZoneId
import kotlin.js.Date
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import kotlin.js.json

var dateFormat: String? = null

fun ChildrenBuilder.shareButtons() {
    "$endpoint?q=${urlInput.replace(" ", "%20")}"
        .let { urlFull ->
            emailShareButton {
                url = urlFull
                emailIcon {
                    size = HEIGHT.toInt()
                    round = false
                }
            }
            telegramShareButton {
                url = urlFull
                telegramIcon {
                    size = HEIGHT.toInt()
                    round = true
                }
            }
            viberShareButton {
                url = urlFull
                viberIcon {
                    size = HEIGHT.toInt()
                    round = true
                }
            }
            vkShareButton {
                url = urlFull
                vkIcon {
                    size = HEIGHT.toInt()
                    round = true
                }
            }
            whatsappShareButton {
                url = urlFull
                whatsappIcon {
                    size = HEIGHT.toInt()
                    round = true
                }
            }
        }
}

suspend fun refreshRow(
    gridApi: ApiAG?,
) {
    formGreed(urlInput)
    NewValue.clear()
    gridApi!!.redrawRows()
}

fun addNewQuery(
    rowList: Array<Any>,
    newTitle: String
) {
    arrayOf(
        json(Pair("id",0))
            .add(json(Pair("name",encodeJson(if (newTitle != "") newTitle else urlInput.split("/").last()))))
            .add(json(Pair("query",encodeJson(urlInput))))
            .add(json(Pair("columns",getColumns(rowList)
                .joinToString("") {
                    encodeJson("$it;\n")
                })))
            .add(json(Pair("heading",encodeJson(if (newTitle != "") newTitle else urlInput.split("/").last()))))
            .add(json(Pair("submenu",CONSTRUCTION)))
            .add(json(Pair("_sql",null)))
            .unsafeCast<QueryI>()
    ).let { newQuery ->
        scope.launch {
            setStateMap("resultUpdate", TRYING_TO_SAVE)
            delay(1000)
            val rez = saveRow(newQuery, mapOf("0" to "ins"), urlQuerys, endpoint_service_url).body<String>()
            viewResult(rez)
            refreshMenuItems()
        }
    }
}

suspend fun viewResult(rez: String) {
    if (rez == UPDATE_BASE_SUCCESS) {
        setStateMap("resultUpdate", UPDATE_BASE_SUCCESS)
        delay(3000)
        setStateMap("resultUpdate", "")
    } else
        window.alert(rez)
}

fun cellClicked(editIcon: String) = { params: ParamsAG ->
    if (editIcon == EDIT_YES)
        edit(params.api)
}

fun rowSelected() = { params: ParamsAG ->
    if (params.node.selected) {
        rowFieldsValueMap.clear()
        params.api.getAllGridColumns()
            .filter {
                !it.colId.startsWith("_") // not save field
                        && it.colDef.cellEditor != "agLargeTextCellEditor"
            }
            .forEach {
                rowFieldsValueMap[it.colId] =  // !! filling  !!
                    (params.node.data[it.colId] ?: "").toString()
            }
        refreshMenuItems(false)
    }
}

fun valueChanged(rowList: Array<Any>) = { params: ParamsAG ->
    // newValue ALWAYSE Strings !!?? - problem in BigQuery (string to int,float and vice versa)
    params.data[params.colDef.field] =
        js("params.oldValue != undefined && params.oldValue.length == undefined ? parseFloat(params.newValue) : ''+params.newValue")

    with(params.node.id) {
        rowList[this] = params.data
        if (NewValue[this] == null)
            NewValue[this] = "upd"
        else if (NewValue[this] == "copy")
            NewValue[this] = "ins"
    }
    params.api.redrawRows()
}

fun cellDoubleClicked(editIcon: String) = { params: ParamsAG ->
    if (params.api.getAllDisplayedColumns()[0].colId == params.column.colId) // first column
        deleteRows(params.api)
    if (editIcon != EDIT_YES)
    // https://www.w3schools.com/howto/howto_js_copy_clipboard.asp
        window.navigator.clipboard.writeText(params.data[params.colDef.field])
}

fun edit(gridApi: dynamic) {
    gridApi.startEditingCell(
        json(Pair("rowIndex",gridApi.getFocusedCell().rowIndex))
            .add(json(Pair("colKey",gridApi.getFocusedCell().column)))
    )
}

fun deleteRows(gridApi: ApiAG?) =
    gridApi!!.getSelectedNodes()
        .let { nodes ->
            nodes.forEach { node: dynamic ->
                if (NewValue[node.id] == "del")
                    NewValue.remove(node.id)
                else
                    NewValue[node.id] = "del"
            }
            gridApi.redrawRows()
        }

suspend fun arrayOfColumnDefs(rows: Array<Any>): Array<Any> =
    when {
        (JSON.stringify(rows[0]).contains(ERROR_FIELD)) -> listOf("field: error")
        (queryCurrent != null && queryCurrent?.columns != "") ->
            queryCurrent?.columns
                ?.let { decodeJson(it) }
                ?.split(";")

        else -> getColumns(rows)
    }
        ?.filter { it.isNotBlank() }
        ?.mapIndexed { i, columnStr ->
            columnStr.split(",")
                .associate { nameValue(it).let{it.name to  it.value}}
                .let { columnMap ->
                    val cellEditorParams = setEditor(columnMap["cellEditor"], columnMap["cellEditorParams"] ?: "")
                    json(Pair("field", "${columnMap["field"]}"))
                        .add(json(Pair("headerName", "${columnMap["headerName"] ?: columnMap["field"]}")))
                        .add(json(Pair("filter", columnMap["filter"] ?: "agTextColumnFilter")))
                        .add(json(Pair("sortable", (columnMap["sortable"] ?: "true") == "true")))
                        .add(json(Pair("comparator", if ((columnMap["field"] ?: "").contains("date")) {dateFormat = columnMap["dateFormat"];dateComparator()} else null)))
                        .add(json(Pair("editable", (columnMap["editable"] ?: "true") == "true")))
                        .add(json(Pair("type", columnMap["type"])))
                        .add(json(Pair("headerClass", columnMap["headerClass"])))
                        .add(json(Pair("resizable", (columnMap["resizable"] ?: "true") == "true")))
                        .add(json(Pair("width", columnMap["width"]?.toInt())))
                        .add(json(Pair("pinned", columnMap["pinned"])))
                        .add(json(Pair("rowDrag", (columnMap["rowDrag"] ?: "false") == "true")))
                        .add(json(Pair("checkboxSelection", (columnMap["checkboxSelection"] ?: "false") == "true")))
                        .add(json(Pair("cellEditor", columnMap["cellEditor"])))
                        .add(json(Pair("cellEditorPopup", columnMap["cellEditor"] == "agLargeTextCellEditor")))
                        .add(json(Pair("cellEditorParams", cellEditorParams))) // lookup list
                        .add(json(Pair("colSpan", columnMap["colSpan"])))
                        .add(json(Pair("flex", columnMap["flex"]?.toInt())))
                        .add(json(Pair("headerTooltip", columnMap["headerTooltip"])))
                        .add(json(Pair("wrapText", (columnMap["wrapText"] ?: "false") == "true")))
                        .add(json(Pair("autoHeight", (columnMap["autoHeight"] ?: "false") == "true")))
                        .add(json(Pair("minWidth", columnMap["minWidth"]?.toInt())))
                        .add(json(Pair("headerCheckboxSelection", i == 0)))
                        .add(json(Pair("headerCheckboxSelectionFilteredOnly", true)))
                        .add(json(Pair("filterParams", json(Pair("comparator",filterParams())))))
                        .add(json(Pair("cellClass", getCellClass(columnMap["cellClass"]))))
                        .add(json(Pair("valueGetter", getValueGetter(columnMap["field"]))))
                }
        }
        .also{it?.first()?.add(json(Pair("sort", "asc")))}
        ?.toTypedArray() ?: arrayOf()

private fun getValueGetter(fieldName: String?) = { params: ParamsAG ->
    val value = "" + params.data[fieldName]
    if (value.contains("@@"))
        decodeJson(value)
    else
        params.data[fieldName]
}

private fun getCellClass(cellClass: String? = "") = { params: ParamsAG ->
    when (NewValue[params.node.id]) { // not work text-decoration in getRowClass
        "upd" -> "updatedClass"
        "del" -> "deleteClass"
        "copy" -> "copyClass"
        "ins" -> "insertClass"
        else -> ""
    } + " " + cellClass
}

fun filterParams() = { filterLocalDateAtMidnight: Date, cellValue: String ->
    println("cellValue=$cellValue")
    strToDate(cellValue).compareTo(fromDateToLocalDate(filterLocalDateAtMidnight))
}

fun fromDateToLocalDate(date: Date): LocalDate { // https://refactorizando.com/en/convert-date-localdate-localdatetim-java/
    return Instant.ofEpochMilli(date.getTime())
        .atZone(ZoneId.systemDefault())
        .toLocalDate()
}

fun strToDate(cellValue: String) = run {
    dateFormat = dateFormat ?:
    if (cellValue.indexOf(".") == 2 && cellValue.length == 10)
        "dd.MM.yyyy"
    else if (cellValue.indexOf("/") == 2 && cellValue.length == 10)
        "dd/MM/yyyy"
    else if (cellValue.indexOf("-") == 2 && cellValue.length == 10)
        "dd-MM-yyyy"
    else if (cellValue.indexOf("/") == 4  && cellValue.length > 18)
        "yyyy/MM/dd'T'HH:mm:ss"
    else if (cellValue.indexOf(".") == 4  && cellValue.length > 18)
        "yyyy.MM.dd'T'HH:mm:ss"
    else "yyyy-MM-dd'T'HH:mm:ss"
    cellValue
        .let { if (it.length > 19) it.slice(0..18) else it }  // delete all after second
        .let { LocalDate.parse(it, DateTimeFormatter.ofPattern(dateFormat!!)) }
}

fun dateComparator() =
    { date1: String, date2: String ->
        strToDate(date1).compareTo(strToDate(date2))
    }

suspend fun setEditor(editorType: String?, editorParam: String) = run {
    (if (editorParam.contains("v_")) { //  dropdown list from view in base
        println("LookUp:urlInput=$urlInput; editorParam=$editorParam")
        fetchArray<dynamic>("${urlInput.split(JSON_PG).first()}$JSON_PG/$editorParam")
            .map { it.param }.toTypedArray()
    } else
        editorParam.split(".").toTypedArray())
        .let {
            when (editorType) {
                "agLargeTextCellEditor" ->
                    json(Pair("maxLength", "1000"))
                        .add(json(Pair("rows", "10")))
                        .add(json(Pair("cols", "60")))

                "agSelectCellEditor" -> json(Pair("values", it))
                else -> null
            }
        }
}

fun lunchQuery(
    input: String?,
    fieldsValue: String = rowFieldsValueString,
) =
    input?.ifBlank { null }?.let { _ ->
        rowFieldsValueString = if (rowFieldsValueMap.size == 2)
            getParameter(ROW_FIELDS_VALUE_PARAM) ?: ""
        else
            fieldsValue
        if (rowFieldsValueString.isNotEmpty())
            rowFieldsValueMap = Json.decodeFromString(rowFieldsValueString)
        urlInput = input
        scope.launch {
            setStateMap("resultUpdate", TRYING_TO_FETCH)
            setStateMap("colList", arrayOf<Any>())
            setStateMap("rowList", arrayOf<Any>())
            setStateMap("showButton", HIDE)
            queryCurrent = null
            (if (!input.contains("/")) {
                println("input=$input")
                queriesLoaded.find { it.name == decodeJson(input) }
                    ?.let { query ->
                        if (query.name == VIEW_QUERY) query.query = urlQuerys // list queries
                        queryCurrent = query
                        queryCurrent?.query
                            ?.let { "${decodeJson(it)}${if (queryCurrent?._sql != null) "?name=${queryCurrent?.name}" else ""}" }
                            ?.also { urlInput = insertParameterValue(it) }
                    } ?: run { window.alert("$ERROR_IN_FETCH -> $NOT_FOUND_QUERY_NAME $input");null }
            } else input)
                ?.let { query ->
                    formGreed(query)
                    addToHistory(query)
                }
            setStateMap("resultUpdate", "")
            delay(500)
            gridApi!!.getDisplayedRowAtIndex(0).setSelected(true)
        }
    }

private suspend fun formGreed(query: String, fieldsValue: String = rowFieldsValueString) {
    NewValue.clear()
    fetchArray<Any>(query, fieldsValue)
        .also { rows ->
            setStateMap("colList", arrayOfColumnDefs(rows))
            setStateMap("rowList", rows)
            setStateMap("editIcon", EDIT_NO)
        }
    queryCurrent?.name?.let { name ->
        if ((query.contains(JSON_PG)
                    && !(queryCurrent?.query ?: "").contains(v_querys)  // blocking edit v_querys
                    && !query.contains(v_querys)  // blocking edit v_querys
                    && !name.endsWith("_ro"))// read only (no edit)
            || ((v_querys.endsWith(name) || name.endsWith(v_querys)) && adminState)  // Unblocking edit v_querys
        )
            setStateMap("showButton", SHOW)
    }
}

private fun addToHistory(query: String) {
    insertParameterValue(
        decodeJson(queriesLoaded.find { q -> q.name == queryCurrent?.name }?.heading ?: query))
        .let { headerWithParam ->
            queryHistory.indexOfFirst {
                (it.second == (queryCurrent?.name ?: query)
                        && it.third == headerWithParam)
            }
                .let {
                    historyCurrent = if (it >= 0) it
                    else {
                        queryHistory.add(Triple(rowFieldsValueString, queryCurrent?.name ?: query, headerWithParam))
                        setStateMap("titleCurrent", headerWithParam)
                        queryHistory.size - 1
                    }
                }
        }
}

fun getColumns(rows: Array<Any>) =
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
                                            .last() != '"' -> ",type: numericColumn, width: 90, headerClass: ag-right-aligned-header, cellClass: ag-right-aligned-cell, filter: agNumberColumnFilter " // numeric
                                        field.contains("date") -> ", width: 140, filter: agDateColumnFilter " // date
                                        else -> "" // other
                                    }
                        }
                }
        }

suspend fun <T> fetchArray(urlIn: String, fieldsValue: String = rowFieldsValueString) =
    coroutineScope {
        (if (urlIn.startsWith(HTTP) || endpoint_service_url?.isBlank() != false) urlIn
        else "${endpoint_service_url}/$urlIn")
            .let { "$it${if (it.contains("?")) "&" else "?"}$ROW_FIELDS_VALUE_PARAM=${fieldsValue.ifEmpty { "{}" }}" }
            .let { url ->
                println("URL=$url")
                runCatching {
                    window.fetch(url)
                        .await()
                        .json()
                        .await()
                        .unsafeCast<Array<T>>()
                }.onFailure {
                    window.alert("w$ERROR_IN_FETCH URL=${decodeJson(url)}\n ${it.message}")
                    setStateMap("resultUpdate", "")
                }.getOrNull() as Array<T>
            }
    }

fun setStateMap(whatSet: String, value: Any) = useEffectMap[whatSet]?.let { it(value) }

fun <T> useStateMap(initValue: T, name: String) = run {
    val (currentValue, setState) = useState(initValue)
    @Suppress("UNCHECKED_CAST")
    useEffectMap[name] = setState as (Any) -> Unit // https://www.geeksforgeeks.org/kotlin-higher-order-functions/
    currentValue
}

fun cellMouseOver() = { params: ParamsAG -> // not in use now
    window.alert(
        "\n params.colDef.field=" + params.colDef.field +
                "\n params.newValue=" + params.newValue +
                "\n params.rowIndex=" + params.rowIndex +
                "\n params.data[\"id\"]=" + params.data["id"] +
                "\n params.data.id=" + params.data.id
    )
}

fun getElementValue(elementId: String, itemName: String = "value") =
    window.document.getElementById(elementId)?.attributes?.getNamedItem(itemName)?.value

fun refreshMenuItems(load: Boolean = true, first: Boolean = false) =
    scope.launch {
        rowFieldsValueMap[DATE_FROM] = dateFrom
        rowFieldsValueMap[DATE_TO] = dateTo
        rowFieldsValueString = Json.encodeToString(rowFieldsValueMap)
        if (load) {
            setStateMap("resultUpdate", TRYING_TO_FETCH)
            fetchArray<QueryI>(urlQuerys)
                .let {
                    val error: dynamic = it[0]
                    if (it.size == 1) // error in fetch
                        startEnv[QUERY_BD]?.let {
                            window.alert("loadMenuItems Error\n\n" + decodeJson(error["error"]))
                        }
                    else
                        queriesLoaded = it
                }
            setStateMap("resultUpdate", "")
        }
        setStateMap("titlesList", queriesLoaded
            .filter { !it.name.endsWith("_") } //  - connection string (in SQL field)
            .map {
                object : QueryI {
                    override var id: Int = it.id
                    override var name: String = it.name
                    override var query: String = it.query
                    override var columns: String = it.columns
                    override var heading: String = insertParameterValue(it.heading)
                    override var submenu: String = it.submenu
                    override var _sql: String? = it._sql
                }
            }
            .filter { !it.heading.contains("{") }  // block not inserted parameters  ( {..} )
            .toTypedArray()
        )
        if (first) lunchQuery(
            getParameter(FIRSTQUERY) ?: startEnv[FIRSTQUERY],
            getParameter(ROW_FIELDS_VALUE_PARAM) ?: ""
        )
    }

fun jsr223(cellValue: String) {
    scope.launch {
        rowFieldsValueMap["src"] = cellValue
        val rez = loadByPost(JSR223,endpoint, rowFieldsValueMap).body<String>()
        if (rez.isNotEmpty())
            window.alert(rez)
    }
}