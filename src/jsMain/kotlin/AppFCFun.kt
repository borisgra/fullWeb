@file:Suppress("UnsafeCastFromDynamic", "unused")

import io.ktor.client.call.*
import react.*
import kotlinx.browser.window
import kotlinx.coroutines.*
import kotlinx.datetime.LocalDate
import kotlinx.serialization.decodeFromString
import kotlin.js.Date
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

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
    rowList: Array<Any>
) {
    formGreed(urlInput)
    NewValue.clear()
    gridApi!!.redrawRows(rowList)
}

fun addNewQuery(
    rowList: Array<Any>,
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

fun cellClicked(rowList: Array<Any>, editIcon: String) = { params: ParamsAG ->
    if (editIcon == EDIT_YES)
        edit(params.api)
    val record: dynamic = rowList[params.node.id.toInt()]
    src = decodeJson(record[params.colDef.field].toString())
}

fun rowSelected() = { params: ParamsAG ->
    if (params.node.selected) {
        rowFieldsValueMap.forEach { if (!it.key.endsWith("_") ) rowFieldsValueMap.remove(it.key)}
        params.columnApi.getAllGridColumns()
            .filter {
                !it.colId.startsWith("_")
                        && it.colDef.cellEditor != "agLargeTextCellEditor"
            }
            .forEach {
                rowFieldsValueMap[it.colId] =
                    (params.node.data[it.colId] ?: "").toString()
            }
        refreshMenuItems(false)
    }
}

fun valueChanged(rowList: Array<Any>) = { params: ParamsAG ->
    val node = params.node
    val record: dynamic = rowList[node.id.toInt()]
    record[params.colDef.field] = encodeJson(params.newValue)
    rowList[node.id.toInt()] = record
    if (NewValue[node.id] == null)
        NewValue[node.id] = "upd"
    else if (NewValue[node.id] == "copy")
        NewValue[node.id] = "ins"
    val row = params.api.getDisplayedRowAtIndex(params.rowIndex)
    params.api.redrawRows(arrayOf(row))
}

fun cellDoubleClicked(rowList: Array<Any>, editIcon: String) = { params: ParamsAG ->
    val record: dynamic = rowList[params.node.id.toInt()]
    val cellValue = decodeJson(record[params.colDef.field].toString())
    if (editIcon != EDIT_YES)
        window.navigator.clipboard.writeText(cellValue) // https://www.w3schools.com/howto/howto_js_copy_clipboard.asp
    if (params.columnApi.getAllDisplayedColumns()[0].colId == params.column.colId)
        deleteRows(params.api)
    if (params.rowIndex == 0 && params.column.colId == "noiseparty_tag") { // for test only
        val pySrc =
            "import browser;from browser import document, alert ;browser.console.log('Hello Brython!');alert('from js-Brython !!!!')"
        println(pySrc)
        js("eval(__BRYTHON__.python_to_js(\"$pySrc\"));")
    }
    //    params.api.setFocusedCell(0, params.columnApi.getAllDisplayedColumns()[0], null) // example
}

fun edit(gridApi: dynamic) {
    gridApi.startEditingCell(object {
        val rowIndex = gridApi.getFocusedCell().rowIndex
        val colKey = gridApi.getFocusedCell().column
    })
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
            gridApi.redrawRows(nodes)
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

fun filterParams() = { filterLocalDateAtMidnight: Date, cellValue: String? ->
    cellValue?.let {
        LocalDate(
            filterLocalDateAtMidnight.getFullYear(),
            filterLocalDateAtMidnight.getMonth() + 1,
            filterLocalDateAtMidnight.getDate()
        ).let {
            strToDate(cellValue).compareTo(it)
        }
    } ?: -1
}

fun strToDate(cellValue: String) =
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

fun dateComparator() =
    { date1: String, date2: String ->
        strToDate(date1).compareTo(strToDate(date2))
    }

suspend fun setEditor(editorType: String?, editorParam: String) = run {
    (if (editorParam.contains("v_")) { //  dropdown list from view in base
        (urlInput.split("/").take(3) + editorParam).joinToString("/")
            .let { url ->
                data class Param(var param: String)
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
                queriesLoaded.find { it.name == decodeJson(input) }
                    ?.let { query ->
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
            || (name == v_querys && adminState)  // Unblocking edit v_querys
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
                                            .last() != '"' -> ",type: numericColumn,filter: agNumberColumnFilter " // numeric
                                        field.contains("date") -> ",filter: agDateColumnFilter " // date
                                        else -> "" // other
                                    }
                        }
                }
        }

suspend fun <T> fetchArray(urlIn: String, fieldsValue: String = rowFieldsValueString): Array<T> = coroutineScope {
    (if (urlIn.startsWith("http") || endpoint_service_url?.isBlank() != false) urlIn
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
            fetchArray<Query>(urlQuerys)
                .let {
                    val error: dynamic = it[0]
                    if (it.size == 1) // error in fetch
                        window.alert("loadMenuItems Error\n\n" + decodeJson(error["error"]))
                    else
                        queriesLoaded = it
                }
            setStateMap("resultUpdate", "")
        }
        setStateMap("titlesList", queriesLoaded
            .map {
                Query(
                    it.id, // IR error - protoOf.doResume_5yljmg_k$ (AppFCFun.kt:448:24)
                    it.name,
                    it.query,
                    it.columns,
                    insertParameterValue(it.heading),
                    it.submenu,
                    it._sql
                )
            }
            .filter { !it.heading.contains("^^1@@") }  // blocking not inserted parameters  ( {..} )
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